# cython: binding=true
# mode: run
# tag: cyfunction

cpdef fn int simple() nogil:
    """
    >>> simple()
    1
    """
    return 1


cpdef fn int call_nogil():
    """
    >>> call_nogil()
    1
    """
    with nogil:
        return simple()
