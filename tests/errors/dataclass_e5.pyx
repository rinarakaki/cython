# mode: error
# tag: warnings

use cython

#[cython::dataclasses.dataclass]
cdef class C:
    a: i32
    # b: i64  # only available in language_level=2, not worth testing
    c: isize
    d: f32
    e: f64


_WARNINGS = """
10:7: Found C type name 'Py_ssize_t' in a Python annotation. Did you mean to use 'cython.Py_ssize_t'?
10:7: Unknown type declaration 'Py_ssize_t' in annotation, ignoring
12:7: Found C type name 'double' in a Python annotation. Did you mean to use 'cython.double'?
12:7: Unknown type declaration 'double' in annotation, ignoring
"""
