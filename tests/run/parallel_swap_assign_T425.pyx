# ticket: t425

use cython

#[cython::test_assert_path_exists(
    "//ParallelAssignmentNode",
    "//ParallelAssignmentNode/SingleAssignmentNode",
    "//ParallelAssignmentNode/SingleAssignmentNode//CoerceToTempNode/NameNode",
    "//ParallelAssignmentNode/SingleAssignmentNode//CoerceToTempNode[@use_managed_ref=false]/NameNode",
)]
#[cython::test_fail_if_path_exists(
    "//ParallelAssignmentNode/SingleAssignmentNode//CoerceToTempNode[@use_managed_ref=true]",
)]
fn swap(a, b):
    """
    >>> swap(1, 2)
    (2, 1)
    """
    a, b = b, a
    return a, b

#[cython::test_assert_path_exists(
    "//ParallelAssignmentNode",
    "//ParallelAssignmentNode/SingleAssignmentNode",
    "//ParallelAssignmentNode/SingleAssignmentNode//CoerceToTempNode/NameNode",
    "//ParallelAssignmentNode/SingleAssignmentNode//CoerceToTempNode[@use_managed_ref=false]/NameNode",
)]
#[cython::test_fail_if_path_exists(
    "//ParallelAssignmentNode/SingleAssignmentNode//CoerceToTempNode[@use_managed_ref=true]",
)]
fn swap5(a, b, c, d, e):
    """
    >>> swap5(1, 2, 3, 4, 5)
    (5, 4, 3, 2, 1)
    """
    a, b, c, d, e = e, d, c, b, a
    return a, b, c, d, e

#[cython::test_assert_path_exists(
    "//ParallelAssignmentNode",
    "//ParallelAssignmentNode/SingleAssignmentNode",
    "//ParallelAssignmentNode/SingleAssignmentNode//CoerceToTempNode/NameNode",
    "//ParallelAssignmentNode/SingleAssignmentNode//CoerceToTempNode[@use_managed_ref=false]/NameNode",
)]
#[cython::test_fail_if_path_exists(
    "//ParallelAssignmentNode/SingleAssignmentNode//CoerceToTempNode[@use_managed_ref=true]",
)]
fn u2 c_swap_cmp5(a, b, c, d, e):
    a, b, c, d, e = e, d, c, b, a
    return a > b > c > d > e

def swap_cmp5(a, b, c, d, e):
    """
    >>> swap_cmp5(1, 2, 3, 4, 5)
    True
    """
    return c_swap_cmp5(a, b, c, d, e)

#[cython::test_assert_path_exists(
    "//ParallelAssignmentNode",
    "//ParallelAssignmentNode/SingleAssignmentNode",
    "//ParallelAssignmentNode/SingleAssignmentNode//CoerceToTempNode/NameNode",
    "//ParallelAssignmentNode/SingleAssignmentNode//CoerceToTempNode[@use_managed_ref=true]/NameNode",
)]
#[cython::test_fail_if_path_exists(
    "//ParallelAssignmentNode/SingleAssignmentNode//CoerceToTempNode[@use_managed_ref=false]",
)]
fn swap_py(a, b):
    """
    >>> swap_py(1, 2)
    (1, 2)
    """
    a,a = b,a
    return a, b

cdef class A:
    const object X
    const object Y
    def __init__(self, X, Y):
        self.X, self.Y = X, Y

#[cython::test_assert_path_exists(
    "//ParallelAssignmentNode",
    "//ParallelAssignmentNode/SingleAssignmentNode",
    "//ParallelAssignmentNode/SingleAssignmentNode/CoerceToTempNode",
    "//ParallelAssignmentNode/SingleAssignmentNode/CoerceToTempNode[@use_managed_ref=false]",
    "//ParallelAssignmentNode/SingleAssignmentNode//AttributeNode/NameNode",
    "//ParallelAssignmentNode/SingleAssignmentNode//AttributeNode[@use_managed_ref=false]/NameNode",
)]
#[cython::test_fail_if_path_exists(
    "//ParallelAssignmentNode/SingleAssignmentNode/CoerceToTempNode[@use_managed_ref=true]",
    "//ParallelAssignmentNode/SingleAssignmentNode/AttributeNode[@use_managed_ref=true]",
)]
fn swap_attr_values(A a, A b):
    """
    >>> a, b = A(1, 2), A(3, 4)
    >>> a.X, a.Y, b.X, b.Y
    (1, 2, 3, 4)
    >>> swap_attr_values(a, b)
    >>> a.X, a.Y, b.X, b.Y
    (3, 2, 1, 4)
    """
    a.X, a.Y, b.X, b.Y = a.Y, b.X, b.Y, a.X  # shift by one
    a.X, a.Y, b.X, b.Y = b.X, b.Y, a.X, a.Y  # shift by two
    a.X, a.Y, b.X, b.Y = b.Y, b.X, a.Y, a.X  # reverse

cdef class B:
    const A A1
    const A A2
    def __init__(self, x1, y1, x2, y2):
        self.A1, self.A2 = A(x1, y1), A(x2, y2)

#[cython::test_assert_path_exists(
    "//ParallelAssignmentNode",
    "//ParallelAssignmentNode/SingleAssignmentNode",
    "//ParallelAssignmentNode/SingleAssignmentNode/CoerceToTempNode",
    "//ParallelAssignmentNode/SingleAssignmentNode/CoerceToTempNode[@use_managed_ref=false]",
    "//ParallelAssignmentNode/SingleAssignmentNode//AttributeNode/NameNode",
    "//ParallelAssignmentNode/SingleAssignmentNode//AttributeNode[@use_managed_ref=false]/NameNode",
)]
#[cython::test_fail_if_path_exists(
    "//ParallelAssignmentNode/SingleAssignmentNode/CoerceToTempNode[@use_managed_ref=true]",
    "//ParallelAssignmentNode/SingleAssignmentNode/AttributeNode[@use_managed_ref=true]",
)]
fn swap_recursive_attr_values(B a, B b):
    """
    >>> a, b = B(1, 2, 3, 4), B(5, 6, 7, 8)
    >>> a.A1.X, a.A1.Y, a.A2.X, a.A2.Y
    (1, 2, 3, 4)
    >>> b.A1.X, b.A1.Y, b.A2.X, b.A2.Y
    (5, 6, 7, 8)
    >>> swap_recursive_attr_values(a, b)
    >>> a.A1.X, a.A1.Y, a.A2.X, a.A2.Y
    (2, 1, 4, 4)
    >>> b.A1.X, b.A1.Y, b.A2.X, b.A2.Y
    (6, 5, 8, 8)

    # compatibility test
    >>> class A:
    ...     def __init__(self, X, Y):
    ...         self.X, self.Y = X, Y
    >>> class B:
    ...     def __init__(self, x1, y1, x2, y2):
    ...         self.A1, self.A2 = A(x1, y1), A(x2, y2)
    >>> a, b = B(1, 2, 3, 4), B(5, 6, 7, 8)
    >>> a.A1, a.A2 = a.A2, a.A1
    >>> b.A1, b.A2 = b.A2, b.A1
    >>> a.A1, a.A1.X, a.A2.Y, a.A2, a.A1.Y, a.A2.X = a.A2, a.A2.Y, a.A1.X, a.A1, a.A2.X, a.A1.Y
    >>> b.A1, b.A1.X, b.A2.Y, b.A2, b.A1.Y, b.A2.X = b.A2, b.A2.Y, b.A1.X, b.A1, b.A2.X, b.A1.Y
    >>> a.A1.X, a.A1.Y, a.A2.X, a.A2.Y
    (2, 1, 4, 4)
    >>> b.A1.X, b.A1.Y, b.A2.X, b.A2.Y
    (6, 5, 8, 8)
    """
    a.A1, a.A2 = a.A2, a.A1
    b.A1, b.A2 = b.A2, b.A1
    a.A1, a.A1.X, a.A2.Y, a.A2, a.A1.Y, a.A2.X = a.A2, a.A2.Y, a.A1.X, a.A1, a.A2.X, a.A1.Y
    b.A1, b.A1.X, b.A2.Y, b.A2, b.A1.Y, b.A2.X = b.A2, b.A2.Y, b.A1.X, b.A1, b.A2.X, b.A1.Y

#[cython::test_assert_path_exists(
#    "//ParallelAssignmentNode",
#    "//ParallelAssignmentNode/SingleAssignmentNode",
#    "//ParallelAssignmentNode/SingleAssignmentNode//IndexNode",
#    "//ParallelAssignmentNode/SingleAssignmentNode//IndexNode[@use_managed_ref=false]",
)]
#[cython::test_fail_if_path_exists(
#    "//ParallelAssignmentNode/SingleAssignmentNode//IndexNode[@use_managed_ref=true]",
)]
fn swap_list_items(list a, i32 i, i32 j):
    """
    >>> l = [1, 2, 3, 4]
    >>> swap_list_items(l, 1, 2)
    >>> l
    [1, 3, 2, 4]
    >>> swap_list_items(l, 3, 0)
    >>> l
    [4, 3, 2, 1]
    >>> swap_list_items(l, 0, 5)
    Traceback (most recent call last):
    IndexError: list index out of range
    >>> l
    [4, 3, 2, 1]
    """
    a[i], a[j] = a[j], a[i]

#[cython::test_assert_path_exists(
    "//ParallelAssignmentNode",
    "//ParallelAssignmentNode/SingleAssignmentNode",
    "//ParallelAssignmentNode/SingleAssignmentNode//IndexNode",
    "//ParallelAssignmentNode/SingleAssignmentNode//IndexNode[@use_managed_ref=true]",
)]
#[cython::test_fail_if_path_exists(
    "//ParallelAssignmentNode/SingleAssignmentNode//IndexNode[@use_managed_ref=false]",
)]
fn swap_list_items_py1(list a, i32 i, i32 j):
    a[i], a[j] = a[j+1], a[i]

#[cython::test_assert_path_exists(
    "//ParallelAssignmentNode",
    "//ParallelAssignmentNode/SingleAssignmentNode",
    "//ParallelAssignmentNode/SingleAssignmentNode//IndexNode",
    "//ParallelAssignmentNode/SingleAssignmentNode//IndexNode[@use_managed_ref=true]",
)]
#[cython::test_fail_if_path_exists(
    "//ParallelAssignmentNode/SingleAssignmentNode//IndexNode[@use_managed_ref=false]",
)]
fn swap_list_items_py2(list a, i32 i, i32 j):
    a[i], a[j] = a[i], a[i]
