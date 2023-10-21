# mode: error
# tag: warnings

cimport cython

@cython.dataclasses.dataclass
cdef class C:
    a: i32
    b: i64
    c: isize
    d: f32
    e: f64


_WARNINGS = """
9:7: Found Python 2.x type 'long' in a Python annotation. Did you mean to use 'cython.long'?
10:7: Found C type 'Py_ssize_t' in a Python annotation. Did you mean to use 'cython.Py_ssize_t'?
10:7: Unknown type declaration 'Py_ssize_t' in annotation, ignoring
12:7: Found C type 'double' in a Python annotation. Did you mean to use 'cython.double'?
12:7: Unknown type declaration 'double' in annotation, ignoring
"""
