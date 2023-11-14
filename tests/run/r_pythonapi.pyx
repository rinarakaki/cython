# mode: run

__doc__ = u"""
    >>> x = spam()
    >>> print(repr(x))
    'Ftang\\x00Ftang!'
"""

extern from "string.h":
    fn void memcpy(char* d, char* s, i32 n)

use cpython::PyUnicode_DecodeUTF8

def spam():
    let char[12] buf
    memcpy(buf, "Ftang\0Ftang!", sizeof(buf))
    return PyUnicode_DecodeUTF8(buf, sizeof(buf), NULL)
