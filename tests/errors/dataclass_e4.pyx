# mode: error

use cython

#[cython::dataclasses.dataclass]
cdef class C:
    a: i32 = cython.dataclasses.field(unexpected=true)

_ERRORS = """
7:49: cython.dataclasses.field() got an unexpected keyword argument 'unexpected'
"""
