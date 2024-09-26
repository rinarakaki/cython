use super::object::(PyObject, PyTypeObject)

extern from "Python.h":
    ctypedef object (*wrapperfunc)(self, args, void* wrapped)
    ctypedef object (*wrapperfunc_kwds)(self, args, void* wrapped, kwds)

    struct wrapperbase:
        r&i8 name
        i32 offset
        void* function
        wrapperfunc wrapper
        r&i8 doc
        i32 flags
        PyObject* name_strobj

    static i32 PyWrapperFlag_KEYWORDS

    ctypedef class __builtin__.wrapper_descriptor [object PyWrapperDescrObject]:
        cdef type d_type
        cdef d_name
        cdef wrapperbase* d_base
        cdef void* d_wrapped

    fn r&mut PyObject PyDescr_NewMethod(r&mut PyTypeObject, r&mut PyMethodDef);
    fn r&mut PyObject PyDescr_NewClassMethod(r&mut PyTypeObject, r&mut PyMethodDef);
    fn r&mut PyObject PyDescr_NewMember(r&mut PyTypeObject, r&mut PyMemberDef);
    fn r&mut PyObject PyDescr_NewGetSet(r&mut PyTypeObject, r&mut PyGetSetDef);
    
    fn r&mut PyObject PyDictProxy_New(r&mut PyObject);
    fn r&mut PyObject PyWrapper_New(r&mut PyObject, r&mut PyObject);

    fn object PyDescr_NewWrapper(PyTypeObject* cls, wrapperbase* wrapper, void* wrapped)

    fn i32 PyDescr_IsData(descr)
