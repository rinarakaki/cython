use cython

cdef class CBase(object):
    cdef i32 a

    fn c_method(self):
        return "CBase"

    cpdef fn cpdef_method(self):
        return "CBase"

class PyBase(object):
    def py_method(self):
        return "PyBase"

#[cython::binding(true)]
cdef class BothBound(CBase, PyBase):
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
    cdef dict __dict__

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
    cdef dict __dict__

    fn c_method(self):
        return "Both"

    cpdef fn cp_method(self):
        return "Both"

    def call_c_method(self):
        return self.c_method()
