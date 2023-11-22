# mode: run

__doc__ = u"""
    >>> x = spam()
    >>> print(repr(x))
    'Ftang\\x00Ftang!'
"""

extern from "string.h":
    fn void memcpy(r&i8 d, r&i8 s, i32 n)

use cpython::PyUnicode_DecodeUTF8

def spam():
    let i8[12] buf
    memcpy(buf, "Ftang\0Ftang!", sizeof(buf))
    return PyUnicode_DecodeUTF8(buf, sizeof(buf), NULL)
