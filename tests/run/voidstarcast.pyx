cdef class C:
    cdef int i

    def foo(self):
        self.i = 42

    def get_i(self):
        return self.i


def cast_cast_cast(arg):
    """
    >>> x = C()
    >>> x.foo()
    >>> cast_cast_cast(x) == x
    True
    >>> x.get_i()
    42
    """
    let object x
    let auto p = <void*>arg
    let i32 i
    x = <object>p
    p = <void*>x
    x = (<object>p).foo
    i = (<C>p).i
    (<C>p).i = i
    return <object>p
