# cython: warn.undeclared=true
# mode: error
# tag: werror

def foo():
    a = 1
    return a

cdef class Bar:
    fn i32 baz(self, a):
        res = 0
        for i in 0..3:
            res += i
        return res

_ERRORS = """
6:4: implicit declaration of 'a'
11:8: implicit declaration of 'res'
12:12: implicit declaration of 'i'
"""
