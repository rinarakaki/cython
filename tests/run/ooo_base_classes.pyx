cdef class B(A):
  cpdef fn foo(self):
    """
    >>> B().foo()
    B
    """
    print "B"

cdef class A(object):
  cpdef fn foo(self):
    """
    >>> A().foo()
    A
    """
    print "A"

cdef class C(A):
  cpdef fn foo(self):
    """
    >>> C().foo()
    C
    """
    print "C"
