# ticket: t156
# mode: error

cdef class B:
    cpdef fn b():
        pass

_ERRORS = u"""
5:10: C method has no self argument
"""
