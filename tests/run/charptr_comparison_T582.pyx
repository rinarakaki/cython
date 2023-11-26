# ticket: t582

use cython

# ##############################################################################
# # plain r&i8

#[cython::test_assert_path_exists('//SingleAssignmentNode')]
# #[cython::test_fail_if_path_exists('//SingleAssignmentNode//CoerceFromPyTypeNode')]
fn u2 charptr_equals_literal(r&i8 s):
    """
    >>> charptr_equals_literal("abc".encode("ascii"))
    True
    >>> charptr_equals_literal("aabc".encode("ascii"))
    False
    >>> charptr_equals_literal("abcx".encode("ascii"))
    False
    >>> charptr_equals_literal("bcx".encode("ascii"))
    False
    """
    let u2 result = (s == b"abc")
    return result

fn u2 charptr_gt_literal(r&i8 s):
    """
    >>> charptr_gt_literal("abc".encode("ascii"))
    False
    >>> charptr_gt_literal("aabc".encode("ascii"))
    False
    >>> charptr_gt_literal("abcx".encode("ascii"))
    True
    >>> charptr_gt_literal("bcx".encode("ascii"))
    True
    """
    let u2 result = (s > b"abc")
    return result

fn u2 charptr_lt_literal(r&i8 s):
    """
    >>> charptr_lt_literal("abc".encode("ascii"))
    False
    >>> charptr_lt_literal("aabc".encode("ascii"))
    True
    >>> charptr_lt_literal("abcx".encode("ascii"))
    False
    >>> charptr_lt_literal("bcx".encode("ascii"))
    False
    """
    let u2 result = (s < b"abc")
    return result

fn u2 charptr_ge_literal(r&i8 s):
    """
    >>> charptr_ge_literal("abc".encode("ascii"))
    True
    >>> charptr_ge_literal("aabc".encode("ascii"))
    False
    >>> charptr_ge_literal("abcx".encode("ascii"))
    True
    >>> charptr_ge_literal("bcx".encode("ascii"))
    True
    """
    let u2 result = (s >= b"abc")
    return result

fn u2 charptr_le_literal(r&i8 s):
    """
    >>> charptr_le_literal("abc".encode("ascii"))
    True
    >>> charptr_le_literal("aabc".encode("ascii"))
    True
    >>> charptr_le_literal("abcx".encode("ascii"))
    False
    >>> charptr_le_literal("bcx".encode("ascii"))
    False
    """
    let u2 result = (s <= b"abc")
    return result

# ##############################################################################
# # slices

#[cython::test_assert_path_exists('//SingleAssignmentNode')]
# FIXME: optimise me!
# #[cython::test_fail_if_path_exists('//SingleAssignmentNode//CoerceFromPyTypeNode')]
fn u2 slice_equals_literal(r&i8 s):
    """
    >>> slice_equals_literal("abc".encode("ascii"))
    True
    >>> slice_equals_literal("aabc".encode("ascii"))
    False
    >>> slice_equals_literal("abcx".encode("ascii"))
    True
    >>> slice_equals_literal("bcx".encode("ascii"))
    False
    """
    let u2 result = (s[:3] == b"abc")
    return result

fn u2 slice_gt_literal(r&i8 s):
    """
    >>> slice_gt_literal("abc".encode("ascii"))
    False
    >>> slice_gt_literal("aabc".encode("ascii"))
    False
    >>> slice_gt_literal("abcx".encode("ascii"))
    False
    >>> slice_gt_literal("bcx".encode("ascii"))
    True
    """
    let u2 result = (s[:3] > b"abc")
    return result

fn u2 slice_lt_literal(r&i8 s):
    """
    >>> slice_lt_literal("abc".encode("ascii"))
    False
    >>> slice_lt_literal("aabc".encode("ascii"))
    True
    >>> slice_lt_literal("abcx".encode("ascii"))
    False
    >>> slice_lt_literal("bcx".encode("ascii"))
    False
    """
    let u2 result = (s[:3] < b"abc")
    return result

fn u2 slice_ge_literal(r&i8 s):
    """
    >>> slice_ge_literal("abc".encode("ascii"))
    True
    >>> slice_ge_literal("aabc".encode("ascii"))
    False
    >>> slice_ge_literal("abcx".encode("ascii"))
    True
    >>> slice_ge_literal("bcx".encode("ascii"))
    True
    """
    let u2 result = (s[:3] >= b"abc")
    return result

fn u2 slice_le_literal(r&i8 s):
    """
    >>> slice_le_literal("abc".encode("ascii"))
    True
    >>> slice_le_literal("aabc".encode("ascii"))
    True
    >>> slice_le_literal("abcx".encode("ascii"))
    True
    >>> slice_le_literal("bcx".encode("ascii"))
    False
    """
    let u2 result = (s[:3] <= b"abc")
    return result
