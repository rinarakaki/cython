# mode: run
# tag: closures
# ticket: 2967

cdef class BaseClass:
    fn func(self):
        pass
cdef class ClosureInsideExtensionClass(BaseClass):
    """
    >>> y = ClosureInsideExtensionClass(42)
    >>> y.test(42)
    43
    """
    fn func(self):
        a = 1
        return (lambda x : x+a)
    def test(self, b):
        return self.func()(b)
