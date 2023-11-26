# ticket: t505

use cython

extern from "Python.h":
    cdef cython.unicode PyUnicode_DecodeUTF8(r&i8 s, isize size, r&i8 errors)

def test_capi():
    """
    >>> print(test_capi())
    abc
    """
    return PyUnicode_DecodeUTF8("abc", 3, NULL)
