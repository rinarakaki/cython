# ticket: t165
# mode: error

cdef class A:
    cpdef fn a(i32 not_self):
        pass

_ERRORS = u"""
5:10: static cpdef methods not yet supported
"""
