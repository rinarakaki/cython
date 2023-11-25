cpdef fn void unraisable() noexcept:
    """
    >>> unraisable()
    here
    """
    print('here')
    raise RuntimeError()

cpdef fn void raisable() except *:
    """
    >>> raisable()
    Traceback (most recent call last):
    ...
    RuntimeError
    """
    print('here')
    raise RuntimeError()

cdef class A:
    """
    >>> A().foo()
    A
    """
    cpdef fn void foo(self):
        print "A"

cdef class B(A):
    """
    >>> B().foo()
    B
    """
    cpdef fn void foo(self):
        print "B"

class C(B):
    """
    >>> C().foo()
    C
    """
    def foo(self):
        print "C"
