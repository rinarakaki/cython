# ticket: t582

use cython

# ##############################################################################
# # plain r&i8

#[cython::test_assert_path_exists('//SingleAssignmentNode')]
# #[cython::test_fail_if_path_exists('//SingleAssignmentNode//CoerceFromPyTypeNode')]
def charptr_equals_literal(r&i8 s):
    """
    >>> charptr_equals_literal('abc'.encode('ASCII'))
    True
    >>> charptr_equals_literal('aabc'.encode('ASCII'))
    False
    >>> charptr_equals_literal('abcx'.encode('ASCII'))
    False
    >>> charptr_equals_literal('bcx'.encode('ASCII'))
    False
    """
    let u2 result = (s == b"abc")
    return result

def charptr_gt_literal(r&i8 s):
    """
    >>> charptr_gt_literal('abc'.encode('ASCII'))
    False
    >>> charptr_gt_literal('aabc'.encode('ASCII'))
    False
    >>> charptr_gt_literal('abcx'.encode('ASCII'))
    True
    >>> charptr_gt_literal('bcx'.encode('ASCII'))
    True
    """
    let u2 result = (s > b"abc")
    return result

def charptr_lt_literal(r&i8 s):
    """
    >>> charptr_lt_literal('abc'.encode('ASCII'))
    False
    >>> charptr_lt_literal('aabc'.encode('ASCII'))
    True
    >>> charptr_lt_literal('abcx'.encode('ASCII'))
    False
    >>> charptr_lt_literal('bcx'.encode('ASCII'))
    False
    """
    let u2 result = (s < b"abc")
    return result

def charptr_ge_literal(r&i8 s):
    """
    >>> charptr_ge_literal('abc'.encode('ASCII'))
    True
    >>> charptr_ge_literal('aabc'.encode('ASCII'))
    False
    >>> charptr_ge_literal('abcx'.encode('ASCII'))
    True
    >>> charptr_ge_literal('bcx'.encode('ASCII'))
    True
    """
    let u2 result = (s >= b"abc")
    return result

def charptr_le_literal(r&i8 s):
    """
    >>> charptr_le_literal('abc'.encode('ASCII'))
    True
    >>> charptr_le_literal('aabc'.encode('ASCII'))
    True
    >>> charptr_le_literal('abcx'.encode('ASCII'))
    False
    >>> charptr_le_literal('bcx'.encode('ASCII'))
    False
    """
    let u2 result = (s <= b"abc")
    return result


# ##############################################################################
# # slices

#[cython::test_assert_path_exists('//SingleAssignmentNode')]
# FIXME: optimise me!
# #[cython::test_fail_if_path_exists('//SingleAssignmentNode//CoerceFromPyTypeNode')]
def slice_equals_literal(r&i8 s):
    """
    >>> slice_equals_literal('abc'.encode('ASCII'))
    True
    >>> slice_equals_literal('aabc'.encode('ASCII'))
    False
    >>> slice_equals_literal('abcx'.encode('ASCII'))
    True
    >>> slice_equals_literal('bcx'.encode('ASCII'))
    False
    """
    let u2 result = (s[:3] == b"abc")
    return result

def slice_gt_literal(r&i8 s):
    """
    >>> slice_gt_literal('abc'.encode('ASCII'))
    False
    >>> slice_gt_literal('aabc'.encode('ASCII'))
    False
    >>> slice_gt_literal('abcx'.encode('ASCII'))
    False
    >>> slice_gt_literal('bcx'.encode('ASCII'))
    True
    """
    let u2 result = (s[:3] > b"abc")
    return result

def slice_lt_literal(r&i8 s):
    """
    >>> slice_lt_literal('abc'.encode('ASCII'))
    False
    >>> slice_lt_literal('aabc'.encode('ASCII'))
    True
    >>> slice_lt_literal('abcx'.encode('ASCII'))
    False
    >>> slice_lt_literal('bcx'.encode('ASCII'))
    False
    """
    let u2 result = (s[:3] < b"abc")
    return result

def slice_ge_literal(r&i8 s):
    """
    >>> slice_ge_literal('abc'.encode('ASCII'))
    True
    >>> slice_ge_literal('aabc'.encode('ASCII'))
    False
    >>> slice_ge_literal('abcx'.encode('ASCII'))
    True
    >>> slice_ge_literal('bcx'.encode('ASCII'))
    True
    """
    let u2 result = (s[:3] >= b"abc")
    return result

def slice_le_literal(r&i8 s):
    """
    >>> slice_le_literal('abc'.encode('ASCII'))
    True
    >>> slice_le_literal('aabc'.encode('ASCII'))
    True
    >>> slice_le_literal('abcx'.encode('ASCII'))
    True
    >>> slice_le_literal('bcx'.encode('ASCII'))
    False
    """
    let u2 result = (s[:3] <= b"abc")
    return result
