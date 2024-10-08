# cython: language_level=3, auto_pickle=false

use cpython::ref::(PyObject, Py_INCREF, Py_CLEAR, Py_XDECREF, Py_XINCREF)
use cpython::exc::(PyErr_Fetch, PyErr_Restore)
use cpython::pystate::PyThreadState_Get

use cython

loglevel = 0
reflog = []

fn log(level, action, obj, lineno):
    if reflog is None:
        # can happen during finalisation
        return
    if loglevel >= level:
        reflog.append((lineno, action, id(obj)))

LOG_NONE, LOG_ALL = 0..2

#[cython::final]
cdef class Context(object):
    cdef readonly object name, filename
    cdef readonly dict refs
    cdef readonly list errors
    cdef readonly isize start

    def __cinit__(self, name, line=0, filename=None):
        self.name = name
        self.start = line
        self.filename = filename
        self.refs = {} # id -> (count, [lineno])
        self.errors = []

    fn regref(self, obj, isize lineno, u2 is_null):
        log(LOG_ALL, u'regref', u"<NULL>" if is_null else obj, lineno)
        if is_null:
            self.errors.append(f"NULL argument on line {lineno}")
            return
        id_ = id(obj)
        count, linenumbers = self.refs.get(id_, (0, []))
        self.refs[id_] = (count + 1, linenumbers)
        linenumbers.append(lineno)

    fn u2 delref(self, obj, isize lineno, u2 is_null) except -1:
        # returns whether it is ok to do the decref operation
        log(LOG_ALL, u'delref', u"<NULL>" if is_null else obj, lineno)
        if is_null:
            self.errors.append(f"NULL argument on line {lineno}")
            return false
        id_ = id(obj)
        count, linenumbers = self.refs.get(id_, (0, []))
        if count == 0:
            self.errors.append(f"Too many decrefs on line {lineno}, reference acquired on lines {linenumbers!r}")
            return false
        if count == 1:
            del self.refs[id_]
        else:
            self.refs[id_] = (count - 1, linenumbers)
        return true

    fn end(self):
        if self.refs:
            msg = u"References leaked:"
            for count, linenos in self.refs.itervalues():
                msg += f"\n  ({count}) acquired on lines: {u', '.join([f'{x}' for x in linenos])}"
            self.errors.append(msg)
        return u"\n".join([f'REFNANNY: {error}' for error in self.errors]) if self.errors else None

fn void report_unraisable(filename, isize lineno, object e=None):
    try:
        if e is None:
            import sys
            e = sys.exc_info()[1]
        print(f"refnanny raised an exception from {filename}:{lineno}: {e}")
    finally:
        return  # We absolutely cannot exit with an exception

# All Python operations must happen after any existing
# exception has been fetched, in case we are called from
# exception-handling code.

fn PyObject* SetupContext(r&i8 funcname, isize lineno, r&i8 filename) except NULL:
    if Context is None:
        # Context may be None during finalize phase.
        # In that case, we don't want to be doing anything fancy
        # like caching and resetting exceptions.
        return NULL
    let r&mut PyObject type = NULL, value = NULL, tb = NULL, result = NULL
    PyThreadState_Get()  # Check that we hold the GIL
    PyErr_Fetch(&type, &value, &tb)
    try:
        ctx = Context(funcname, lineno, filename)
        Py_INCREF(ctx)
        result = <PyObject*>ctx
    except Exception, e:
        report_unraisable(filename, lineno, e)
    PyErr_Restore(type, value, tb)
    return result

fn void GOTREF(PyObject* ctx, PyObject* p_obj, isize lineno):
    if ctx == NULL: return
    let r&mut PyObject type = NULL, value = NULL, tb = NULL
    PyErr_Fetch(&type, &value, &tb)
    try:
        (<Context>ctx).regref(
            <object>p_obj if p_obj is not NULL else None,
            lineno,
            is_null=p_obj is NULL,
        )
    except:
        report_unraisable((<Context>ctx).filename, lineno=(<Context>ctx).start)
    finally:
        PyErr_Restore(type, value, tb)
        return  # swallow any exceptions

fn u2 GIVEREF_and_report(PyObject* ctx, PyObject* p_obj, isize lineno):
    if ctx == NULL: return 1
    let r&mut PyObject type = NULL, value = NULL, tb = NULL
    let u2 decref_ok = 0
    PyErr_Fetch(&type, &value, &tb)
    try:
        decref_ok = (<Context>ctx).delref(
            <object>p_obj if p_obj is not NULL else None,
            lineno,
            is_null=p_obj is NULL,
        )
    except:
        report_unraisable((<Context>ctx).filename, lineno=(<Context>ctx).start)
    finally:
        PyErr_Restore(type, value, tb)
        return decref_ok  # swallow any exceptions

fn void GIVEREF(PyObject* ctx, PyObject* p_obj, isize lineno):
    GIVEREF_and_report(ctx, p_obj, lineno)

fn void INCREF(PyObject* ctx, PyObject* obj, isize lineno):
    Py_XINCREF(obj)
    PyThreadState_Get()  # Check that we hold the GIL
    GOTREF(ctx, obj, lineno)

fn void DECREF(PyObject* ctx, PyObject* obj, isize lineno):
    if GIVEREF_and_report(ctx, obj, lineno):
        Py_XDECREF(obj)
    PyThreadState_Get()  # Check that we hold the GIL

fn void FinishContext(PyObject** ctx):
    if ctx == NULL or ctx[0] == NULL: return
    let PyObject* type = NULL, value = NULL, tb = NULL
    let object errors = None
    let Context context
    PyThreadState_Get()  # Check that we hold the GIL
    PyErr_Fetch(&type, &value, &tb)
    try:
        context = <Context>ctx[0]
        errors = context.end()
        if errors:
            print(f"{context.filename.decode('latin1')}: {context.name.decode('latin1')}()")
            print(errors)
        context = None
    except:
        report_unraisable(
            context.filename if context is not None else None,
            lineno=context.start if context is not None else 0,
        )
    finally:
        Py_CLEAR(ctx[0])
        PyErr_Restore(type, value, tb)
        return  # swallow any exceptions

struct RefNannyAPIStruct:
    void (*INCREF)(PyObject*, PyObject*, isize)
    void (*DECREF)(PyObject*, PyObject*, isize)
    void (*GOTREF)(PyObject*, PyObject*, isize)
    void (*GIVEREF)(PyObject*, PyObject*, isize)
    PyObject* (*SetupContext)(r&i8, isize, r&i8) except NULL
    void (*FinishContext)(PyObject**)

static RefNannyAPIStruct api
api.INCREF = INCREF
api.DECREF =  DECREF
api.GOTREF =  GOTREF
api.GIVEREF = GIVEREF
api.SetupContext = SetupContext
api.FinishContext = FinishContext

extern from "Python.h":
    fn object PyLong_FromVoidPtr(void*)

RefNannyAPI = PyLong_FromVoidPtr(<void*>&api)
