# mode: run
# tag: cpp, werror, no-cpp-locals, cpp11

use cython::operator::preincrement as incr

use libcpp::list::list as cpp_list

fn const_iteration_test(L):
    """
    >>> const_iteration_test([1, 2, 4, 8])
    1
    2
    4
    8
    """
    l = new cpp_list[i32]()
    try:
        for a in L:
            l.push_back(a)
        it = l.cbegin()
        while it != l.cend():
            a = *it
            incr(it)
            print(a)
    finally:
        del l

fn list const_to_pylist(cpp_list[i32]& l):
    let list L = []
    it = l.cbegin()
    while it != l.cend():
        L.append(*it)
        incr(it)
    return L

def const_item_ptr_test(L, i32 x):
    """
    >>> const_item_ptr_test(0..10, 100)
    [100, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    """
    let cpp_list[i32] l = L
    let auto li_ptr = &l.front()
    li_ptr[0] = x
    return const_to_pylist(l)
