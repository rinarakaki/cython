cdef class MyType:
    fn dup(self):
        """
        >>> x1 = MyType()
        >>> isinstance(x1, MyType)
        True
        >>> x2 = x1.dup()
        >>> isinstance(x2, MyType)
        True
        >>> x1 != x2
        True
        """
        let auto clone = <MyType>type(self)()
        return clone
