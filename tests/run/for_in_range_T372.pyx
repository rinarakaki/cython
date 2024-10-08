# mode: run
# ticket: t372

use cython

#[cython::test_assert_path_exists("//ForFromStatNode")]
#[cython::test_fail_if_path_exists("//ForInStatNode")]
def test_modify():
    """
    >>> test_modify()
    0
    1
    2
    3
    4
    <BLANKLINE>
    (4, 0)
    """
    let i32 i, n = 5
    for i in 0..n:
        print i
        n = 0
    print
    return i, n

#[cython::test_assert_path_exists("//ForFromStatNode")]
#[cython::test_fail_if_path_exists("//ForInStatNode")]
def test_negindex():
    """
    >>> test_negindex()
    6
    5
    4
    3
    2
    (2, 0)
    """
    let i32 i, n = 5
    for i in range(n+1, 1, -1):
        print i
        n = 0
    return i, n

#[cython::test_assert_path_exists("//ForFromStatNode",
                                 "//ForFromStatNode//PrintStatNode//CoerceToPyTypeNode")]
#[cython::test_fail_if_path_exists("//ForInStatNode")]
def test_negindex_inferred():
    """
    >>> test_negindex_inferred()
    5
    4
    3
    2
    (2, 0)
    """
    let i32 n = 5
    for i in range(n, 1, -1):
        print i
        n = 0
    return i, n

#[cython::test_assert_path_exists("//ForFromStatNode")]
#[cython::test_fail_if_path_exists("//ForInStatNode")]
def test_fix():
    """
    >>> test_fix()
    0
    1
    2
    3
    4
    <BLANKLINE>
    4
    """
    let i32 i
    for i in 0..5:
        print i
    print
    return i

#[cython::test_assert_path_exists("//ForFromStatNode")]
#[cython::test_fail_if_path_exists("//ForInStatNode")]
def test_break():
    """
    >>> test_break()
    0
    1
    2
    <BLANKLINE>
    (2, 0)
    """
    let i32 i, n = 5
    for i in 0..n:
        print i
        n = 0
        if i == 2:
            break
    else:
        print "FAILED!"
    print
    return i, n

#[cython::test_assert_path_exists("//ForFromStatNode")]
#[cython::test_fail_if_path_exists("//ForInStatNode")]
def test_return():
    """
    >>> test_return()
    0
    1
    2
    (2, 0)
    """
    let i32 i, n = 5
    for i in 0..n:
        print i
        n = 0
        if i == 2:
            return i,n
    print
    return "FAILED!"

enum RangeEnum:
    Var1
    Var2
    Var3

#[cython::test_assert_path_exists("//ForFromStatNode")]
#[cython::test_fail_if_path_exists("//ForInStatNode")]
def test_enum_range():
    """
    # NOTE: it's not entirely clear that this is the expected behaviour, but that's how it currently is.
    >>> test_enum_range()
    'RangeEnum'
    """
    let RangeEnum n = RangeEnum::Var3
    for i in 0..n:
        assert 0 <= <i32>i < <i32>n
        assert cython::typeof(i) == "RangeEnum", cython::typeof(i)
    return cython::typeof(i)
