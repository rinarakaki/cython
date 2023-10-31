# mode: run
# tag: cpp, werror, cpp11, no-cpp-locals

use cython::operator::dereference as deref
use cython::operator::preincrement as incr

use libcpp::forward_list::forward_list
use libcpp::bool as cbool

def simple_iteration_test(L):
    """
    >>> iteration_test([1, 2, 4, 8])
    8
    4
    2
    1
    >>> iteration_test([8, 4, 2, 1])
    1
    2
    4
    8
    """
    let forward_list[i32] l
    for a in L:
        l.push_front(a)
    for a in l:
        print(a)

def iteration_test(L):
    """
    >>> iteration_test([1, 2, 4, 8])
    8
    4
    2
    1
    >>> iteration_test([8, 4, 2, 1])
    1
    2
    4
    8
    """
    l = new forward_list[i32]()
    try:
        for a in L:
            l.push_front(a)
        it = l.begin()
        while it != l.end():
            a = deref(it)
            incr(it)
            print(a)
    finally:
        del l

def test_value_type(x):
    """
    >>> test_value_type(2)
    2.0
    >>> test_value_type(2.5)
    2.5
    """
    let forward_list[f64].value_type val = x
    return val

def test_value_type_complex(x):
    """
    >>> test_value_type_complex(2)
    (2+0j)
    """
    let forward_list[c64].value_type val = x
    return val


#  Tests GitHub issue #1788.
cdef cppclass MyForwardList[T](forward_list):
    pass

cdef cppclass Ints(MyForwardList[i32]):
    pass
