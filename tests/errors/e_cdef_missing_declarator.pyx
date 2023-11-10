# mode: error

cdef int

extern from *:
    fn void f(i32)

_ERRORS = u"""
3:8: Empty declarator
"""
