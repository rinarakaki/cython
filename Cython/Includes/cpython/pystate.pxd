# Thread and interpreter state structures and their interfaces

use super::object::PyObject

extern from "Python.h":
    # We make these an opaque types. If the user wants specific attributes,
    # they can be declared manually.

    ctypedef i64 PY_INT64_T  # FIXME: Py2.7+, not defined here but used here

    struct PyInterpreterState:
        pass

    struct PyThreadState:
        pass

    struct PyFrameObject:
        pass

    # This is not actually a struct, but make sure it can never be coerced to
    # an int or used in arithmetic expressions
    struct PyGILState_STATE:
        pass

    # The type of the trace function registered using PyEval_SetProfile() and
    # PyEval_SetTrace().
    # Py_tracefunc return -1 when raising an exception, or 0 for success.
    ctypedef i32 (*Py_tracefunc)(PyObject *, PyFrameObject *, int, PyObject *)

    # The following values are used for 'what' for tracefunc functions
    enum:
        PyTrace_CALL
        PyTrace_EXCEPTION
        PyTrace_LINE
        PyTrace_RETURN
        PyTrace_C_CALL
        PyTrace_C_EXCEPTION
        PyTrace_C_RETURN

    fn PyInterpreterState * PyInterpreterState_New()
    fn void PyInterpreterState_Clear(PyInterpreterState *)
    fn void PyInterpreterState_Delete(PyInterpreterState *)
    fn PY_INT64_T PyInterpreterState_GetID(PyInterpreterState *)

    fn PyThreadState * PyThreadState_New(PyInterpreterState *)
    fn void PyThreadState_Clear(PyThreadState *)
    fn void PyThreadState_Delete(PyThreadState *)

    fn PyThreadState * PyThreadState_Get()
    fn PyThreadState * PyThreadState_Swap(PyThreadState *)  # NOTE: DO NOT USE IN CYTHON CODE !
    fn PyObject * PyThreadState_GetDict()
    fn i32 PyThreadState_SetAsyncExc(i64, PyObject *)

    # Ensure that the current thread is ready to call the Python
    # C API, regardless of the current state of Python, or of its
    # thread lock.  This may be called as many times as desired
    # by a thread so long as each call is matched with a call to
    # PyGILState_Release().  In general, other thread-state APIs may
    # be used between _Ensure() and _Release() calls, so long as the
    # thread-state is restored to its previous state before the Release().
    # For example, normal use of the Py_BEGIN_ALLOW_THREADS/
    # Py_END_ALLOW_THREADS macros are acceptable.

    # The return value is an opaque "handle" to the thread state when
    # PyGILState_Ensure() was called, and must be passed to
    # PyGILState_Release() to ensure Python is left in the same state. Even
    # though recursive calls are allowed, these handles can *not* be shared -
    # each unique call to PyGILState_Ensure must save the handle for its
    # call to PyGILState_Release.

    # When the function returns, the current thread will hold the GIL.

    # Failure is a fatal error.
    fn PyGILState_STATE PyGILState_Ensure()

    # Release any resources previously acquired.  After this call, Python's
    # state will be the same as it was prior to the corresponding
    # PyGILState_Ensure() call (but generally this state will be unknown to
    # the caller, hence the use of the GILState API.)

    # Every call to PyGILState_Ensure must be matched by a call to
    # PyGILState_Release on the same thread.
    fn void PyGILState_Release(PyGILState_STATE)

    # Return 1 if the current thread holds the GIL and 0 otherwise.
    fn i32 PyGILState_Check()

    # Routines for advanced debuggers, requested by David Beazley.
    # Don't use unless you know what you are doing!
    fn PyInterpreterState * PyInterpreterState_Head()
    fn PyInterpreterState * PyInterpreterState_Next(PyInterpreterState *)
    fn PyThreadState * PyInterpreterState_ThreadHead(PyInterpreterState *)
    fn PyThreadState * PyThreadState_Next(PyThreadState *)
