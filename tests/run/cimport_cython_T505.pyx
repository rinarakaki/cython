# ticket: t505

use cython

extern from "Python.h":
    cdef cython.unicode PyUnicode_DecodeUTF8(r&char s, isize size, r&char errors)

def test_capi():
    """
    >>> print(test_capi())
    abc
    """
    return PyUnicode_DecodeUTF8("abc", 3, NULL)
