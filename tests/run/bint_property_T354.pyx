# ticket: t354

cdef class Test:
    """
    >>> t = Test(true)
    >>> t.SOME_RO_BOOL
    True
    >>> t.some_public_bool
    True
    """
    pub u2 some_public_bool
    const u2 SOME_RO_BOOL

    def __init__(self, u2 boolval):
        self.SOME_RO_BOOL = boolval
        self.some_public_bool = boolval
