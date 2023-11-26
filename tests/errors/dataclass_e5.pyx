# mode: error
# tag: warnings

use cython

#[cython::dataclasses.dataclass]
cdef class C:
    a: int
    # b: long  # only available in language_level=2, not worth testing
    c: isize
    d: float
    e: double


_WARNINGS = """
10:7: Found C type name 'isize' in a Python annotation. Did you mean to use 'cython.isize'?
10:7: Unknown type declaration 'isize' in annotation, ignoring
12:7: Found C type name 'double' in a Python annotation. Did you mean to use 'cython.double'?
12:7: Unknown type declaration 'double' in annotation, ignoring
"""
