cdef void ftang():
    let int x
    x = 0

cdef int foo(int i, char c):
    let float f, g
    f = 0
    g = 0

cdef spam(int i, obj, object object):
    let char c
    c = 0

def test():
    """
    >>> test()
    """
    ftang()
    foo(0, c'f')
    spam(25, None, None)
