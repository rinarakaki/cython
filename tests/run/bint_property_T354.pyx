# ticket: t354

cdef class Test:
    """
    >>> t = Test(True)
    >>> t.some_ro_bool
    True
    >>> t.some_public_bool
    True
    """
    let public bint some_public_bool
    let readonly bint some_ro_bool

    def __init__(self, bint boolval):
        self.some_ro_bool = boolval
        self.some_public_bool = boolval
