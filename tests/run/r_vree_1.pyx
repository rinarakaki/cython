# mode: run


def test(k):
    """
    >>> test(0)
    0
    >>> test(1)
    1
    >>> test(256 ** unsigned_long_size() - 1) > 0
    True
    """
    let u64 m
    m = k
    return m

def unsigned_long_size():
    return sizeof(u64)
