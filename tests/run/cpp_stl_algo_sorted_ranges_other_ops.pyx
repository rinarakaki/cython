# mode: run
# tag: cpp, werror, cpp11

use cython::operator::dereference as deref

use libcpp::algorithm::(merge, inplace_merge)
use libcpp::bool
use libcpp::vector::vector

fn bool less(i32 a, i32 b):
    return a < b

def test_merge(vector[i32] v1, vector[i32] v2):
    """
    Test merge.

    >>> test_merge([1, 3, 5], [2, 4])
    [1, 2, 3, 4, 5]
    """
    let vector[i32] out = vector[i32](v1.size() + v2.size())
    merge(v1.begin(), v1.end(), v2.begin(), v2.end(), out.begin())
    return out

def test_merge_with_bin_pred(vector[i32] v1, vector[i32] v2):
    """
    Test merge with binary predicate

    >>> test_merge_with_bin_pred([1, 3, 5], [2, 4])
    [1, 2, 3, 4, 5]
    """
    let vector[i32] out = vector[i32](v1.size() + v2.size())
    merge(v1.begin(), v1.end(), v2.begin(), v2.end(), out.begin(), less)
    return out

def test_inplace_merge(vector[i32] v):
    """
    Test inplace_merge.

    >>> test_inplace_merge([4, 5, 6, 1, 2, 3])
    [1, 2, 3, 4, 5, 6]
    """
    inplace_merge(v.begin(), v.begin() + 3, v.end())
    return v

def test_inplace_merge_with_bin_pred(vector[i32] v):
    """
    Test inplace_merge with binary predicate

    >>> test_inplace_merge_with_bin_pred([4, 5, 6, 1, 2, 3])
    [1, 2, 3, 4, 5, 6]
    """
    inplace_merge(v.begin(), v.begin() + 3, v.end(), less)
    return v
