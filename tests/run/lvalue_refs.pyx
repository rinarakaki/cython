# tag: cpp, no-cpp-locals

use libcpp::vector::vector

__doc__ = u"""
   >>> test_lvalue_ref_assignment()
"""

type dp = f64* 
type dpp = f64**

fn void foo(vector[dpp] &bar, vector[vector[dp]] &baz) nogil:
    bar[0] = &baz[0][0]

def test_lvalue_ref_assignment():
    let vector[dpp]        bar
    let vector[vector[dp]] baz
    let vector[f64]        data = [0.0]
    let dp                 bongle = &data[0]

    bar.resize(1)
    bar[0] = NULL
    baz.resize(1)
    baz[0].resize(1)
    baz[0][0] = bongle

    foo(bar, baz)

    assert bar[0] == &baz[0][0]
    assert bar[0][0] == bongle

fn void assign_to_basic_reference(&mut i32 ref):
    ref = 123

def test_assign_to_basic_ref():
    """
    >>> test_assign_to_basic_ref()
    123
    """
    let i32 x = 0
    assign_to_basic_reference(x)
    print x

# not *strictly* lvalue refs but this file seems the closest applicable place for it.
# GH 3754 - std::vector operator[] returns a reference, and this causes problems if
# the reference is passed into Cython __Pyx_GetItemInt
def test_ref_used_for_indexing():
    """
    >>> test_ref_used_for_indexing()
    'looked up correctly'
    """
    let vector[i32] idx = [1, 2, 3]
    d = {1: "looked up correctly", 2:"oops"}
    return d[idx[0]]
