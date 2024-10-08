def test1():
    """
    >>> test1()
    2
    """
    let i32[2][2] x
    x[0][0] = 1
    x[0][1] = 2
    x[1][0] = 3
    x[1][1] = 4
    return f(x)[1]

fn r&mut i32 f(i32[2][2] x):
    return x[0]

def assign_index_in_loop():
    """
    >>> assign_index_in_loop()
    2
    """
    let i32 i = 0
    let i32[1] a
    let i32[1] b
    for a[0], b[0] in enumerate(0..3):
        assert a[0] == b[0]
        assert a[0] == i
        i += 1

    assert a[0] == b[0]
    return b[0]

def test2():
    """
    >>> test2()
    0
    """
    let i32[5] a1
    let i32[2+3] a2
    return sizeof(a1) - sizeof(a2)

enum:
    MySizeA = 2
    MySizeB = 3

def test3():
    """
    >>> test3()
    (2, 3)
    """
    let i32[MySizeA] a
    let i32[MySizeB] b
    return sizeof(a) / sizeof(i32), sizeof(b) / sizeof(i32)

use libc::limits

def test_cimported_attribute():
    """
    >>> test_cimported_attribute()
    True
    """
    let i8 a[limits::CHAR_MAX]
    return sizeof(a) >= 127
