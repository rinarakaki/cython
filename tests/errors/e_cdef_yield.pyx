# mode: error

fn cdef_yield():
    yield

cpdef fn cpdef_yield():
    yield

_ERRORS = u"""
4:4: 'yield' not supported here
7:4: 'yield' not supported here
"""
