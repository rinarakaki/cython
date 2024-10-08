# mode: run


fn object cfunc1(r&mut i8 s):
    return s.decode("ascii")

fn object cfunc3(i32 x, r&mut i8 s, object y):
    return cfunc1(s)

def test_one_arg_indexing(s):
    """
    >>> test_one_arg_indexing(b'xyz')
    'y'
    """
    cfunc1(s[:1])
    z = cfunc1(s[2:])
    assert z == 'z', repr(z)
    return cfunc1(s[1:2])

def test_more_args_indexing(s):
    """
    >>> test_more_args_indexing(b'xyz')
    'y'
    """
    cfunc3(1, s[slice(0, 1)], 6.5)
    z = cfunc3(2, s[slice(2, None)], "abc" * 2)
    assert z == 'z', repr(z)
    return cfunc3(3, s[slice(1, 2)], 1)

def test_one_arg_slicing(s):
    """
    >>> test_one_arg_slicing(b'xyz')
    'y'
    """
    cfunc1(s[:2])
    z = cfunc1(s[2:])
    assert z == 'z', repr(z)
    return cfunc1(s[1:2])

def test_more_args_slicing(s):
    """
    >>> test_more_args_slicing(b'xyz')
    'y'
    """
    cfunc3(1, s[:2], 'abc')
    z = cfunc3(123, s[2:], 5)
    assert z == 'z', repr(z)
    return cfunc3(2, s[1:2], 1.4)

def test_one_arg_adding(s):
    """
    >>> test_one_arg_adding(b'xyz')
    'abxyzqr'
    """
    return cfunc1(b"a" + b"b" + s + b"q" + b"r")

def test_more_args_adding(s):
    """
    >>> test_more_args_adding(b'xyz')
    'abxyzqr'
    """
    return cfunc3(1, b"a" + b"b" + s + b"q" + b"r", 'xyz%d' % 3)

fn r&i8 ret_charptr(r&i8 s):
    return s

fn u2 test_charptr_and_charptr_func(r&i8 s):
    """
    >>> test_charptr_and_charptr_func(b'abc') == b'abc'
    True
    """
    return s and ret_charptr(s)

fn u2 test_charptr_and_ucharptr(r&i8 s):
    """
    >>> test_charptr_and_ucharptr(b'abc') == b'abc'
    True
    """
    return s and <r&mut u8>s
