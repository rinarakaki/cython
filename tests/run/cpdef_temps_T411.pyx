# ticket: t411

cdef class A:
    """
    >>> A().is_True()
    True
    >>> A().is_False()
    False
    """
    cpdef fn is_True(self):
        return true
    cpdef fn is_False(self):
        return not self.is_True()

class B(A):
    """
    >>> B().is_True()
    True
    >>> B().is_False()
    False
    """
    def is_True(self):
        return true
