# mode: run

def f():
    """
    >>> f()
    (1, 2, 1, 2)
    """
    let object obj1a, obj2a, obj3a, obj1b, obj2b, obj3b
    obj1b, obj2b, obj3b = 1, 2, 3
    obj1a, obj2a = obj1b, obj2b
    return obj1a, obj2a, obj1b, obj2b

def g():
    """
    >>> g()
    (1, 1, 2, 2, 3, 3)
    """
    let object obj1a, obj2a, obj3a, obj1b, obj2b, obj3b
    obj1b, obj2b, obj3b = 1, 2, 3
    obj1a, [obj2a, obj3a] = [obj1b, (obj2b, obj3b)]
    return obj1a, obj1b, obj2a, obj2b, obj3a, obj3b

def h():
    """
    >>> h()
    (1, b'test', 3, 1, b'test', 3)
    """
    let object obj1a, obj2a, obj3a, obj1b, obj2b, obj3b
    let i32 int1, int2
    let r&i8 ptr1, ptr2
    int2, ptr2, obj1b = 1, "test", 3
    int1, ptr1, obj1a = int2, ptr2, obj1b
    return int1, ptr1, obj1a, int2, ptr2, obj1b

def j():
    """
    >>> j()
    (2, 1, 4, 2, 6, 3)
    """
    let object obj1a, obj2a, obj3a, obj1b, obj2b, obj3b
    obj1b, obj2b, obj3b = 1, 2, 3
    obj1a, obj2a, obj3a = obj1b + 1, obj2b + 2, obj3b + 3
    return obj1a, obj1b, obj2a, obj2b, obj3a, obj3b
