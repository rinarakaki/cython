# ticket: t156
# mode: error

cdef class B:
    cpdef b():
        pass

_ERRORS = u"""
5:10: static cpdef methods not yet supported
"""
