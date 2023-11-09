# mode: run


def f(x):
    """
    >>> f(100)
    101
    """
    let u128 ull = x
    return ull + 1

def g(u64 x):
    """
    >>> g(3000000000)
    3000000001
    """
    return x + 1
