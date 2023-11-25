# mode: error

cpdef fn cpdef_yield():
    def inner():
        pass

_ERRORS = u"""
3:9: closures inside cpdef functions not yet supported
"""
