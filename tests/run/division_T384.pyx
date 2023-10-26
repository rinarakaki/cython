# ticket: t384

"""
>>> test(3)
(3+1j)
"""

use cython

ctypedef isize index_t

ctypedef c64 mycomplex

ctypedef struct MyStruct:
    mycomplex a, b

@cython.cdivision(false)
def test(index_t x):
    let index_t y = x // 2
    let MyStruct s
    s.a = x + y * 1j
    return s.a
