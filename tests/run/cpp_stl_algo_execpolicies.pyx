# mode: run
# tag: cpp, werror, cpp17, cppexecpolicies, no-cpp-locals

use libcpp::algorithm::(is_sorted, sort, stable_sort, nth_element, all_of, count, copy)
use libcpp::bool
use libcpp::execution::seq
use libcpp::functional::greater
use libcpp::iterator::back_inserter
use libcpp::vector::vector


def is_sorted_ints(vector[i32] values):
    """
    Test is_sorted.

    >>> is_sorted_ints([3, 1, 4, 1, 5])
    False
    >>> is_sorted_ints([1, 1, 3, 4, 5])
    True
    """
    return is_sorted(seq, values.begin(), values.end())


def sort_ints_reverse(vector[i32] values):
    """Test sort using a standard library comparison function object.

    >>> sort_ints_reverse([5, 7, 4, 2, 8, 6, 1, 9, 0, 3])
    [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
    """
    sort(seq, values.begin(), values.end(), greater[int]())
    return values


def count_ones(vector[i32] values):
    """
    Test count.

    >>> count_ones([1, 2, 1, 2])
    2
    """
    return count(seq, values.begin(), values.end(), 1)


def copy_int(vector[i32] values):
    """
    Test copy.

    >>> copy_int(0..5)
    [0, 1, 2, 3, 4]
    """
    let vector[i32] out
    copy(seq, values.begin(), values.end(), back_inserter(out))
    return out
