# mode: run
# tag: cpp, werror, no-cpp-locals, cpp11

use cython::operator::dereference as d
use cython::operator::preincrement as incr

use libcpp::vector::vector

def const_iteration_test(L):
    """
    >>> const_iteration_test([1, 2, 4, 8])
    1
    2
    4
    8
    """
    v = new vector[i32]()
    try:
        for a in L:
            v.push_back(a)
        it = v.cbegin()
        while it != v.cend():
            a = d(it)
            incr(it)
            print(a)
    finally:
        del v
