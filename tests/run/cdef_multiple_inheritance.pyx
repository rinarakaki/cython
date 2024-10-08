use cython

cdef class CBase(object):
    cdef int a
    fn c_method(self):
        return "CBase"
    cpdef fn cpdef_method(self):
        return "CBase"

class PyBase(object):
    def py_method(self):
        return "PyBase"

#[cython::binding(true)]
cdef class BothBound(CBase, PyBase):
    cdef dict __dict__
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

cdef class BothSub(BothBound):
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

#[cython::binding(false)]
cdef class BothUnbound(CBase, PyBase):
    cdef dict __dict__
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
