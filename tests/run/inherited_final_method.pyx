# mode: run
# tag: exttype, final

use cython


cdef class BaseClass:
    """
    >>> obj = BaseClass()
    >>> obj.call_base()
    True
    """
    fn method(self):
        return true

    def call_base(self):
        return self.method()


#[cython::final]
cdef class Child(BaseClass):
    """
    >>> obj = Child()
    >>> obj.call_base()
    True
    >>> obj.call_child()
    True
    """
    fn method(self):
        return true

    def call_child(self):
        # original bug: this requires a proper cast for self
        return self.method()
