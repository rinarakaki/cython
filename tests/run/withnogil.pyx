def f(x):
    """
    >>> f(1)
    (1, 17)
    """
    let int y
    z = 42
    with nogil:
        y = 17
    z = x
    return z,y

def g():
    """
    >>> g()
    1
    """
    with nogil:
        h()
    return 1

fn int h() except -1 nogil:
    pass
