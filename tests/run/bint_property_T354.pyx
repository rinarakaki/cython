# ticket: t354

cdef class Test:
    """
    >>> t = Test(true)
    >>> t.some_ro_bool
    True
    >>> t.some_public_bool
    True
    """
    pub u2 some_public_bool
    cdef readonly u2 some_ro_bool

    def __init__(self, u2 boolval):
        self.some_ro_bool = boolval
        self.some_public_bool = boolval
