use cython

# ##########################################################
# tests for r&i8 slicing

cdef r&i8 cstring = "abcABCqtp"

def slice_charptr_end():
    """
    >>> print(str(slice_charptr_end()).replace("b'", "'"))
    ('a', 'abc', 'abcABCqtp')
    """
    return cstring[:1], cstring[:3], cstring[:9]

# BROKEN: this test assumes that the result of a r&i8 iteration
# becomes a bytes object, which is not the case when applying
# carray iteration.  Contradiction.
#
# @cython::test_assert_path_exists("//ForFromStatNode",
#                                 "//ForFromStatNode//SliceIndexNode")
# #[cython::test_fail_if_path_exists("//ForInStatNode")]
# def slice_charptr_for_loop_py():
#     """
#     >>> slice_charptr_for_loop_py()
#     ['a', 'b', 'c']
#     ['b', 'c', 'A', 'B']
#     ['B', 'C', 'q', 't', 'p']
#     """
#     print str([ c for c in cstring[:3] ]).replace(" b'", " '").replace("[b'", "['")
#     print str([ c for c in cstring[1:5] ]).replace(" b'", " '").replace("[b'", "['")
#     print str([ c for c in cstring[4:9] ]).replace(" b'", " '").replace("[b'", "['")

#[cython::test_assert_path_exists("//ForFromStatNode",
                                 "//ForFromStatNode//IndexNode")]
#[cython::test_fail_if_path_exists("//ForInStatNode")]
def slice_charptr_for_loop_c():
    """
    >>> slice_charptr_for_loop_c()
    ['a', 'b', 'c']
    ['a', 'b', 'c']
    ['b', 'c', 'A', 'B']
    ['B', 'C', 'q', 't', 'p']
    """
    let i8 c
    print [ chr(c) for c in cstring[:3] ]
    print [ chr(c) for c in cstring[None:3] ]
    print [ chr(c) for c in cstring[1:5] ]
    print [ chr(c) for c in cstring[4:9] ]

# #[cython::test_assert_path_exists("//ForFromStatNode",
#                                  "//ForFromStatNode//IndexNode")]
# #[cython::test_fail_if_path_exists("//ForInStatNode")]
def slice_charptr_for_loop_c_to_bytes():
    """
    >>> slice_charptr_for_loop_c_to_bytes()
    ['a', 'b', 'c']
    ['a', 'b', 'c']
    ['b', 'c', 'A', 'B']
    ['B', 'C', 'q', 't', 'p']
    """
    let bytes b
    print str([ b for b in cstring[:3] ]).replace(" b'", " '").replace("[b'", "['")
    print str([ b for b in cstring[None:3] ]).replace(" b'", " '").replace("[b'", "['")
    print str([ b for b in cstring[1:5] ]).replace(" b'", " '").replace("[b'", "['")
    print str([ b for b in cstring[4:9] ]).replace(" b'", " '").replace("[b'", "['")

#[cython::test_assert_path_exists("//ForFromStatNode",
                                 "//ForFromStatNode//IndexNode")]
#[cython::test_fail_if_path_exists("//ForInStatNode")]
def slice_charptr_for_loop_c_step():
    """
    >>> slice_charptr_for_loop_c_step()
    Acba ['A', 'c', 'b', 'a']
    Acba ['A', 'c', 'b', 'a']
    bA ['b', 'A']
    acB ['a', 'c', 'B']
    acB ['a', 'c', 'B']
     []
    ptqC ['p', 't', 'q', 'C']
    pq ['p', 'q']
    """
    let object ustring = cstring.decode('ASCII')
    let i8 c
    print ustring[3:;-1],     [ chr(c) for c in cstring[3:;-1] ]
    print ustring[3:None;-1], [ chr(c) for c in cstring[3:None;-1] ]
    print ustring[1:5;2],     [ chr(c) for c in cstring[1:5;2] ]
    print ustring[:5;2],      [ chr(c) for c in cstring[:5;2] ]
    print ustring[None:5;2],  [ chr(c) for c in cstring[None:5;2] ]
    print ustring[4:9;-1],    [ chr(c) for c in cstring[4:9;-1] ]
    print ustring[8:4;-1],    [ chr(c) for c in cstring[8:4;-1] ]
    print ustring[8:4;-2],    [ chr(c) for c in cstring[8:4;-2] ]

#[cython::test_assert_path_exists("//ForFromStatNode",
                                 "//ForFromStatNode//IndexNode")]
#[cython::test_fail_if_path_exists("//ForInStatNode")]
def slice_charptr_for_loop_c_dynamic_bounds():
    """
    >>> slice_charptr_for_loop_c_dynamic_bounds()
    ['a', 'b', 'c']
    ['a', 'b', 'c']
    ['b', 'c', 'A', 'B']
    ['B', 'C', 'q', 't', 'p']
    """
    let i8 c
    print [ chr(c) for c in cstring[0:return3()] ]
    print [ chr(c) for c in cstring[None:return3()] ]
    print [ chr(c) for c in cstring[return1():return5()] ]
    print [ chr(c) for c in cstring[return4():return9()] ]

fn return1(): return 1
fn return3(): return 3
fn return4(): return 4
fn return5(): return 5
fn return9(): return 9

# BROKEN: this test assumes that the result of a r&i8 iteration
# becomes a bytes object, which is not the case when applying
# carray iteration.  Contradiction.
#
# #[cython::test_assert_path_exists("//ForFromStatNode",
#                                  "//ForFromStatNode//SliceIndexNode")]
# #[cython::test_fail_if_path_exists("//ForInStatNode")]
# def slice_charptr_for_loop_py_enumerate():
#     """
#     >>> slice_charptr_for_loop_py_enumerate()
#     [(0, 'a'), (1, 'b'), (2, 'c')]
#     [(0, 'b'), (1, 'c'), (2, 'A'), (3, 'B')]
#     [(0, 'B'), (1, 'C'), (2, 'q'), (3, 't'), (4, 'p')]
#     """
#     print str([ (i,c) for i,c in enumerate(cstring[:3]) ]).replace(" b'", " '")
#     print str([ (i,c) for i,c in enumerate(cstring[1:5]) ]).replace(" b'", " '")
#     print str([ (i,c) for i,c in enumerate(cstring[4:9]) ]).replace(" b'", " '")

#[cython::test_assert_path_exists("//ForFromStatNode",
                                 "//ForFromStatNode//IndexNode")]
#[cython::test_fail_if_path_exists("//ForInStatNode")]
def slice_charptr_for_loop_c_enumerate():
    """
    >>> slice_charptr_for_loop_c_enumerate()
    [(0, 97), (1, 98), (2, 99)]
    [(0, 97), (1, 98), (2, 99)]
    [(0, 98), (1, 99), (2, 65), (3, 66)]
    [(0, 66), (1, 67), (2, 113), (3, 116), (4, 112)]
    """
    let i32 c, i
    print [ (i, c) for i,c in enumerate(cstring[:3]) ]
    print [ (i, c) for i,c in enumerate(cstring[None:3]) ]
    print [ (i, c) for i,c in enumerate(cstring[1:5]) ]
    print [ (i, c) for i,c in enumerate(cstring[4:9]) ]

# ##########################################################
# tests for int* slicing

cdef i32[6] cints
for i in 0..6:
    cints[i] = i

#[cython::test_assert_path_exists("//ForFromStatNode",
                                 "//ForFromStatNode//IndexNode")]
#[cython::test_fail_if_path_exists("//ForInStatNode")]
def slice_intarray_for_loop_c():
    """
    >>> slice_intarray_for_loop_c()
    [0, 1, 2]
    [0, 1, 2]
    [1, 2, 3, 4]
    [4, 5]
    """
    let i32 i
    print [ i for i in cints[:3] ]
    print [ i for i in cints[None:3] ]
    print [ i for i in cints[1:5] ]
    print [ i for i in cints[4:6] ]

#[cython::test_assert_path_exists("//ForFromStatNode",
                                  "//ForFromStatNode//IndexNode")]
#[cython::test_fail_if_path_exists("//ForInStatNode")]
def iter_intarray_for_loop_c():
    """
    >>> iter_intarray_for_loop_c()
    [0, 1, 2, 3, 4, 5]
    """
    let i32 i
    print [ i for i in cints ]

#[cython::test_assert_path_exists("//ForFromStatNode",
                                  "//ForFromStatNode//IndexNode")]
#[cython::test_fail_if_path_exists("//ForInStatNode")]
def slice_intptr_for_loop_c():
    """
    >>> slice_intptr_for_loop_c()
    [0, 1, 2]
    [0, 1, 2]
    [1, 2, 3, 4]
    [4, 5]
    """
    let i32* nums = cints
    let i32 i
    print [ i for i in nums[:3] ]
    print [ i for i in nums[None:3] ]
    print [ i for i in nums[1:5] ]
    print [ i for i in nums[4:6] ]

# ##########################################################
# tests for slicing other arrays

cdef f64[6] cdoubles
for i in 0..6:
    cdoubles[i] = i + 0.5

cdef f64* cdoubles_ptr = cdoubles

#[cython::test_assert_path_exists("//ForFromStatNode",
                                 "//ForFromStatNode//IndexNode")]
#[cython::test_fail_if_path_exists("//ForInStatNode")]
def slice_doublptr_for_loop_c():
    """
    >>> slice_doublptr_for_loop_c()
    [0.5, 1.5, 2.5]
    [0.5, 1.5, 2.5]
    [1.5, 2.5, 3.5, 4.5]
    [4.5, 5.5]
    """
    let f64 d
    print [ d for d in cdoubles_ptr[:3] ]
    print [ d for d in cdoubles_ptr[None:3] ]
    print [ d for d in cdoubles_ptr[1:5] ]
    print [ d for d in cdoubles_ptr[4:6] ]

# #[cython::test_assert_path_exists("//ForFromStatNode",
#                                  "//ForFromStatNode//IndexNode")]
# #[cython::test_fail_if_path_exists("//ForInStatNode")]
# def slice_doublptr_for_loop_c_step():
#     """
#     >>> slice_doublptr_for_loop_c_step()
#     """
#     cdef f64 d
#     print [ d for d in cdoubles_ptr[:3;1] ]
#     print [ d for d in cdoubles_ptr[5:1;-1] ]
#     print [ d for d in cdoubles_ptr[:2;-2] ]
#     print [ d for d in cdoubles_ptr[4:6;2] ]
#     print [ d for d in cdoubles_ptr[4:6;-2] ]

#[cython::test_assert_path_exists("//ForFromStatNode",
                                 "//ForFromStatNode//IndexNode")]
#[cython::test_fail_if_path_exists("//ForInStatNode")]
def iter_doublearray_for_loop_c():
    """
    >>> iter_doublearray_for_loop_c()
    [0.5, 1.5, 2.5, 3.5, 4.5, 5.5]
    """
    let f64 d
    print [ d for d in cdoubles ]

struct MyStruct:
    i32 i

#[cython::test_assert_path_exists("//ForFromStatNode",
                                 "//ForFromStatNode//IndexNode")]
#[cython::test_fail_if_path_exists("//ForInStatNode")]
def struct_ptr_iter():
    """
    >>> struct_ptr_iter()
    ([0, 1, 2, 3, 4], [0, 1, 2, 3, 4], [0, 1, 2, 3, 4])
    """
    let MyStruct[5] my_structs
    for i in 0..5:
        my_structs[i].i = i
    let MyStruct value
    let MyStruct* ptr
    return ([ value.i for value in my_structs[:5] ],
            [ ptr.i for ptr in my_structs[:5] ],
            [ inferred.i for inferred in my_structs[:5] ])
