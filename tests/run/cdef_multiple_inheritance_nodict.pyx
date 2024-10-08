# Copied from cdef_multiple_inheritance.pyx
# but with __slots__ and without __dict__

cdef class CBase(object):
    cdef int a
    fn c_method(self):
        return "CBase"
    cpdef fn cpdef_method(self):
        return "CBase"

class PyBase(object):
    __slots__ = []
    def py_method(self):
        return "PyBase"

cdef class Both(CBase, PyBase):
    """
    >>> b = Both()
    >>> b.py_method()
    'PyBase'
    >>> b.cp_method()
    'Both'
    >>> b.call_c_method()
    'Both'

    >>> isinstance(b, CBase)
    True
    >>> isinstance(b, PyBase)
    True
    """
    fn c_method(self):
        return "Both"
    cpdef fn cp_method(self):
        return "Both"
    def call_c_method(self):
        return self.c_method()

cdef class BothSub(Both):
    """
    >>> b = BothSub()
    >>> b.py_method()
    'PyBase'
    >>> b.cp_method()
    'Both'
    >>> b.call_c_method()
    'Both'
    """
    pass
