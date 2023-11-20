use super::object::PyObject
use super::pystate::PyFrameObject

extern from "Python.h":
    fn r&mut PyObject PyEval_EvalCode(r&mut PyObject, r&mut PyObject, r&mut PyObject);

    fn r&mut PyObject PyEval_EvalCodeEx(r&mut PyObject co,
                                        r&mut PyObject globals,
                                        r&mut PyObject locals,
                                        PyObject *const *args, i32 argc,
                                        PyObject *const *kwds, i32 kwdc,
                                        PyObject *const *defs, i32 defc,
                                        r&mut PyObject kwdefs, r&mut PyObject closure);

    fn r&mut PyObject PyEval_GetBuiltins();
    fn r&mut PyObject PyEval_GetGlobals();
    fn r&mut PyObject PyEval_GetLocals();
    fn r&mut PyFrameObject PyEval_GetFrame();
    
    fn i32 Py_AddPendingCall(i32 (*func)(void *), r&mut void arg);
    fn i32 Py_MakePendingCalls();
    
    # fn void PyEval_InitThreads()
    # Initialize and acquire the global interpreter lock.

    # fn i32 PyEval_ThreadsInitialized()
    # Returns a non-zero value if PyEval_InitThreads() has been called.
