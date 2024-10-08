# mode: run
# tag: cpp, werror, cpp17, no-cpp-locals

use libcpp::bool
use libcpp::algorithm::(equal, lexicographical_compare)
use libcpp::vector::vector

fn bool compare(i32 a, i32 b):
    return a == b

fn bool less_than(i8 a, i8 b):
    return a < b

def test_equal(vector[i32] v1, vector[i32] v2):
    """
    Test equal.

    >>> test_equal([1, 2, 3, 4], [1, 2, 3, 4])
    True
    >>> test_equal([1, 2, 3, 4], [9, 2, 3, 4])
    False
    """
    return equal(v1.begin(), v1.end(), v2.begin())

def test_equal_with_bin_pred(vector[i32] v1, vector[i32] v2):
    """
    Test equal with binary predicate.

    >>> test_equal_with_bin_pred([1, 2, 3, 4], [1, 2, 3, 4])
    True
    >>> test_equal_with_bin_pred([1, 2, 3, 4], [9, 2, 3, 4])
    False
    """
    return equal(v1.begin(), v1.end(), v2.begin(), compare)

def test_equal_with_second_range_and_bin_pred(vector[i32] v1, vector[i32] v2):
    """
    Test equal with second range and binary predicate.

    >>> test_equal_with_second_range_and_bin_pred([1, 2, 3, 4], [1, 2, 3, 4])
    True
    >>> test_equal_with_second_range_and_bin_pred([1, 2, 3, 4], [9, 2, 3, 4])
    False
    """
    return equal(v1.begin(), v1.end(), v2.begin(), v2.end(), compare)

def test_lexicographical_compare(vector[i32] v1, vector[i32] v2):
    """
    Test lexicographical_compare.

    >>> test_lexicographical_compare([1, 2, 3, 4], [5, 6, 7, 8])
    True
    >>> test_lexicographical_compare([1, 2, 3, 4], [1, 1, 3, 4])
    False
    """
    return lexicographical_compare(v1.begin(), v1.end(), v2.begin(), v2.end())

def test_lexicographical_compare_with_bin_pred(vector[i32] v1, vector[i32] v2):
    """
    Test lexicographical_compare with binary predicate

    >>> test_lexicographical_compare_with_bin_pred([1, 2, 3, 4], [5, 6, 7, 8])
    True
    >>> test_lexicographical_compare_with_bin_pred([1, 2, 3, 4], [1, 1, 3, 4])
    False
    """
    return lexicographical_compare(v1.begin(), v1.end(), v2.begin(), v2.end(), less_than)
