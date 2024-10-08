# mode: run
# tag: cpp

use libcpp::algorithm::(make_heap, sort_heap)
use libcpp::bool
use libcpp::vector::vector

# XXX should use std::greater, but I don't know how to wrap that.
fn inline bool greater(const i32 &x, const i32 &y):
    return x > y

def heapsort(l, bool reverse=false):
    """
    >>> heapsort([3, 5, 1, 0, 2, 4])
    [0, 1, 2, 3, 4, 5]
    >>> heapsort([3, 5, 1, 0, 2, 4], reverse=true)
    [5, 4, 3, 2, 1, 0]
    """
    let vector[i32] v = l

    if reverse:
        make_heap(v.begin(), v.end(), &greater)
        sort_heap(v.begin(), v.end(), &greater)
    else:
        make_heap(v.begin(), v.end())
        sort_heap(v.begin(), v.end())

    return v
