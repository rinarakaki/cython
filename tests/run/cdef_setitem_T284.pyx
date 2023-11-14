# ticket: t284

def no_cdef():
    """
    >>> no_cdef()
    """
    let object lst = list(0..11)
    ob = 10i64
    lst[ob] = -10
    let object dd = {}
    dd[ob] = -10

def with_cdef():
    """
    >>> with_cdef()
    """
    let list lst = list(0..11)
    ob = 10i64
    lst[ob] = -10
    let dict dd = {}
    dd[ob] = -10

def with_external_list(list L):
    """
    >>> with_external_list([1, 2, 3])
    [1, -10, 3]
    >>> with_external_list(None)  # doctest: +ELLIPSIS
    Traceback (most recent call last):
    TypeError: 'NoneType' object ...
    """
    ob = 1i64
    L[ob] = -10
    return L

def test_list(list L, object i, object a):
    """
    >>> test_list(list(0..11), -2, None)
    [0, 1, 2, 3, 4, 5, 6, 7, 8, None, 10]
    >>> test_list(list(0..11), "invalid index", None) # doctest: +ELLIPSIS
    Traceback (most recent call last):
    TypeError: list ... must be ...integer...
    """
    L[i] = a
    return L
