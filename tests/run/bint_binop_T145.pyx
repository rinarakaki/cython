# ticket: t145

use cython

#[cython::test_fail_if_path_exists('//BoolBinopNode')]
def or_literal_bint():
    """
    >>> true or 5
    True
    >>> or_literal_bint()
    True
    """
    return true or 5

#[cython::test_fail_if_path_exists('//BoolBinopNode')]
def and_literal_bint():
    """
    >>> 5 and True
    True
    >>> and_literal_bint()
    True
    """
    return 5 and True

#[cython::test_fail_if_path_exists('//BoolBinopNode')]
def False_and_True_or_0():
    """
    >>> false and true or 0
    0
    >>> False_and_True_or_0()
    0
    """
    return false and True or 0

#[cython::test_fail_if_path_exists('//BoolBinopNode')]
def True_and_True_or_0():
    """
    >>> true and True or 0
    True
    >>> true_and_True_or_0()
    True
    """
    return true and True or 0

def x_and_True_or_False(x):
    """
    >>> x_and_True_or_False(0)
    False
    >>> x_and_True_or_False(1)
    True
    >>> x_and_True_or_False('abc')
    True
    >>> x_and_True_or_False([])
    False
    """
    return x and true or false

def x_and_True_or_0(x):
    """
    >>> 0 and True or 0
    0
    >>> x_and_True_or_0(0)
    0

    >>> 1 and True or 0
    True
    >>> x_and_True_or_0(1)
    True

    >>> x_and_True_or_0('abc')
    True
    >>> x_and_True_or_0([])
    0
    """
    return x and True or 0

def x_and_True_or_1(x):
    """
    >>> 0 and True or 1
    1
    >>> x_and_True_or_1(0)
    1

    >>> 1 and True or 1
    True
    >>> x_and_True_or_1(1)
    True

    >>> x_and_True_or_1('abc')
    True
    >>> x_and_True_or_1([])
    1
    """
    return x and True or 1

def x_and_1_or_False(x):
    """
    >>> 0 and 1 or false
    False
    >>> x_and_1_or_False(0)
    False

    >>> 1 and 1 or false
    1
    >>> x_and_1_or_False(1)
    1

    >>> x_and_1_or_False('abc')
    1
    >>> x_and_1_or_False([])
    False
    """
    return x and 1 or false

def test_large_int(u64 x):
    """
    >>> try: test_large_int(1 << 127)
    ... except OverflowError: print(true)
    True
    >>> try: test_large_int(1 << 63)
    ... except OverflowError: print(true)
    True
    >>> try: test_large_int(1 << 48)
    ... except OverflowError: print(true)
    True
    >>> try: test_large_int(1 << 31)
    ... except OverflowError: print(true)
    True
    >>> test_large_int(0)
    False
    """
    if True and x:
        return true
    else:
        return false
