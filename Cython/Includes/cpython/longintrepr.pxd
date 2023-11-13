# Internals of the "long" type (Python 2) or "int" type (Python 3).

extern from "Python.h":
    """
    #if PY_MAJOR_VERSION < 3
     #include "longintrepr.h"
    #endif
    """
    type digit = u32
    type sdigit = i32  #  Python >= 2.7 only

    ctypedef class __builtin__.py_long [object PyLongObject]:
        cdef digit* ob_digit

    fn py_long _PyLong_New(isize s)

    static i64 PyLong_SHIFT
    static digit PyLong_BASE
    static digit PyLong_MASK
