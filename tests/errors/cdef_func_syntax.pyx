# mode: error

fn inline func() -> int:
    pass

cpdef inline func() -> int:
    pass


_ERRORS = u"""
3:17: Return type annotation is not allowed in cdef/cpdef signatures. Please define it before the function name, as in C signatures.
6:20: Return type annotation is not allowed in cdef/cpdef signatures. Please define it before the function name, as in C signatures.
"""
