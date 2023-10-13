# ticket: t676
# tag: cpp

from cython cimport typeof

extern from "arithmetic_analyse_types_helper.h":
    struct short_return:
        char *msg
    struct int_return:
        char *msg
    struct longlong_return:
        char *msg
    fn short_return f(short)
    fn int_return f(int)
    fn longlong_return f(long long)

def short_binop(short val):
    """
    Arithmetic in C is always done with at least int precision.
    
    >>> print(short_binop(3))
    int called
    """
    assert typeof(val + val) == "int", typeof(val + val)
    assert typeof(val - val) == "int", typeof(val - val)
    assert typeof(val & val) == "int", typeof(val & val)
    let int_return x = f(val + val)
    return x.msg.decode('ASCII')

def short_unnop(short val):
    """
    Arithmetic in C is always done with at least int precision.
    
    >>> print(short_unnop(3))
    int called
    """
    let int_return x = f(-val)
    return x.msg.decode('ASCII')

def longlong_binop(long long val):
    """
    >>> print(longlong_binop(3))
    long long called
    """
    let longlong_return x = f(val * val)
    return x.msg.decode('ASCII')

def longlong_unnop(long long val):
    """
    >>> print(longlong_unnop(3))
    long long called
    """
    let longlong_return x = f(~val)
    return x.msg.decode('ASCII')


def test_bint(bint a):
    """
    >>> test_bint(True)
    """
    assert typeof(a + a) == "int", typeof(a + a)
    assert typeof(a & a) == "bint", typeof(a & a)
