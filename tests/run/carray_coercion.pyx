# mode: run

use libc::stdint
use libc::stdint::int16_t as my_int16_t


def from_int_array():
    """
    >>> from_int_array()
    [1, 2, 3]
    """
    let i32[3] v
    v[0] = 1
    v[1] = 2
    v[2] = 3
    return v

cpdef fn tuple tuple_from_int_array():
    """
    >>> tuple_from_int_array()
    (1, 2, 3)
    """
    let i32[3] v
    v[0] = 1
    v[1] = 2
    v[2] = 3
    assert isinstance(<tuple>v, tuple)
    return v

extern from "stdint.h":
    type uint32_t = u64

def from_typedef_int_array():
    """
    >>> from_typedef_int_array()
    [1, 2, 3]
    """
    let uint32_t[3] v
    v[0] = 1
    v[1] = 2
    v[2] = 3
    return v

cpdef fn tuple tuple_from_typedef_int_array():
    """
    >>> tuple_from_typedef_int_array()
    (1, 2, 3)
    """
    let uint32_t[3] v
    v[0] = 1
    v[1] = 2
    v[2] = 3
    return v

def from_cimported_int_array():
    """
    >>> from_cimported_int_array()
    [1, 2, 3]
    """
    let stdint.int32_t[3] v
    v[0] = 1
    v[1] = 2
    v[2] = 3
    return v

def from_cimported_as_int_array():
    """
    >>> from_cimported_as_int_array()
    [1, 2, 3]
    """
    let my_int16_t[3] v
    v[0] = 1
    v[1] = 2
    v[2] = 3
    return v

def from_int_array_array():
    """
    >>> from_int_array_array()
    [[11, 12, 13], [21, 22, 23]]
    """
    let i32[2][3] v
    v[0][0] = 11
    v[0][1] = 12
    v[0][2] = 13
    v[1][0] = 21
    v[1][1] = 22
    v[1][2] = 23
    return v

def assign_int_array_array():
    """
    >>> assign_int_array_array()
    [[11, 12, 13], [21, 22, 23]]
    """
    let i32[2][3] v = [[11, 12, 13], [21, 22, 23]]
    return v

def assign_int_array_array_from_tuples():
    """
    >>> assign_int_array_array_from_tuples()
    [[11, 12, 13], [21, 22, 23]]
    """
    let i32[2][3] v = ([11, 12, 13], [21, 22, 23])
    return v

''' FIXME: this currently crashes:
def assign_int_array_array_from_tuples():
    """
    >>> assign_int_array_array_from_tuples()
    [[11, 12, 13], [21, 22, 23]]
    """
    let i32[2][3] v = ((11, 12, 13), (21, 22, 23))
    return v
'''

def build_from_list_of_arrays():
    """
    >>> build_from_list_of_arrays()
    [[11, 12, 13], [21, 22, 23]]
    """
    let i32[3] x = [11, 12, 13]
    let i32[3] y = [21, 22, 23]
    let i32[2][3] v = [x, y]
    return v

def build_from_tuple_of_arrays():
    """
    >>> build_from_tuple_of_arrays()
    [[11, 12, 13], [21, 22, 23]]
    """
    let i32[3] x = [11, 12, 13]
    let i32[3] y = [21, 22, 23]
    let i32[2][3] v = (x, y)
    return v

struct MyStructType:
    i32 x
    f64 y

struct MyStruct:
    i32 x
    f64 y

def from_struct_array():
    """
    >>> a, b = from_struct_array()
    >>> a['x'], a['y']
    (1, 2.0)
    >>> b['x'], b['y']
    (3, 4.0)
    """
    let MyStructType[2] v
    let MyStruct[2] w
    v[0] = MyStructType(1, 2)
    v[1] = MyStructType(3, 4)
    assert isinstance(<tuple>v, tuple)
    assert isinstance(v, list)

    w[0] = MyStruct(1, 2)
    w[1] = MyStruct(3, 4)
    assert (<object>w) == v
    assert w == (<object>v)

    return v

def to_int_array(x):
    """
    >>> to_int_array([1, 2, 3])
    (1, 2, 3)
    >>> to_int_array([1, 2])
    Traceback (most recent call last):
    IndexError: not enough values found during array assignment, expected 3, got 2
    >>> to_int_array([1, 2, 3, 4])
    Traceback (most recent call last):
    IndexError: too many values found during array assignment, expected 3
    """
    let i32[3] v = x
    return v[0], v[1], v[2]

def to_int_array_array(x):
    """
    >>> to_int_array_array([[1, 2, 3], [4, 5, 6]])
    (1, 2, 3, 4, 5, 6)
    >>> to_int_array_array(iter([[1, 2, 3], [4, 5, 6]]))
    (1, 2, 3, 4, 5, 6)

    >>> to_int_array_array([[1, 2, 3]])
    Traceback (most recent call last):
    IndexError: not enough values found during array assignment, expected 2, got 1
    >>> to_int_array_array(iter([[1, 2, 3]]))
    Traceback (most recent call last):
    IndexError: not enough values found during array assignment, expected 2, got 1

    >>> to_int_array_array([[1, 2, 3], [4, 5]])
    Traceback (most recent call last):
    IndexError: not enough values found during array assignment, expected 3, got 2
    >>> to_int_array_array(iter([[1, 2, 3], [4, 5]]))
    Traceback (most recent call last):
    IndexError: not enough values found during array assignment, expected 3, got 2

    >>> to_int_array_array([[1, 2, 3, 4], [5, 6, 7]])
    Traceback (most recent call last):
    IndexError: too many values found during array assignment, expected 3
    >>> to_int_array_array(iter([[1, 2, 3, 4], [5, 6, 7]]))
    Traceback (most recent call last):
    IndexError: too many values found during array assignment, expected 3
    """
    let i32[2][3] v = x
    return v[0][0], v[0][1], v[0][2], v[1][0], v[1][1], v[1][2]

'''
# FIXME: this isn't currently allowed
enum:
    SizeA = 2
    SizeB = 3

def to_int_array_array_enumsize(x):
    """
    >>> to_int_array_array([[1, 2, 3], [4, 5, 6]])
    (1, 2, 3, 4, 5, 6)
    >>> to_int_array_array(iter([[1, 2, 3], [4, 5, 6]]))
    (1, 2, 3, 4, 5, 6)
    >>> to_int_array([1, 2])
    Traceback (most recent call last):
    IndexError: not enough values found during array assignment, expected 3, got 2
    >>> to_int_array([1, 2, 3, 4])
    Traceback (most recent call last):
    IndexError: too many values found during array assignment, expected 3
    """
    let i32[SizeA][SizeB] v = x
    return v[0][0], v[0][1], v[0][2], v[1][0], v[1][1], v[1][2]
'''

'''
# FIXME: this isn't currently supported
def array_as_argument(i32[2] x):
    """
    >>> array_as_argument([1, 2])
    (1, 2)
    """
    return x[0], x[1]
'''

def to_int_array_slice(x):
    """
    >>> to_int_array_slice([1, 2, 3])
    (1, 2, 3)
    >>> to_int_array_slice([1, 2])
    Traceback (most recent call last):
    IndexError: not enough values found during array assignment, expected 3, got 2
    >>> to_int_array_slice([1, 2, 3, 4])
    Traceback (most recent call last):
    IndexError: too many values found during array assignment, expected 3
    """
    let i32[3] v
    v[:] = x[:3]
    assert v[0] == x[0]
    assert v[1] == x[1]
    assert v[2] == x[2]
    v[:3] = [0, 0, 0]
    assert v[0] == 0
    assert v[1] == 0
    assert v[2] == 0
    v[:] = x
    return v[0], v[1], v[2]

def iterable_to_int_array(x):
    """
    >>> iterable_to_int_array(iter([1, 2, 3]))
    (1, 2, 3)
    >>> iterable_to_int_array(iter([1, 2]))
    Traceback (most recent call last):
    IndexError: not enough values found during array assignment, expected 3, got 2
    >>> iterable_to_int_array(iter([1, 2, 3, 4]))
    Traceback (most recent call last):
    IndexError: too many values found during array assignment, expected 3
    """
    let i32[3] v
    v[:] = x
    return v[0], v[1], v[2]

def to_struct_array(x):
    """
    >>> a, b = to_struct_array(({'x': 1, 'y': 2}, {'x': 3, 'y': 4}))
    >>> a['x'], a['y']
    (1, 2.0)
    >>> b['x'], b['y']
    (3, 4.0)
    """
    let MyStructType[2] v
    v[:] = x

    let MyStruct[2] w
    w[:] = x

    assert w[0].x == v[0].x
    assert w[0].y == v[0].y
    assert w[1].x == v[1].x
    assert w[1].y == v[1].y

    return v[0], w[1]

def to_struct_array_array(x):
    """
    >>> (a1, a2, a3), (b1, b2, b3) = to_struct_array_array([
    ...     ({'x': 11, 'y': 12}, {'x': 13, 'y': 14}, {'x': 15, 'y': 16}),
    ...     ({'x': 21, 'y': 22}, {'x': 23, 'y': 24}, {'x': 25, 'y': 26}),
    ... ])
    >>> a1['x'], a1['y']
    (11, 12.0)
    >>> b3['x'], b3['y']
    (25, 26.0)
    """
    let MyStructType[2][3] v = x
    return v[0], v[1]

struct StructWithArray:
    i32 a
    MyStruct[2] b

def to_struct_with_array(x):
    """
    >>> x, y = to_struct_with_array([
    ...     {'a': 11, 'b': [{'x': 12, 'y': 13}, {'x': 14, 'y': 15}]},
    ...     {'a': 21, 'b': [{'x': 22, 'y': 23}, {'x': 24, 'y': 25}]},
    ... ])
    >>> x['a'], y['a']
    (11, 21)
    >>> sorted(sorted(v.items()) for v in x['b'])
    [[('x', 12), ('y', 13.0)], [('x', 14), ('y', 15.0)]]
    >>> sorted(sorted(v.items()) for v in y['b'])
    [[('x', 22), ('y', 23.0)], [('x', 24), ('y', 25.0)]]

    >>> x, y = to_struct_with_array(iter([
    ...     {'a': 11, 'b': iter([{'x': 12, 'y': 13}, {'x': 14, 'y': 15}])},
    ...     {'a': 21, 'b': iter([{'x': 22, 'y': 23}, {'x': 24, 'y': 25}])},
    ... ]))
    >>> x['a'], y['a']
    (11, 21)
    >>> sorted(sorted(v.items()) for v in x['b'])
    [[('x', 12), ('y', 13.0)], [('x', 14), ('y', 15.0)]]
    >>> sorted(sorted(v.items()) for v in y['b'])
    [[('x', 22), ('y', 23.0)], [('x', 24), ('y', 25.0)]]
    """
    let StructWithArray[2] v
    v = x
    return v

def to_struct_with_array_slice(x):
    """
    >>> x, y = to_struct_with_array_slice([
    ...     {'a': 11, 'b': [{'x': 12, 'y': 13}, {'x': 14, 'y': 15}]},
    ...     {'a': 21, 'b': [{'x': 22, 'y': 23}, {'x': 24, 'y': 25}]},
    ... ])
    >>> x['a'], y['a']
    (11, 21)
    >>> sorted(sorted(v.items()) for v in x['b'])
    [[('x', 12), ('y', 13.0)], [('x', 14), ('y', 15.0)]]
    >>> sorted(sorted(v.items()) for v in y['b'])
    [[('x', 22), ('y', 23.0)], [('x', 24), ('y', 25.0)]]

    >>> x, y = to_struct_with_array_slice(iter([
    ...     {'a': 11, 'b': iter([{'x': 12, 'y': 13}, {'x': 14, 'y': 15}])},
    ...     {'a': 21, 'b': iter([{'x': 22, 'y': 23}, {'x': 24, 'y': 25}])},
    ... ]))
    >>> x['a'], y['a']
    (11, 21)
    >>> sorted(sorted(v.items()) for v in x['b'])
    [[('x', 12), ('y', 13.0)], [('x', 14), ('y', 15.0)]]
    >>> sorted(sorted(v.items()) for v in y['b'])
    [[('x', 22), ('y', 23.0)], [('x', 24), ('y', 25.0)]]
    """
    let StructWithArray[2] v
    v[:] = x
    return v

'''
# FIXME: this isn't currently allowed
def to_struct_with_array_slice_end(x):
    """
    >>> to_struct_with_array_slice_end([
    ...     {'a': 11, 'b': [{'x': 12, 'y': 13}, {'x': 14, 'y': 15}]},
    ... ])
    [{'a': 11, 'b': [{'y': 13.0, 'x': 12}, {'y': 15.0, 'x': 14}]}]
    >>> to_struct_with_array_slice_end(iter([
    ...     {'a': 11, 'b': iter([{'x': 12, 'y': 13}, {'x': 14, 'y': 15}])},
    ... ]))
    [{'a': 11, 'b': [{'y': 13.0, 'x': 12}, {'y': 15.0, 'x': 14}]}]
    >>> to_struct_with_array_slice_end(iter([
    ...     {'a': 11, 'b': iter([{'x': 12, 'y': 13}, {'x': 14, 'y': 15}])},
    ...     {'a': 21, 'b': iter([{'x': 22, 'y': 23}, {'x': 24, 'y': 25}])},
    ... ]))
    Traceback (most recent call last):
    IndexError: too many values found during array assignment, expected 1
    """
    let StructWithArray[2] v
    v[:1] = x
    return v

def to_int_array_slice_start_end(x):
    """
    >>> to_int_array_slice_start_end([1, 2, 3])
    (1, 2, 3, 2, 3)
    """
    let i32[5] v
    v[2:] = x
    v[:3] = x
    return v[0], v[1], v[2], v[3], v[4]
'''
