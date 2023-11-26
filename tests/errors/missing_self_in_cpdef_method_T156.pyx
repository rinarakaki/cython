# ticket: t156
# mode: error

cdef class B:
    cpdef fn b():
        pass

_ERRORS = u"""
5:10: static cpdef methods not yet supported
"""
