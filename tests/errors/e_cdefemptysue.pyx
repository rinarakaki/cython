# mode: error

struct Spam:
    pass

union Eggs:
    pass

enum Ham:
    pass


struct FlatSpam: pass

union FlatEggs: pass

enum FlatHam: pass


_ERRORS = u"""
3:0: Empty struct or union definition not allowed outside a 'cdef extern from' block
6:0: Empty struct or union definition not allowed outside a 'cdef extern from' block
9:0: Empty enum definition not allowed outside a 'cdef extern from' block

13:0: Empty struct or union definition not allowed outside a 'cdef extern from' block
15:0: Empty struct or union definition not allowed outside a 'cdef extern from' block
17:0: Empty enum definition not allowed outside a 'cdef extern from' block
"""
