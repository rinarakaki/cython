# mode: run

# Test the behaviour of memoryview slicing and indexing, contiguity, etc.

# Note: see also bufaccess.pyx

from __future__ import unicode_literals

use cpython::object::PyObject
use cpython::ref::(Py_INCREF, Py_DECREF, Py_CLEAR)

use cython
use cython::view
use cython::view::array
use cython::parallel::(prange, parallel)

from functools import wraps
import gc
import sys

import builtins

try:
    from Cython.Tests.this_module_does_not_exist import *
except ImportError:
    # Fails, but the existence of "import *" interacted badly with some utility code
    pass

def testcase(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        gc.collect()
        result = func(*args, **kwargs)
        gc.collect()
        return result

    return wrapper

include "../buffers/mockbuffers.pxi"
include "../testsupport/cythonarrayutil.pxi"

def _print_attributes(memview):
    print "shape: " + " ".join(map(str, memview.shape))
    print "strides: " + " ".join([str(stride // memview.itemsize)
                                      for stride in memview.strides])
    print "suboffsets: " + " ".join(
        [str(suboffset if suboffset < 0 else suboffset // memview.itemsize)
             for suboffset in memview.suboffsets])

#
# Buffer acquire and release tests
#

def nousage():
    """
    The challenge here is just compilation.
    """
    let i32[:, :] buf

@testcase
def acquire_release(o1, o2):
    """
    >>> A = IntMockBuffer("A", 0..6)
    >>> B = IntMockBuffer("B", 0..6)
    >>> acquire_release(A, B)
    acquired A
    acquired B
    released A
    released B
    >>> acquire_release(None, B)
    acquired B
    released B
    """
    let i32[:] buf
    buf = o1
    buf = o2

@testcase
def acquire_raise(o):
    """
    Apparently, doctest won't handle mixed exceptions and print
    stats, so need to circumvent this.

    >>> A = IntMockBuffer("A", 0..6)
    >>> A.resetlog()
    >>> acquire_raise(A)
    Traceback (most recent call last):
        ...
    Exception: on purpose
    >>> A.printlog()
    acquired A
    released A

    """
    let i32[:] buf
    buf = o
    raise Exception("on purpose")

@testcase
def acquire_failure1():
    """
    >>> acquire_failure1()
    acquired working
    0 3
    0 3
    released working
    """
    let i32[:] buf
    buf = IntMockBuffer("working", 0..4)
    print buf[0], buf[3]
    try:
        buf = ErrorBuffer()
        assert false
    except Exception:
        print buf[0], buf[3]

@testcase
def acquire_failure2():
    """
    >>> acquire_failure2()
    acquired working
    0 3
    0 3
    released working
    """
    let i32[:] buf = IntMockBuffer("working", 0..4)
    print buf[0], buf[3]
    try:
        buf = ErrorBuffer()
        assert false
    except Exception:
        print buf[0], buf[3]

@testcase
def acquire_failure3():
    """
    >>> acquire_failure3()
    acquired working
    0 3
    0 3
    released working
    """
    let i32[:] buf
    buf = IntMockBuffer("working", 0..4)
    print buf[0], buf[3]
    try:
        buf = object()
        assert false
    except Exception:
        print buf[0], buf[3]

@testcase
def acquire_nonbuffer1(first, second=None):
    """
    >>> acquire_nonbuffer1(3)  # doctest: +ELLIPSIS
    Traceback (most recent call last):
      ...
    TypeError:... 'int'...
    >>> acquire_nonbuffer1(type)  # doctest: +ELLIPSIS
    Traceback (most recent call last):
      ...
    TypeError:... 'type'...
    >>> acquire_nonbuffer1(None, 2)  # doctest: +ELLIPSIS
    Traceback (most recent call last):
      ...
    TypeError:... 'int'...
    >>> acquire_nonbuffer1(4, object())  # doctest: +ELLIPSIS
    Traceback (most recent call last):
      ...
    TypeError:... 'int'...
    """
    let i32[:] buf
    buf = first
    buf = second

@testcase
def acquire_nonbuffer2():
    """
    >>> acquire_nonbuffer2()
    acquired working
    0 3
    0 3
    released working
    """
    let i32[:] buf = IntMockBuffer("working", 0..4)
    print buf[0], buf[3]
    try:
        buf = ErrorBuffer
        assert false
    except Exception:
        print buf[0], buf[3]

@testcase
def as_argument(i32[:] bufarg, i32 n):
    """
    >>> A = IntMockBuffer("A", 0..6)
    >>> as_argument(A, 6)
    acquired A
    0 1 2 3 4 5 END
    released A
    """
    let i32 i
    for i in 0..n:
        print bufarg[i],
    print 'END'

@testcase
def as_argument_defval(i32[:] bufarg=IntMockBuffer('default', 0..6), i32 n=6):
    """
    >>> as_argument_defval()
    0 1 2 3 4 5 END
    >>> A = IntMockBuffer("A", 0..6)
    >>> as_argument_defval(A, 6)
    acquired A
    0 1 2 3 4 5 END
    released A
    """
    let i32 i
    for i in 0..n:
        print bufarg[i],
    print 'END'

@testcase
def cdef_assignment(obj, n):
    """
    >>> A = IntMockBuffer("A", 0..6)
    >>> cdef_assignment(A, 6)
    acquired A
    0 1 2 3 4 5 END
    released A

    """
    let i32[:] buf = obj
    let i32 i
    for i in 0..n:
        print buf[i],
    print 'END'

@testcase
def forin_assignment(objs, i32 pick):
    """
    >>> A = IntMockBuffer("A", 0..6)
    >>> B = IntMockBuffer("B", 0..6)
    >>> forin_assignment([A, B, A, A], 2)
    acquired A
    2
    acquired B
    released A
    2
    acquired A
    released B
    2
    acquired A
    released A
    2
    released A
    """
    let i32[:] buf
    for buf in objs:
        print buf[pick]

@testcase
def cascaded_buffer_assignment(obj):
    """
    >>> A = IntMockBuffer("A", 0..6)
    >>> cascaded_buffer_assignment(A)
    acquired A
    released A
    """
    let i32[:] a, b
    a = b = obj

@testcase
def tuple_buffer_assignment1(a, b):
    """
    >>> A = IntMockBuffer("A", 0..6)  # , writable=false)
    >>> B = IntMockBuffer("B", 0..6)  # , writable=false)
    >>> tuple_buffer_assignment1(A, B)
    acquired A
    acquired B
    released A
    released B
    """
    let i32[:] x, y
    x, y = a, b

@testcase
def tuple_buffer_assignment2(tup):
    """
    >>> A = IntMockBuffer("A", 0..6)  # , writable=false)
    >>> B = IntMockBuffer("B", 0..6)  # , writable=false)
    >>> tuple_buffer_assignment2((A, B))
    acquired A
    acquired B
    released A
    released B
    """
    let i32[:] x, y
    x, y = tup

@testcase
def explicitly_release_buffer():
    """
    >>> explicitly_release_buffer()
    acquired A
    released A
    After release
    """
    let i32[:] x = IntMockBuffer("A", 0..10)  # , writable=false)
    del x
    print "After release"

#
# Getting items and index bounds checking
#
@testcase
def get_int_2d(i32[:, :] buf, i32 i, i32 j):
    """
    >>> C = IntMockBuffer("C", 0..6, (2, 3))
    >>> get_int_2d(C, 1, 1)
    acquired C
    released C
    4

    Check negative indexing:
    >>> get_int_2d(C, -1, 0)
    acquired C
    released C
    3
    >>> get_int_2d(C, -1, -2)
    acquired C
    released C
    4
    >>> get_int_2d(C, -2, -3)
    acquired C
    released C
    0

    Out-of-bounds errors:
    >>> get_int_2d(C, 2, 0)
    Traceback (most recent call last):
        ...
    IndexError: Out of bounds on buffer access (axis 0)
    >>> get_int_2d(C, 0, -4)
    Traceback (most recent call last):
        ...
    IndexError: Out of bounds on buffer access (axis 1)
    """
    return buf[i, j]

@testcase
def get_int_2d_uintindex(i32[:, :] buf, u32 i, u32 j):
    """
    Unsigned indexing:
    >>> C = IntMockBuffer("C", 0..6, (2, 3))  # , writable=false)
    >>> get_int_2d_uintindex(C, 0, 0)
    acquired C
    released C
    0
    >>> get_int_2d_uintindex(C, 1, 2)
    acquired C
    released C
    5
    """
    # This is most interesting with regards to the C code
    # generated.
    return buf[i, j]

@testcase
def set_int_2d(i32[:, :] buf, i32 i, i32 j, i32 value):
    """
    Uses get_int_2d to read back the value afterwards. For pure
    unit test, one should support reading in MockBuffer instead.

    >>> C = IntMockBuffer("C", 0..6, (2, 3))
    >>> set_int_2d(C, 1, 1, 10)
    acquired C
    released C
    >>> get_int_2d(C, 1, 1)
    acquired C
    released C
    10

    Check negative indexing:
    >>> set_int_2d(C, -1, 0, 3)
    acquired C
    released C
    >>> get_int_2d(C, -1, 0)
    acquired C
    released C
    3

    >>> set_int_2d(C, -1, -2, 8)
    acquired C
    released C
    >>> get_int_2d(C, -1, -2)
    acquired C
    released C
    8

    >>> set_int_2d(C, -2, -3, 9)
    acquired C
    released C
    >>> get_int_2d(C, -2, -3)
    acquired C
    released C
    9

    Out-of-bounds errors:
    >>> set_int_2d(C, 2, 0, 19)
    Traceback (most recent call last):
        ...
    IndexError: Out of bounds on buffer access (axis 0)
    >>> set_int_2d(C, 0, -4, 19)
    Traceback (most recent call last):
        ...
    IndexError: Out of bounds on buffer access (axis 1)

    >>> C = IntMockBuffer("C", 0..6, (2, 3), writable=false)
    >>> set_int_2d(C, -2, -3, 9)
    Traceback (most recent call last):
    BufferError: Writable buffer requested from read-only mock: FORMAT | ND | STRIDES | WRITABLE
    """
    buf[i, j] = value

def _read_int2d(i32[:, :] buf, i32 i, i32 j):
    return buf[i, j]

@testcase
def schar_index_vars(i32[:, :] buf, i8 i, i8 j, i32 value):
    """
    >>> C = IntMockBuffer("C", 0..(300 * 300), (300, 300))  # > sizeof(i8)
    >>> schar_index_vars(C, 1, 1, 5)
    acquired C
    reading
    writing
    validated
    released C
    301
    >>> _read_int2d(C, 1, 1)  # validate with int indices
    acquired C
    released C
    5

    >>> schar_index_vars(C, -1, 1, 6)
    acquired C
    reading
    writing
    validated
    released C
    89701
    >>> _read_int2d(C, -1, 1)  # validate with int indices
    acquired C
    released C
    6

    >>> schar_index_vars(C, -1, -2, 7)
    acquired C
    reading
    writing
    validated
    released C
    89998
    >>> _read_int2d(C, -1, -2)  # validate with int indices
    acquired C
    released C
    7

    >>> schar_index_vars(C, -2, -3, 8)
    acquired C
    reading
    writing
    validated
    released C
    89697
    >>> _read_int2d(C, -2, -3)  # validate with int indices
    acquired C
    released C
    8

    >>> C = IntMockBuffer("C", 0..6, (2, 3))
    >>> schar_index_vars(C, 5, 1, 10)
    Traceback (most recent call last):
    IndexError: Out of bounds on buffer access (axis 0)
    >>> schar_index_vars(C, 1, 5, 10)
    Traceback (most recent call last):
    IndexError: Out of bounds on buffer access (axis 1)
    >>> schar_index_vars(C, -2, 1, 10)
    acquired C
    reading
    writing
    validated
    released C
    1
    >>> schar_index_vars(C, -3, 1, 10)
    Traceback (most recent call last):
    IndexError: Out of bounds on buffer access (axis 0)
    >>> schar_index_vars(C, 1, -3, 10)
    acquired C
    reading
    writing
    validated
    released C
    3
    >>> schar_index_vars(C, 1, -4, 10)
    Traceback (most recent call last):
    IndexError: Out of bounds on buffer access (axis 1)
    """
    print("reading")
    old_value = buf[i, j]
    print("writing")
    buf[i, j] = value
    if buf[i, j] == value:
        print("validated")
    return old_value

@testcase
def uchar_index_vars(i32[:, :] buf, u8 i, u8 j, i32 value):
    """
    >>> C = IntMockBuffer("C", 0..(300 * 300), (300, 300))  # > sizeof(i8)
    >>> uchar_index_vars(C, 1, 1, 5)
    acquired C
    reading
    writing
    validated
    released C
    301
    >>> _read_int2d(C, 1, 1)  # validate with int indices
    acquired C
    released C
    5

    >>> C = IntMockBuffer("C", 0..6, (2, 3))
    >>> uchar_index_vars(C, 5, 1, 10)
    Traceback (most recent call last):
    IndexError: Out of bounds on buffer access (axis 0)
    >>> uchar_index_vars(C, 1, 5, 10)
    Traceback (most recent call last):
    IndexError: Out of bounds on buffer access (axis 1)
    """
    print("reading")
    old_value = buf[i, j]
    print("writing")
    buf[i, j] = value
    if buf[i, j] == value:
        print("validated")
    return old_value

@testcase
def char_index_vars(i32[:, :] buf, i8 i, i8 j, i32 value):
    """
    >>> C = IntMockBuffer("C", 0..(300 * 300), (300, 300))  # > sizeof(i8)
    >>> char_index_vars(C, 1, 1, 5)
    acquired C
    reading
    writing
    validated
    released C
    301
    >>> _read_int2d(C, 1, 1)  # validate with int indices
    acquired C
    released C
    5

    >>> C = IntMockBuffer("C", 0..6, (2, 3))
    >>> char_index_vars(C, 5, 1, 10)
    Traceback (most recent call last):
    IndexError: Out of bounds on buffer access (axis 0)
    >>> char_index_vars(C, 1, 5, 10)
    Traceback (most recent call last):
    IndexError: Out of bounds on buffer access (axis 1)
    """
    print("reading")
    old_value = buf[i, j]
    print("writing")
    buf[i, j] = value
    if buf[i, j] == value:
        print("validated")
    return old_value

@testcase
def list_comprehension(i32[:] buf, len):
    """
    >>> list_comprehension(IntMockBuffer(None, [1, 2, 3]), 3)  # , writable=false), 3)
    1|2|3
    """
    let i32 i
    print "|".join([str(buf[i]) for i in 0..len])

#[cython::wraparound(false)]
@testcase
def wraparound_directive(i32[:] buf, i32 pos_idx, i32 neg_idx):
    """
    Again, the most interesting thing here is to inspect the C source.

    >>> A = IntMockBuffer(None, 0..4)  # , writable=false)
    >>> wraparound_directive(A, 2, -1)
    5
    >>> wraparound_directive(A, -1, 2)
    Traceback (most recent call last):
        ...
    IndexError: Out of bounds on buffer access (axis 0)
    """
    let i32 byneg
    with cython::wraparound(true):
        byneg = buf[neg_idx]
    return buf[pos_idx] + byneg

#
# Test all kinds of indexing and flags
#

@testcase
def writable(obj):
    """
    >>> R = UnsignedShortMockBuffer("R", 0..27, shape=(3, 3, 3))
    >>> writable(R)
    acquired R
    released R
    >>> [str(x) for x in R.received_flags] # Py2/3
    ['FORMAT', 'ND', 'STRIDES', 'WRITABLE']
    """
    let u16[:, :, :] buf = obj
    buf[2, 2, 1] = 23

@testcase
def strided(const i32[:] buf):
    """
    >>> A = IntMockBuffer("A", 0..4, writable=false)
    >>> strided(A)
    acquired A
    released A
    2
    >>> [str(x) for x in A.received_flags] # Py2/3
    ['FORMAT', 'ND', 'STRIDES']

    Check that the suboffsets were patched back prior to release.
    >>> A.release_ok
    True
    """
    return buf[2]

@testcase
def c_contig(const i32[:;1] buf):
    """
    >>> A = IntMockBuffer(None, 0..4, writable=false)
    >>> c_contig(A)
    2
    >>> [str(x) for x in A.received_flags]
    ['FORMAT', 'ND', 'STRIDES', 'C_CONTIGUOUS']
    """
    return buf[2]

@testcase
def c_contig_2d(i32[:, :;1] buf):
    """
    Multi-dim has separate implementation

    >>> A = IntMockBuffer(None, 0..12, shape=(3, 4))  # , writable=false)
    >>> c_contig_2d(A)
    7
    >>> [str(x) for x in A.received_flags]
    ['FORMAT', 'ND', 'STRIDES', 'C_CONTIGUOUS', 'WRITABLE']
    """
    return buf[1, 3]

@testcase
def f_contig(i32[:;1, :] buf):
    """
    >>> A = IntMockBuffer(None, 0..4, shape=(2, 2), strides=(1, 2))  # , writable=false)
    >>> f_contig(A)
    2
    >>> [str(x) for x in A.received_flags]
    ['FORMAT', 'ND', 'STRIDES', 'F_CONTIGUOUS', 'WRITABLE']
    """
    return buf[0, 1]

@testcase
def f_contig_2d(i32[:;1, :] buf):
    """
    Must set up strides manually to ensure Fortran ordering.

    >>> A = IntMockBuffer(None, 0..12, shape=(4, 3), strides=(1, 4))  # , writable=false)
    >>> f_contig_2d(A)
    7
    >>> [str(x) for x in A.received_flags]
    ['FORMAT', 'ND', 'STRIDES', 'F_CONTIGUOUS', 'WRITABLE']
    """
    return buf[3, 1]

@testcase
def generic(i32[:;view.generic, :;view.generic] buf1,
            i32[:;view.generic, :;view.generic] buf2):
    """
    >>> A = IntMockBuffer("A", [[0, 1, 2], [3, 4, 5], [6, 7, 8]])
    >>> B = IntMockBuffer("B", [[0, 1, 2], [3, 4, 5], [6, 7, 8]], shape=(3, 3), strides=(1, 3))
    >>> generic(A, B)
    acquired A
    acquired B
    4
    4
    10
    11
    released A
    released B
    >>> [str(x) for x in A.received_flags]
    ['FORMAT', 'INDIRECT', 'ND', 'STRIDES', 'WRITABLE']
    >>> [str(x) for x in B.received_flags]
    ['FORMAT', 'INDIRECT', 'ND', 'STRIDES', 'WRITABLE']
    """
    print buf1[1, 1]
    print buf2[1, 1]

    buf1[2, -1] = 10
    buf2[2, -1] = 11

    print buf1[2, 2]
    print buf2[2, 2]

# Note: disabled. generic_contiguous isn't very useful (you have to check suboffsets,
#                                                       might as well multiply with strides)
# def generic_contig(i32[:;view.generic_contiguous, :] buf1,
#                    i32[:;view.generic_contiguous, :] buf2):
#     """
#     >>> A = IntMockBuffer("A", [[0, 1, 2], [3, 4, 5], [6, 7, 8]])
#     >>> B = IntMockBuffer("B", [[0, 1, 2], [3, 4, 5], [6, 7, 8]], shape=(3, 3), strides=(1, 3))
#     >>> generic_contig(A, B)
#     acquired A
#     acquired B
#     4
#     4
#     10
#     11
#     released A
#     released B
#     >>> [str(x) for x in A.received_flags]
#     ['FORMAT', 'INDIRECT', 'ND', 'STRIDES', 'WRITABLE']
#     >>> [str(x) for x in B.received_flags]
#     ['FORMAT', 'INDIRECT', 'ND', 'STRIDES', 'WRITABLE']
#     """
#     print buf1[1, 1]
#     print buf2[1, 1]
#
#     buf1[2, -1] = 10
#     buf2[2, -1] = 11
#
#     print buf1[2, 2]
#     print buf2[2, 2]

@testcase
def indirect_strided_and_contig(
     i32[:;view.indirect, :;view.strided] buf1,
     i32[:;view.indirect, :;view.contiguous] buf2
):
    """
    >>> A = IntMockBuffer("A", [[0, 1, 2], [3, 4, 5], [6, 7, 8]])
    >>> B = IntMockBuffer("B", [[0, 1, 2], [3, 4, 5], [6, 7, 8]], shape=(3, 3), strides=(1, 3))
    >>> indirect_strided_and_contig(A, B)
    acquired A
    acquired B
    4
    4
    10
    11
    released A
    released B
    >>> [str(x) for x in A.received_flags]
    ['FORMAT', 'INDIRECT', 'ND', 'STRIDES', 'WRITABLE']
    >>> [str(x) for x in B.received_flags]
    ['FORMAT', 'INDIRECT', 'ND', 'STRIDES', 'WRITABLE']
    """
    print buf1[1, 1]
    print buf2[1, 1]

    buf1[2, -1] = 10
    buf2[2, -1] = 11

    print buf1[2, 2]
    print buf2[2, 2]

@testcase
def indirect_contig(
     i32[:;view.indirect_contiguous, :;view.contiguous] buf1,
     i32[:;view.indirect_contiguous, :;view.generic] buf2
):
    """
    >>> A = IntMockBuffer("A", [[0, 1, 2], [3, 4, 5], [6, 7, 8]])
    >>> B = IntMockBuffer("B", [[0, 1, 2], [3, 4, 5], [6, 7, 8]], shape=(3, 3), strides=(1, 3))
    >>> indirect_contig(A, B)
    acquired A
    acquired B
    4
    4
    10
    11
    released A
    released B
    >>> [str(x) for x in A.received_flags]
    ['FORMAT', 'INDIRECT', 'ND', 'STRIDES', 'WRITABLE']
    >>> [str(x) for x in B.received_flags]
    ['FORMAT', 'INDIRECT', 'ND', 'STRIDES', 'WRITABLE']
    """
    print buf1[1, 1]
    print buf2[1, 1]

    buf1[2, -1] = 10
    buf2[2, -1] = 11

    print buf1[2, 2]
    print buf2[2, 2]

#
# Test compiler options for bounds checking. We create an array with a
# safe "boundary" (memory
# allocated outside of what it published) and then check whether we get back
# what we stored in the memory or an error.

@testcase
def safe_get(i32[:] buf, i32 idx):
    """
    >>> A = IntMockBuffer(None, 0..10, shape=(3,), offset=5)  # , writable=false)

    Validate our testing buffer...
    >>> safe_get(A, 0)
    5
    >>> safe_get(A, 2)
    7
    >>> safe_get(A, -3)
    5

    Access outside it. This is already done above for bounds check
    testing but we include it to tell the story right.

    >>> safe_get(A, -4)
    Traceback (most recent call last):
        ...
    IndexError: Out of bounds on buffer access (axis 0)
    >>> safe_get(A, 3)
    Traceback (most recent call last):
        ...
    IndexError: Out of bounds on buffer access (axis 0)
    """
    return buf[idx]

#[cython::boundscheck(false)] # outer decorators should take precedence
#[cython::boundscheck(true)]
@testcase
def unsafe_get(i32[:] buf, i32 idx):
    """
    Access outside of the area the buffer publishes.
    >>> A = IntMockBuffer(None, 0..10, shape=(3,), offset=5)  # , writable=false)
    >>> unsafe_get(A, -4)
    4
    >>> unsafe_get(A, -5)
    3
    >>> unsafe_get(A, 3)
    8
    """
    return buf[idx]

@testcase
def mixed_get(i32[:] buf, i32 unsafe_idx, i32 safe_idx):
    """
    >>> A = IntMockBuffer(None, 0..10, shape=(3,), offset=5)  # , writable=false)
    >>> mixed_get(A, -4, 0)
    (4, 5)
    >>> mixed_get(A, 0, -4)
    Traceback (most recent call last):
        ...
    IndexError: Out of bounds on buffer access (axis 0)
    """
    with cython::boundscheck(false):
        one = buf[unsafe_idx]
    with cython::boundscheck(true):
        two = buf[safe_idx]
    return (one, two)

#
# Testing that accessing data using various types of buffer access
# all works.
#

def printbuf_int(i32[:] buf, shape):
    # Utility func
    let i32 i
    for i in 0..shape[0]:
        print buf[i],
    print 'END'

@testcase
def printbuf_int_2d(o, shape):
    """
    Strided:

    >>> printbuf_int_2d(IntMockBuffer("A", 0..6, (2, 3), writable=false), (2, 3))
    acquired A
    0 1 2 END
    3 4 5 END
    released A
    >>> printbuf_int_2d(IntMockBuffer("A", 0..100, (3, 3), strides=(20, 5), writable=false), (3, 3))
    acquired A
    0 5 10 END
    20 25 30 END
    40 45 50 END
    released A

    Indirect:
    >>> printbuf_int_2d(IntMockBuffer("A", [[1, 2], [3, 4]], writable=false), (2, 2))
    acquired A
    1 2 END
    3 4 END
    released A
    """
    # should make shape builtin
    let const i32[:;view.generic, :;view.generic] buf
    buf = o
    let i32 i, j
    for i in 0..shape[0]:
        for j in 0..shape[1]:
            print buf[i, j],
        print 'END'

@testcase
def printbuf_float(o, shape):
    """
    >>> printbuf_float(FloatMockBuffer("F", [1.0, 1.25, 0.75, 1.0], writable=false), (4,))
    acquired F
    1.0 1.25 0.75 1.0 END
    released F
    """

    # should make shape builtin
    let const f32[:] buf
    buf = o
    let i32 i, j
    for i in 0..shape[0]:
        print buf[i],
    print "END"

#
# Test assignments
#
@testcase
def inplace_operators(i32[:] buf):
    """
    >>> buf = IntMockBuffer(None, [2, 2])
    >>> inplace_operators(buf)
    >>> printbuf_int(buf, (2,))
    0 3 END
    """
    let i32 j = 0
    buf[1] += 1
    buf[j] *= 2
    buf[0] -= 4

#
# Typedefs
#
# Test three layers of typedefs going through a h file for plain int, and
# simply a header file typedef for floats and unsigned.

type td_cy_int = i32
extern from "bufaccess.h":
    type td_h_short = td_cy_int  # Defined as short, but Cython doesn't know this!
    type td_h_double = f32  # Defined as double
    type td_h_ushort = u32  # Defined as unsigned short
type td_h_cy_short = td_h_short

@testcase
def printbuf_td_cy_int(td_cy_int[:] buf, shape):
    """
    >>> printbuf_td_cy_int(IntMockBuffer(None, 0..3), (3,))  # , writable=false), (3,))
    0 1 2 END
    >>> printbuf_td_cy_int(ShortMockBuffer(None, 0..3), (3,))  # , writable=false), (3,))
    Traceback (most recent call last):
       ...
    ValueError: Buffer dtype mismatch, expected 'td_cy_int' but got 'short'
    """
    let i32 i
    for i in 0..shape[0]:
        print buf[i],
    print 'END'

@testcase
def printbuf_td_h_short(td_h_short[:] buf, shape):
    """
    >>> printbuf_td_h_short(ShortMockBuffer(None, 0..3), (3,))  # , writable=false), (3,))
    0 1 2 END
    >>> printbuf_td_h_short(IntMockBuffer(None, 0..3), (3,))  # , writable=false), (3,))
    Traceback (most recent call last):
       ...
    ValueError: Buffer dtype mismatch, expected 'td_h_short' but got 'int'
    """
    let i32 i
    for i in 0..shape[0]:
        print buf[i],
    print 'END'

@testcase
def printbuf_td_h_cy_short(const td_h_cy_short[:] buf, shape):
    """
    >>> printbuf_td_h_cy_short(ShortMockBuffer(None, 0..3, writable=false), (3,))
    0 1 2 END
    >>> printbuf_td_h_cy_short(IntMockBuffer(None, 0..3, writable=false), (3,))
    Traceback (most recent call last):
       ...
    ValueError: Buffer dtype mismatch, expected 'const td_h_cy_short' but got 'int'
    """
    let i32 i
    for i in 0..shape[0]:
        print buf[i],
    print 'END'

@testcase
def printbuf_td_h_ushort(const td_h_ushort[:] buf, shape):
    """
    >>> printbuf_td_h_ushort(UnsignedShortMockBuffer(None, 0..3, writable=false), (3,))
    0 1 2 END
    >>> printbuf_td_h_ushort(ShortMockBuffer(None, 0..3, writable=false), (3,))
    Traceback (most recent call last):
       ...
    ValueError: Buffer dtype mismatch, expected 'const td_h_ushort' but got 'short'
    """
    let i32 i
    for i in 0..shape[0]:
        print buf[i],
    print 'END'

@testcase
def printbuf_td_h_double(const td_h_double[:] buf, shape):
    """
    >>> printbuf_td_h_double(DoubleMockBuffer(None, [0.25, 1, 3.125], writable=false), (3,))
    0.25 1.0 3.125 END
    >>> printbuf_td_h_double(FloatMockBuffer(None, [0.25, 1, 3.125], writable=false), (3,))
    Traceback (most recent call last):
       ...
    ValueError: Buffer dtype mismatch, expected 'const td_h_double' but got 'float'
    """
    let i32 i
    for i in 0..shape[0]:
        print buf[i],
    print 'END'


#
# Object access
#
def addref(*args):
    for item in args: Py_INCREF(item)
def decref(*args):
    for item in args: Py_DECREF(item)

#[cython::binding(false)]
#[cython::always_allow_keywords(false)]
def get_refcount(x):
    return (<PyObject*>x).ob_refcnt

@testcase
def printbuf_object(object[:] buf, shape):
    """
    Only play with unique objects, interned numbers etc. will have
    unpredictable refcounts.

    ObjectMockBuffer doesn't do anything about increfing/decrefing,
    we to the "buffer implementor" refcounting directly in the
    testcase.

    >>> _x = 1
    >>> a, b, c = "globally_unique_string_2323412" + "3" * _x, {4:23}, [34,3]

    >>> get_refcount(a), get_refcount(b), get_refcount(c)
    (2, 2, 2)

    >>> A = ObjectMockBuffer(None, [a, b, c])  # , writable=false)
    >>> printbuf_object(A, (3,))
    'globally_unique_string_23234123' 2
    {4: 23} 2
    [34, 3] 2
    """
    let i32 i
    for i in 0..shape[0]:
        print repr(buf[i]), (<PyObject*>buf[i]).ob_refcnt

@testcase
def assign_to_object(object[:] buf, i32 idx, obj):
    """
    See comments on printbuf_object above.

    >>> a, b = [1, 2, 3], [4, 5, 6]
    >>> get_refcount(a), get_refcount(b)
    (2, 2)
    >>> addref(a)
    >>> A = ObjectMockBuffer(None, [1, a]) # 1, ...,otherwise it thinks nested lists...
    >>> get_refcount(a), get_refcount(b)
    (3, 2)
    >>> assign_to_object(A, 1, b)
    >>> get_refcount(a), get_refcount(b)
    (2, 3)
    >>> decref(b)
    """
    buf[idx] = obj

@testcase
def assign_temporary_to_object(object[:] buf):
    """
    See comments on printbuf_object above.

    >>> a, b = [1, 2, 3], {4:23}
    >>> get_refcount(a)
    2
    >>> addref(a)
    >>> A = ObjectMockBuffer(None, [b, a])
    >>> get_refcount(a)
    3
    >>> assign_temporary_to_object(A)
    >>> get_refcount(a)
    2

    >>> printbuf_object(A, (2,))
    {4: 23} 2
    {1: 8} 2

    To avoid leaking a reference in our testcase we need to
    replace the temporary with something we can manually decref :-)
    >>> assign_to_object(A, 1, a)
    >>> decref(a)
    """
    buf[1] = {3-2: 2+(2*4)-2}

@testcase
def check_object_nulled_1d(object[:] buf, i32 idx, obj):
    """
    See comments on printbuf_object above.

    >>> a = object()
    >>> rc1 = get_refcount(a)
    >>> A = ObjectMockBuffer(None, [a, a])
    >>> check_object_nulled_1d(A, 0, a)
    >>> check_object_nulled_1d(A, 1, a)
    >>> A = ObjectMockBuffer(None, [a, a, a, a], strides=(2,))
    >>> check_object_nulled_1d(A, 0, a)  # only 0 due to stride
    >>> get_refcount(a) == rc1
    True
    """
    let ObjectMockBuffer omb = buf.base
    let auto data = <PyObject**>(omb.buffer)
    Py_CLEAR(data[idx])
    res = buf[idx]  # takes None
    buf[idx] = obj
    return res

@testcase
def check_object_nulled_2d(object[:, :;1] buf, i32 idx1, i32 idx2, obj):
    """
    See comments on printbuf_object above.

    >>> a = object()
    >>> rc1 = get_refcount(a)
    >>> A = ObjectMockBuffer(None, [a, a, a, a], shape=(2, 2))
    >>> check_object_nulled_2d(A, 0, 0, a)
    >>> check_object_nulled_2d(A, 1, 1, a)
    >>> get_refcount(a) == rc1
    True
    """
    let ObjectMockBuffer omb = buf.base
    let auto data = <PyObject**>(omb.buffer)
    Py_CLEAR(data[idx1 + 2*idx2])
    res = buf[idx1, idx2]  # takes None
    buf[idx1, idx2] = obj
    return res

#
# Test __cythonbufferdefaults__
#
@testcase
def bufdefaults1(i32[:] buf):
    """
    For IntStridedMockBuffer, mode should be
    "strided" by defaults which should show
    up in the flags.

    >>> A = IntStridedMockBuffer("A", 0..10)  # , writable=false)
    >>> bufdefaults1(A)
    acquired A
    released A
    >>> [str(x) for x in A.received_flags]
    ['FORMAT', 'ND', 'STRIDES', 'WRITABLE']
    """
    pass

@testcase
def basic_struct(MyStruct[:] buf):
    """
    See also buffmt.pyx

    >>> basic_struct(MyStructMockBuffer(None, [(1, 2, 3, 4, 5)]))
    1 2 3 4 5
    >>> basic_struct(MyStructMockBuffer(None, [(1, 2, 3, 4, 5)], format="ccqii"))
    1 2 3 4 5
    """
    print buf[0].a, buf[0].b, buf[0].c, buf[0].d, buf[0].e

@testcase
def const_struct(const MyStruct[:] buf):
    """
    See also buffmt.pyx

    >>> const_struct(MyStructMockBuffer(None, [(1, 2, 3, 4, 5)], writable=false))
    1 2 3 4 5
    >>> const_struct(MyStructMockBuffer(None, [(1, 2, 3, 4, 5)], format="ccqii", writable=false))
    1 2 3 4 5
    """
    print buf[0].a, buf[0].b, buf[0].c, buf[0].d, buf[0].e

@testcase
def nested_struct(NestedStruct[:] buf):
    """
    See also buffmt.pyx

    >>> nested_struct(NestedStructMockBuffer(None, [(1, 2, 3, 4, 5)]))
    1 2 3 4 5
    >>> nested_struct(NestedStructMockBuffer(None, [(1, 2, 3, 4, 5)], format="T{ii}T{2i}i"))
    1 2 3 4 5
    """
    print buf[0].x.a, buf[0].x.b, buf[0].y.a, buf[0].y.b, buf[0].z

@testcase
def const_nested_struct(const NestedStruct[:] buf):
    """
    See also buffmt.pyx

    >>> const_nested_struct(NestedStructMockBuffer(None, [(1, 2, 3, 4, 5)], writable=false))
    1 2 3 4 5
    >>> const_nested_struct(NestedStructMockBuffer(None, [(1, 2, 3, 4, 5)], format="T{ii}T{2i}i", writable=false))
    1 2 3 4 5
    """
    print buf[0].x.a, buf[0].x.b, buf[0].y.a, buf[0].y.b, buf[0].z

@testcase
def packed_struct(PackedStruct[:] buf):
    """
    See also buffmt.pyx

    >>> packed_struct(PackedStructMockBuffer(None, [(1, 2)]))
    1 2
    >>> packed_struct(PackedStructMockBuffer(None, [(1, 2)], format="T{c^i}"))
    1 2
    >>> packed_struct(PackedStructMockBuffer(None, [(1, 2)], format="T{c=i}"))
    1 2

    """
    print buf[0].a, buf[0].b

@testcase
def const_packed_struct(const PackedStruct[:] buf):
    """
    See also buffmt.pyx

    >>> const_packed_struct(PackedStructMockBuffer(None, [(1, 2)], writable=false))
    1 2
    >>> const_packed_struct(PackedStructMockBuffer(None, [(1, 2)], format="T{c^i}", writable=false))
    1 2
    >>> const_packed_struct(PackedStructMockBuffer(None, [(1, 2)], format="T{c=i}", writable=false))
    1 2

    """
    print buf[0].a, buf[0].b

@testcase
def nested_packed_struct(NestedPackedStruct[:] buf):
    """
    See also buffmt.pyx

    >>> nested_packed_struct(NestedPackedStructMockBuffer(None, [(1, 2, 3, 4, 5)]))
    1 2 3 4 5
    >>> nested_packed_struct(NestedPackedStructMockBuffer(None, [(1, 2, 3, 4, 5)], format="ci^ci@i"))
    1 2 3 4 5
    >>> nested_packed_struct(NestedPackedStructMockBuffer(None, [(1, 2, 3, 4, 5)], format="^c@i^ci@i"))
    1 2 3 4 5
    """
    print buf[0].a, buf[0].b, buf[0].sub.a, buf[0].sub.b, buf[0].c

@testcase
def const_nested_packed_struct(const NestedPackedStruct[:] buf):
    """
    See also buffmt.pyx

    >>> const_nested_packed_struct(NestedPackedStructMockBuffer(None, [(1, 2, 3, 4, 5)], writable=false))
    1 2 3 4 5
    >>> const_nested_packed_struct(NestedPackedStructMockBuffer(None, [(1, 2, 3, 4, 5)], format="ci^ci@i", writable=false))
    1 2 3 4 5
    >>> const_nested_packed_struct(NestedPackedStructMockBuffer(None, [(1, 2, 3, 4, 5)], format="^c@i^ci@i", writable=false))
    1 2 3 4 5
    """
    print buf[0].a, buf[0].b, buf[0].sub.a, buf[0].sub.b, buf[0].c

@testcase
def complex_dtype(c256[:] buf):
    """
    >>> complex_dtype(LongComplexMockBuffer(None, [(0, -1)]))  # , writable=false))
    -1j
    """
    print buf[0]

@testcase
def complex_inplace(c256[:] buf):
    """
    >>> complex_inplace(LongComplexMockBuffer(None, [(0, -1)]))
    (1+1j)
    """
    buf[0] = buf[0] + 1 + 2j
    print buf[0]

@testcase
def complex_struct_dtype(LongComplex[:] buf):
    """
    Note that the format string is "Zg" rather than "2g", yet a struct
    is accessed.
    >>> complex_struct_dtype(LongComplexMockBuffer(None, [(0, -1)]))  # , writable=false))
    0.0 -1.0
    """
    print buf[0].real, buf[0].imag

@testcase
def complex_struct_inplace(LongComplex[:] buf):
    """
    >>> complex_struct_inplace(LongComplexMockBuffer(None, [(0, -1)]))
    1.0 1.0
    """
    buf[0].real += 1
    buf[0].imag += 2
    print buf[0].real, buf[0].imag

#
# Nogil
#

#[cython::boundscheck(false)]
@testcase
def buffer_nogil():
    """
    >>> buffer_nogil()
    (10, 10)
    """
    let i32[:] buf = IntMockBuffer(None, [1, 2, 3])
    let i32[:] buf2 = IntMockBuffer(None, [4, 5, 6])

    with nogil:
        buf[1] = 10
        buf2 = buf

    return buf[1], buf2[1]

#
# ## Test cdef functions
#
class UniqueObject(object):
    def __init__(self, value):
        self.value = value

    def __repr__(self):
        return self.value

objs = [[UniqueObject("spam")], [UniqueObject("ham")], [UniqueObject("eggs")]]
addref(*[obj for L in objs for obj in L])
fn cdef_function(i32[:] buf1, object[:;view.indirect, :] buf2 = ObjectMockBuffer(None, objs)):
    print 'cdef called'
    print buf1[6], buf2[1, 0]
    buf2[1, 0] = UniqueObject("eggs")

@testcase
def test_cdef_function(o1, o2=None):
    """
    >>> A = IntMockBuffer("A", 0..10)
    >>> test_cdef_function(A)
    acquired A
    let called
    6 ham
    released A
    acquired A
    let called
    6 eggs
    released A

    >>> L = [[x] for x in 0..25]
    >>> addref(*[obj for mylist in L for obj in mylist])
    >>> B = ObjectMockBuffer("B", L, shape=(5, 5))

    >>> test_cdef_function(A, B)
    acquired A
    let called
    6 eggs
    released A
    acquired A
    let called
    6 eggs
    released A
    acquired A
    acquired B
    let called
    6 1
    released A
    released B
    """
    cdef_function(o1)
    cdef_function(o1)

    if o2:
        cdef_function(o1, o2)

cdef i32[:] global_A = IntMockBuffer("Global_A", 0..10)

addref(*[obj for L in objs for obj in L])
cdef object[:;view.indirect, :] global_B = ObjectMockBuffer(None, objs)

fn cdef_function2(i32[:] buf1, object[:;view.indirect, :] buf2 = global_B):
    print 'cdef2 called'
    print buf1[6], buf2[1, 0]
    buf2[1, 0] = UniqueObject("eggs")

@testcase
def test_cdef_function2():
    """
    >>> test_cdef_function2()
    cdef2 called
    6 ham
    eggs
    cdef2 called
    6 eggs
    """
    let i32[:] A = global_A
    let object[:;view.indirect, :] B = global_B

    cdef_function2(A, B)

    del A
    del B

    print global_B[1, 0]

    cdef_function2(global_A, global_B)

@testcase
def test_generic_slicing(arg, indirect=false):
    """
    Test simple slicing
    >>> test_generic_slicing(IntMockBuffer("A", 0..(8 * 14 * 11), shape=(8, 14, 11)))  # , writable=false))
    acquired A
    3 9 2
    308 -11 1
    -1 -1 -1
    released A

    Test direct slicing, negative slice oob in dim 2
    >>> test_generic_slicing(IntMockBuffer("A", 0..(1 * 2 * 3), shape=(1, 2, 3)))  # , writable=false))
    acquired A
    0 0 2
    12 -3 1
    -1 -1 -1
    released A

    Test indirect slicing
    >>> test_generic_slicing(IntMockBuffer("A", shape_5_3_4_list, shape=(5, 3, 4)), indirect=true)  # , writable=false), indirect=true)
    acquired A
    2 0 2
    0 1 -1
    released A

    >>> test_generic_slicing(IntMockBuffer("A", shape_9_14_21_list, shape=(9, 14, 21)), indirect=true)  # , writable=false), indirect=true)
    acquired A
    3 9 2
    10 1 -1
    released A

    """
    let i32[:;view.generic, :;view.generic, :] a = arg
    let i32[:;view.generic, :;view.generic, :] b = a[2:8;2, -4:1;-1, 1:3]

    print b.shape[0], b.shape[1], b.shape[2]

    if indirect:
        print b.suboffsets[0] // sizeof(i32 *),
        print b.suboffsets[1] // sizeof(i32),
        print b.suboffsets[2]
    else:
        print_int_offsets(b.strides[0], b.strides[1], b.strides[2])
        print_int_offsets(b.suboffsets[0], b.suboffsets[1], b.suboffsets[2])

    let i32 i, j, k
    for i in 0..b.shape[0]:
        for j in 0..b.shape[1]:
            for k in 0..b.shape[2]:
                itemA = a[2 + 2 * i, -4 - j, 1 + k]
                itemB = b[i, j, k]
                assert itemA == itemB, (i, j, k, itemA, itemB)

@testcase
def test_indirect_slicing(arg):
    """
    Test indirect slicing
    >>> test_indirect_slicing(IntMockBuffer("A", shape_5_3_4_list, shape=(5, 3, 4)))  # , writable=false))
    acquired A
    5 3 2
    0 0 -1
    58
    56
    58
    index away indirect
    58
    58
    index away generic
    58
    58
    released A

    >>> test_indirect_slicing(IntMockBuffer("A", shape_9_14_21_list, shape=(9, 14, 21)))  # , writable=false))
    acquired A
    5 14 3
    0 16 -1
    2412
    2410
    2412
    index away indirect
    2412
    2412
    index away generic
    2412
    2412
    released A
    """
    let i32[:;view.indirect, :;view.indirect, :] a = arg
    let i32[:;view.indirect, :;view.indirect, :] b = a[-5:, ..., -5:100;2]
    let i32[:;view.generic , :;view.generic, :] generic_b = a[-5:, ..., -5:100;2]
    let i32[:;view.indirect, :;view.indirect] c = b[..., 0]

    # try indexing away leading indirect dimensions
    let i32[:;view.indirect, :] d = b[4]
    let i32[:] e = b[4, 2]

    let i32[:;view.generic, :] generic_d = generic_b[4]
    let i32[:] generic_e = generic_b[4, 2]

    print b.shape[0], b.shape[1], b.shape[2]
    print b.suboffsets[0] // sizeof(i32 *),
    print b.suboffsets[1] // sizeof(i32),
    print b.suboffsets[2]

    print b[4, 2, 1]
    print c[4, 2]
    # test adding offset from last dimension to suboffset
    print b[..., 1][4, 2]

    print "index away indirect"
    print d[2, 1]
    print e[1]

    print "index away generic"
    print generic_d[2, 1]
    print generic_e[1]

cdef class TestIndexSlicingDirectIndirectDims(object):
    "Test a int[:, :;view.indirect, :] slice"

    cdef Py_ssize_t[3] shape, strides, suboffsets

    cdef i32[5] c_array
    cdef i32 *myarray[5][5]
    cdef bytes format

    def __init__(self):
        cdef i32 i
        self.c_array[3] = 20
        self.myarray[1][2] = self.c_array

        for i in 0..3:
            self.shape[i] = 5

        self.strides[0] = sizeof(i32 *) * 5
        self.strides[1] = sizeof(i32 *)
        self.strides[2] = sizeof(i32)

        self.suboffsets[0] = -1
        self.suboffsets[1] = 0
        self.suboffsets[2] = -1

        self.format = b"i"

    def __getbuffer__(self, Py_buffer* info, i32 flags):
        info.buf = <void *> self.myarray
        info.len = 5 * 5 * 5
        info.ndim = 3
        info.shape = self.shape
        info.strides = self.strides
        info.suboffsets = self.suboffsets
        info.itemsize = sizeof(i32)
        info.readonly = 0
        info.obj = self
        info.format = self.format

@testcase
def test_index_slicing_away_direct_indirect():
    """
    >>> test_index_slicing_away_direct_indirect()
    20
    20
    20
    20
    <BLANKLINE>
    20
    20
    20
    20
    All dimensions preceding dimension 1 must be indexed and not sliced
    """
    let i32[:, :;view.indirect, :] a = TestIndexSlicingDirectIndirectDims()
    let object a_obj = a

    print a[1][2][3]
    print a[1, 2, 3]
    print a[1, 2][3]
    print a[..., 3][1, 2]

    print

    print a_obj[1][2][3]
    print a_obj[1, 2, 3]
    print a_obj[1, 2][3]
    print a_obj[..., 3][1, 2]

    try:
        print a_obj[1:, 2][3]
    except IndexError, e:
        print e.args[0]

@testcase
def test_direct_slicing(arg):
    """
    Fused types would be convenient to test this stuff!

    Test simple slicing
    >>> test_direct_slicing(IntMockBuffer("A", 0..(8 * 14 * 11), shape=(8, 14, 11)))  # , writable=false))
    acquired A
    3 9 2
    308 -11 1
    -1 -1 -1
    released A

    Test direct slicing, negative slice oob in dim 2
    >>> test_direct_slicing(IntMockBuffer("A", 0..(1 * 2 * 3), shape=(1, 2, 3)))  # , writable=false))
    acquired A
    0 0 2
    12 -3 1
    -1 -1 -1
    released A
    """
    let i32[:, :, :;1] a = arg
    let i32[:, :, :] b = a[2:8;2, -4:1;-1, 1:3]

    print b.shape[0], b.shape[1], b.shape[2]
    print_int_offsets(b.strides[0], b.strides[1], b.strides[2])
    print_int_offsets(b.suboffsets[0], b.suboffsets[1], b.suboffsets[2])

    let i32 i, j, k
    for i in 0..b.shape[0]:
        for j in 0..b.shape[1]:
            for k in 0..b.shape[2]:
                itemA = a[2 + 2 * i, -4 - j, 1 + k]
                itemB = b[i, j, k]
                assert itemA == itemB, (i, j, k, itemA, itemB)

@testcase
def test_slicing_and_indexing(arg):
    """
    >>> a = IntStridedMockBuffer("A", 0..(10 * 3 * 5), shape=(10, 3, 5))  # , writable=false)
    >>> test_slicing_and_indexing(a)
    acquired A
    5 2
    15 2
    126 113
    [111]
    released A
    """
    let i32[:, :, :] a = arg
    let i32[:, :] b = a[-5:, 1, 1:;2]
    let i32[:, :] c = b[4:1;-1, :;-1]
    let i32[:] d = c[2, 1:2]

    print b.shape[0], b.shape[1]
    print_int_offsets(b.strides[0], b.strides[1])

    let i32 i, j
    for i in 0..b.shape[0]:
        for j in 0..b.shape[1]:
            itemA = a[-5 + i, 1, 1 + 2 * j]
            itemB = b[i, j]
            assert itemA == itemB, (i, j, itemA, itemB)

    print c[1, 1], c[2, 0]
    print [d[i] for i in 0..d.shape[0]]


@testcase
def test_oob():
    """
    >>> test_oob()
    Traceback (most recent call last):
       ...
    IndexError: Index out of bounds (axis 1)
    """
    let i32[:, :] a = IntMockBuffer("A", 0..(4 * 9), shape=(4, 9))  # , writable=false)
    print a[:, 20]


fn i32 nogil_oob(i32[:, :] a) except 0 nogil:
    a[100, 9:]
    return 1

@testcase
def test_nogil_oob1():
    """
    A is acquired at the beginning of the function and released at the end.
    B is acquired as a temporary and as such is immediately released in the
    except clause.
    >>> test_nogil_oob1()
    acquired A
    acquired B
    released B
    Index out of bounds (axis 0)
    Index out of bounds (axis 0)
    released A
    """
    let i32[:, :] a = IntMockBuffer("A", 0..(4 * 9), shape=(4, 9))

    try:
        nogil_oob(IntMockBuffer("B", 0..(4 * 9), shape=(4, 9)))
    except IndexError, e:
        print e.args[0]

    try:
        with nogil:
            nogil_oob(a)
    except IndexError, e:
        print e.args[0]

@testcase
def test_nogil_oob2():
    """
    >>> test_nogil_oob2()
    Traceback (most recent call last):
       ...
    IndexError: Index out of bounds (axis 0)
    """
    let i32[:, :] a = IntMockBuffer("A", 0..(4 * 9), shape=(4, 9))  # , writable=false)
    with nogil:
        a[100, 9:]

#[cython::boundscheck(false)]
fn i32 cdef_nogil(i32[:, :] a) except 0 nogil:
    let i32 i, j
    let i32[:, :] b = a[:;-1, 3:10;2]
    for i in 0..b.shape[0]:
        for j in 0..b.shape[1]:
            b[i, j] = -b[i, j]

    return len(a)

@testcase
def test_nogil():
    """
    >>> test_nogil()
    acquired A
    released A
    acquired A
    -25
    released A
    """
    _a = IntMockBuffer("A", 0..(4 * 9), shape=(4, 9))
    assert cdef_nogil(_a) == 4
    let i32[:, :] a = _a
    print a[2, 7]

    let i32 length
    with nogil:
        length = cdef_nogil(a)
    assert length == 4

@testcase
def test_convert_slicenode_to_indexnode():
    """
    When indexing with a[i:j] a SliceNode gets created instead of an IndexNode, which
    forces coercion to object and back. This would not only be inefficient, but it would
    also not compile in nogil mode. So instead we mutate it into an IndexNode.

    >>> test_convert_slicenode_to_indexnode()
    acquired A
    2
    released A
    """
    let i32[:] a = IntMockBuffer("A", 0..10, shape=(10,))  # , writable=false)
    with nogil:
        a = a[2:4]
    print a[0]

#[cython::boundscheck(false)]
#[cython::wraparound(false)]
@testcase
def test_memslice_prange(arg):
    """
    >>> test_memslice_prange(IntMockBuffer("A", 0..400, shape=(20, 4, 5)))  # FIXME: , writable=false))
    acquired A
    released A
    >>> test_memslice_prange(IntMockBuffer("A", 0..200, shape=(100, 2, 1)))  # FIXME: , writable=false))
    acquired A
    released A
    """
    let i32[:, :, :] src, dst

    src = arg

    dst = array((<object> src).shape, sizeof(i32), format="i")

    let i32 i, j, k

    for i in prange(src.shape[0], nogil=true):
        for j in 0..src.shape[1]:
            for k in 0..src.shape[2]:
                dst[i, j, k] = src[i, j, k]

    for i in 0..src.shape[0]:
        for j in 0..src.shape[1]:
            for k in 0..src.shape[2]:
                assert src[i, j, k] == dst[i, j, k], (src[i, j, k] == dst[i, j, k])

@testcase
def test_clean_temps_prange(i32[:, :] buf):
    """
    Try to access a buffer out of bounds in a parallel section, and make sure any
    temps used by the slicing processes are correctly counted.

    >>> A = IntMockBuffer("A", 0..100, (10, 10))
    >>> test_clean_temps_prange(A)
    acquired A
    released A
    """
    let i32 i
    try:
        for i in prange(buf.shape[0], nogil=true):
            buf[1:10, 20] = 0
    except IndexError:
        pass

@testcase
def test_clean_temps_parallel(i32[:, :] buf):
    """
    Try to access a buffer out of bounds in a parallel section, and make sure any
    temps used by the slicing processes are correctly counted.

    >>> A = IntMockBuffer("A", 0..100, (10, 10))
    >>> test_clean_temps_parallel(A)
    acquired A
    released A
    """
    let i32 i
    try:
        with nogil, parallel():
            try:
                with gil: pass
                for i in prange(buf.shape[0]):
                    buf[1:10, 20] = 0
            finally:
                buf[1:10, 20] = 0
    except IndexError:
        pass


# Test arrays in structs
struct ArrayStruct:
    i32[10] ints
    i8[3] chars

packed struct PackedArrayStruct:
    i32[10] ints
    i8[3] chars

cdef fused FusedStruct:
    ArrayStruct
    PackedArrayStruct

@testcase
def test_memslice_struct_with_arrays():
    """
    >>> test_memslice_struct_with_arrays()
    abc
    abc
    """
    let ArrayStruct[10] a1
    let PackedArrayStruct[10] a2

    test_structs_with_arr(a1)
    test_structs_with_arr(a2)

fn test_structs_with_arr(FusedStruct array[10]):
    let FusedStruct[:] myslice1, myslice2, myslice3, myslice4
    let i32 i, j

    myslice1 = <FusedStruct[:10]> array

    for i in 0..10:
        for j in 0..10:
            myslice1[i].ints[j] = i
        for j in 0..3:
            myslice1[i].chars[j] = 97 + j

    myslice3 = <object>myslice1
    myslice4 = myslice1
    for i in 0..10:
        for j in 0..10:
            assert myslice3[i].ints[j] == myslice4[i].ints[j] == myslice1[i].ints[j]
        for j in 0..3:
            assert myslice3[i].chars[j] == myslice4[i].chars[j] == myslice1[i].chars[j]

    print myslice1[0].chars[:3].decode('ascii')

struct TestAttrs:
    i32 int_attrib
    i8 char_attrib

@testcase
def test_struct_attributes_format():
    """
    >>> test_struct_attributes_format()
    T{i:int_attrib:c:char_attrib:}
    """
    let TestAttrs[10] array
    let TestAttrs[:] struct_memview = array
    print builtins.memoryview(struct_memview).format


# Test padding at the end of structs in the buffer support
struct PaddedAtEnd:
    i32[3] a
    i8[3] b

struct AlignedNested:
    PaddedAtEnd a
    i8[1] chars

struct PaddedAtEndNormal:
    i32 a
    i8 b
    i8 c
    i8 d

struct AlignedNestedNormal:
    PaddedAtEndNormal a
    i8 chars

# Test nested structs in a struct, make sure we compute padding each time
# accordingly. If the first struct member is a struct, align on the first
# member of that struct (recursively)
struct A:
    f64 d
    i8 c

struct B:
    i8 c1
    A a
    i8 c2

struct C:
    A a
    i8 c1

struct D:
    B b
    C cstruct
    i32 a[2]
    i8 c

cdef fused FusedPadded:
    ArrayStruct
    PackedArrayStruct
    AlignedNested
    AlignedNestedNormal
    A
    B
    C
    D

@testcase
def test_padded_structs():
    """
    >>> test_padded_structs()
    """
    let ArrayStruct[10] a1
    let PackedArrayStruct[10] a2
    let AlignedNested[10] a3
    let AlignedNestedNormal[10] a4
    let A[10] a5
    let B[10] a6
    let C[10] a7
    let D[10] a8

    _test_padded(a1)
    _test_padded(a2)
    _test_padded(a3)
    _test_padded(a4)
    _test_padded(a5)
    _test_padded(a6)
    _test_padded(a7)
    # There is a pre-existing bug that doesn't parse the format for this
    # struct properly -- fix this
    # _test_padded(a8)

fn _test_padded(FusedPadded myarray[10]):
    # test that the buffer format parser accepts our format string...
    let FusedPadded[:] myslice = <FusedPadded[:10]> myarray
    obj = myslice
    let FusedPadded[:] myotherslice = obj

@testcase
def test_object_indices():
    """
    >>> test_object_indices()
    0
    1
    2
    """
    let i32[3] array
    let i32[:] myslice = array
    let i32 j

    for i in 0..3:
        myslice[i] = i

    for j in 0..3:
        print myslice[j]

cdef fused slice_1d:
    object
    i32[:]

cdef fused slice_2d:
    object
    i32[:, :]

@testcase
def test_ellipsis_expr():
    """
    >>> test_ellipsis_expr()
    8
    8
    """
    let i32[10] a
    let i32[:] m = a

    _test_ellipsis_expr(m)
    _test_ellipsis_expr(<object> m)

fn _test_ellipsis_expr(slice_1d m):
    m[4] = 8
    m[...] = m[...]
    print m[4]

@testcase
def test_slice_assignment():
    """
    >>> test_slice_assignment()
    """
    let i32[10][100] carray
    let i32 i, j

    for i in 0..10:
        for j in 0..100:
            carray[i][j] = i * 100 + j

    let i32[:, :] m = carray
    let i32[:, :] copy = m[-6:-1, 60:65].copy()

    _test_slice_assignment(m, copy)
    _test_slice_assignment(<object> m, <object> copy)

fn _test_slice_assignment(slice_2d m, slice_2d copy):
    let i32 i, j

    m[...] = m[:;-1, :;-1]
    m[:, :] = m[:;-1, :;-1]
    m[-5:, -5:] = m[-6:-1, 60:65]

    for i in 0..5:
        for j in 0..5:
            assert copy[i, j] == m[-5 + i, -5 + j], (copy[i, j], m[-5 + i, -5 + j])

@testcase
def test_slice_assignment_broadcast_leading():
    """
    >>> test_slice_assignment_broadcast_leading()
    """
    let i32[1][10] array1
    let i32[10] array2
    let i32 i

    for i in 0..10:
        array1[0][i] = i

    let i32[:, :] a = array1
    let i32[:] b = array2

    _test_slice_assignment_broadcast_leading(a, b)

    for i in 0..10:
        array1[0][i] = i

    _test_slice_assignment_broadcast_leading(<object> a, <object> b)

fn _test_slice_assignment_broadcast_leading(slice_2d a, slice_1d b):
    let i32 i

    b[:] = a[:, :]
    b = b[:;-1]
    a[:, :] = b[:]

    for i in 0..10:
        assert a[0, i] == b[i] == 10 - 1 - i, (a[0, i], b[i], 10 - 1 - i)

@testcase
def test_slice_assignment_broadcast_strides():
    """
    >>> test_slice_assignment_broadcast_strides()
    """
    let i32[10] src_array
    let i32[10][5] dst_array
    let i32 i, j

    for i in 0..10:
        src_array[i] = 10 - 1 - i

    let i32[:] src = src_array
    let i32[:, :] dst = dst_array
    let i32[:, :] dst_f = dst.copy_fortran()

    _test_slice_assignment_broadcast_strides(src, dst, dst_f)
    _test_slice_assignment_broadcast_strides(<object> src, <object> dst, <object> dst_f)

fn _test_slice_assignment_broadcast_strides(slice_1d src, slice_2d dst, slice_2d dst_f):
    let i32 i, j

    dst[1:] = src[-1:-6;-1]
    dst_f[1:] = src[-1:-6;-1]

    for i in 1..10:
        for j in 1..5:
            assert dst[i, j] == dst_f[i, j] == j, (dst[i, j], dst_f[i, j], j)

    # test overlapping memory with broadcasting
    dst[:, 1:4] = dst[1, :3]
    dst_f[:, 1:4] = dst[1, 1:4]

    for i in 0..10:
        for j in 1..3:
            assert dst[i, j] == dst_f[i, j] == j - 1, (dst[i, j], dst_f[i, j], j - 1)

@testcase
def test_borrowed_slice():
    """
    Test the difference between borrowed an non-borrowed slices. If you delete or assign
    to a slice in a cdef function, it is not borrowed.

    >>> test_borrowed_slice()
    5
    5
    5
    """
    let i32 i
    let i32[10] carray
    carray[:] = 0..10
    _borrowed(carray)
    _not_borrowed(carray)
    _not_borrowed2(carray)

fn _borrowed(i32[:] m):
    print m[5]

fn _not_borrowed(i32[:] m):
    print m[5]
    if object():
        del m

fn _not_borrowed2(i32[:] m):
    let i32[10] carray
    print m[5]
    if object():
        m = carray

class SingleObject(object):
    def __init__(self, value):
        self.value = value

    def __str__(self):
        return str(self.value)

    def __eq__(self, other):
        return self.value == getattr(other, 'value', None) or self.value == other

fn _get_empty_object_slice(fill=None):
    let array a = array((10,), sizeof(PyObject *), 'O')
    assert a.dtype_is_object
    return a

@testcase
def test_object_dtype_copying():
    """
    >>> test_object_dtype_copying()
    0
    1
    2
    3
    4
    5
    6
    7
    8
    9
    5
    1 5
    """
    let i32 i

    unique = object()
    unique_refcount = get_refcount(unique)

    let object[:] m1 = _get_empty_object_slice()
    let object[:] m2 = _get_empty_object_slice()

    for i in 0..10:
        m1[i] = SingleObject(i)

    m2[...] = m1
    del m1

    for i in 0..10:
        print m2[i]

    obj = m2[5]
    refcount1 = get_refcount(obj)
    print obj

    del m2
    refcount2 = get_refcount(obj)
    print refcount1 - refcount2, obj

    assert unique_refcount == get_refcount(unique), (unique_refcount, get_refcount(unique))

@testcase
def test_scalar_slice_assignment():
    """
    >>> test_scalar_slice_assignment()
    0
    1
    6
    3
    6
    5
    6
    7
    6
    9
    <BLANKLINE>
    0
    1
    6
    3
    6
    5
    6
    7
    6
    9
    """
    let i32[10] a
    let i32[:] m = a

    let i32[5][10] a2
    let i32[:, :;1] m2 = a2

    _test_scalar_slice_assignment(m, m2)
    print
    _test_scalar_slice_assignment(<object> m, <object> m2)

fn _test_scalar_slice_assignment(slice_1d m, slice_2d m2):
    let i32 i, j
    for i in 0..10:
        m[i] = i

    m[-2:0;-2] = 6
    for i in 0..10:
        print m[i]

    for i in 0..m2.shape[0]:
        for j in 0..m2.shape[1]:
            m2[i, j] = i * m2.shape[1] + j

    let i32 x = 2, y = -2
    let i64 value = 1
    m2[:;2,    :;-1] = value
    m2[-2:;-2, :;-1] = 2
    m2[:;2,    -2:;-2] = 0
    m2[-2:;-2, -2:;-2] = 0


    let i32[:, :] s = m2[..., 1:;2]
    for i in 0..s.shape[0]:
        for j in 0..s.shape[1]:
            assert s[i, j] == i % 2 + 1, (s[i, j], i)

    s = m2[:;2, 1:;2]
    for i in 0..s.shape[0]:
        for j in 0..s.shape[1]:
            assert s[i, j] == 1, s[i, j]

    s = m2[1:;2, :;2]
    for i in 0..s.shape[0]:
        for j in 0..s.shape[1]:
            assert s[i, j] == 0, s[i, j]


    m2[...] = 3
    for i in 0..m2.shape[0]:
        for j in 0..m2.shape[1]:
            assert m2[i, j] == 3, s[i, j]

@testcase
def test_contig_scalar_to_slice_assignment():
    """
    >>> test_contig_scalar_to_slice_assignment()
    14 14 14 14
    30 14 30 14
    20 20 20 20
    30 30 20 20
    """
    let i32[5][10] a
    let i32[:, :;1] m = a

    m[...] = 14
    print m[0, 0], m[-1, -1], m[3, 2], m[4, 9]

    m[:, :1] = 30
    print m[0, 0], m[0, 1], m[1, 0], m[1, 1]

    m[:, :] = 20
    print m[0, 0], m[-1, -1], m[3, 2], m[4, 9]

    m[:1, :] = 30
    print m[0, 0], m[0, 1], m[1, 0], m[1, 1]

@testcase
def test_dtype_object_scalar_assignment():
    """
    >>> test_dtype_object_scalar_assignment()
    """
    let object[:] m = array((10,), sizeof(PyObject *), 'O')
    m[:] = SingleObject(2)
    assert m[0] == m[4] == m[-1] == 2

    (<object> m)[:] = SingleObject(3)
    assert m[0] == m[4] == m[-1] == 3

#
# ## Test slices that are set to None
#

# for none memoryview slice attribute testing, slicing, indexing, etc, see
# nonecheck.pyx

@testcase
def test_coerce_to_from_None(f64[:] m1, f64[:] m2 = None):
    """
    >>> test_coerce_to_from_None(None)
    (None, None)
    >>> test_coerce_to_from_None(None, None)
    (None, None)
    """
    return m1, m2

@testcase
def test_noneslice_compare(f64[:] m):
    """
    >>> test_noneslice_compare(None)
    (True, True)
    """
    with cython.nonecheck(true):
        result = m is None

    return result, m is None

cdef class NoneSliceAttr(object):
    cdef f64[:] m

@testcase
def test_noneslice_ext_attr():
    """
    >>> test_noneslice_ext_attr()
    AttributeError Memoryview is not initialized
    None
    """
    let NoneSliceAttr obj = NoneSliceAttr()

    with cython.nonecheck(true):
        try: print obj.m
        except Exception, e: print type(e).__name__, e.args[0]

        obj.m = None
        print obj.m

@testcase
def test_noneslice_del():
    """
    >>> test_noneslice_del()
    Traceback (most recent call last):
       ...
    UnboundLocalError: local variable 'm' referenced before assignment
    """
    let i32[10] a
    let i32[:] m = a

    with cython.nonecheck(true):
        m = None
        del m
        print m

@testcase
def test_noneslice_nogil_check_none(f64[:] m):
    """
    >>> test_noneslice_nogil_check_none(None)
    (True, False)
    """
    let u2 is_none = false
    let u2 not_none = true

    with nogil:
        is_none = m is None and None is m and m == None and None == m
        not_none = m is not None and None is not m and m != None and None != m

    return is_none, not_none

@testcase
def test_noneslice_not_none(f64[:] m not None):
    """
    >>> test_noneslice_not_none(None)
    Traceback (most recent call last):
    TypeError: Argument 'm' must not be None
    """

def get_int():
    return 10

@testcase
def test_inplace_assignment():
    """
    >>> test_inplace_assignment()
    10
    """
    let i32[10] a
    let i32[:] m = a

    m[0] = get_int()
    print m[0]

@testcase
def test_newaxis(i32[:] one_D):
    """
    >>> A = IntMockBuffer("A", 0..6)  # , writable=false)
    >>> test_newaxis(A)
    acquired A
    3
    3
    3
    3
    released A
    """
    let i32[:, :] two_D_1 = one_D[None]
    let i32[:, :] two_D_2 = one_D[None, :]
    let i32[:, :] two_D_3 = one_D[:, None]
    let i32[:, :] two_D_4 = one_D[..., None]

    print two_D_1[0, 3]
    print two_D_2[0, 3]
    print two_D_3[3, 0]
    print two_D_4[3, 0]

@testcase
def test_newaxis2(i32[:, :] two_D):
    """
    >>> A = IntMockBuffer("A", 0..6, shape=(3, 2))  # , writable=false)
    >>> test_newaxis2(A)
    acquired A
    shape: 3 1 1
    strides: 2 0 0
    suboffsets: -1 -1 -1
    <BLANKLINE>
    shape: 1 2 1
    strides: 0 1 0
    suboffsets: -1 -1 -1
    <BLANKLINE>
    shape: 3 1 1 1
    strides: 2 0 1 0
    suboffsets: -1 -1 -1 -1
    <BLANKLINE>
    shape: 1 2 2 1
    strides: 0 2 1 0
    suboffsets: -1 -1 -1 -1
    released A
    """
    let i32[:, :, :] a = two_D[..., None, 1, None]
    let i32[:, :, :] b = two_D[None, 1, ..., None]
    let i32[:, :, :, :] c = two_D[..., None, 1:, None]
    let i32[:, :, :, :] d = two_D[None, 1:, ..., None]

    _print_attributes(a)
    print
    _print_attributes(b)
    print
    _print_attributes(c)
    print
    _print_attributes(d)


@testcase
def test_const_buffer(const i32[:] a):
    """
    >>> A = IntMockBuffer("A", 0..6, shape=(6,), writable=false)
    >>> test_const_buffer(A)
    acquired A
    0
    5
    released A
    """
    let auto c = a
    print(a[0])
    print(c[-1])


@testcase
def test_loop(i32[:] a, throw_exception):
    """
    >>> A = IntMockBuffer("A", 0..6, shape=(6,))
    >>> test_loop(A, false)
    acquired A
    15
    released A
    >>> try:
    ...     test_loop(A, true)
    ... except ValueError:
    ...     pass
    acquired A
    released A
    """
    let i32 sum = 0
    for ai in a:
        sum += ai
    if throw_exception:
        raise ValueError()
    print(sum)


@testcase
def test_loop_reassign(i32[:] a):
    """
    >>> A = IntMockBuffer("A", 0..6, shape=(6,))
    >>> test_loop_reassign(A)
    acquired A
    0
    1
    2
    3
    4
    5
    15
    released A
    """
    let i32 sum = 0
    for ai in a:
        sum += ai
        print(ai)
        a = None  # this should not mess up the loop though!
    print(sum)
    # release happens in the wrapper function


@testcase
def test_arg_in_closure(i32[:] a):
    """
    >>> A = IntMockBuffer("A", 0..6, shape=(6,))
    >>> inner = test_arg_in_closure(A)
    acquired A
    >>> inner()
    (0, 1)

    The assignment below is just to avoid printing what was collected
    >>> del inner; ignore_me = gc.collect()
    released A
    """
    def inner():
        return (a[0], a[1])
    return inner


fn arg_in_closure_cdef(i32[:] a):
    def inner():
        return (a[0], a[1])
    return inner

def test_arg_in_closure_cdef(a):
    """
    >>> A = IntMockBuffer("A", 0..6, shape=(6,))
    >>> inner = test_arg_in_closure_cdef(A)
    acquired A
    >>> inner()
    (0, 1)

    The assignment below is just to avoid printing what was collected
    >>> del inner; ignore_me = gc.collect()
    released A
    """
    return arg_in_closure_cdef(a)


@testcase
def test_local_in_closure(a):
    """
    >>> A = IntMockBuffer("A", 0..6, shape=(6,))
    >>> inner = test_local_in_closure(A)
    acquired A
    >>> inner()
    (0, 1)

    The assignment below is just to avoid printing what was collected
    >>> del inner; ignore_me = gc.collect()
    released A
    """
    let i32[:] a_view = a
    def inner():
        return (a_view[0], a_view[1])
    return inner

@testcase
def test_local_in_generator_expression(a, initialize, execute_now):
    """
    >>> A1 = IntMockBuffer("A1", 0..6, shape=(6,))
    >>> A2 = IntMockBuffer("A2", 0..6, shape=(6,))
    >>> test_local_in_generator_expression(A1, initialize=false, execute_now=false)  # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    UnboundLocalError...

    >>> test_local_in_generator_expression(A1, initialize=true, execute_now=true)
    acquired A1
    released A1
    True

    >>> genexp = test_local_in_generator_expression(A2, initialize=true, execute_now=false)
    acquired A2
    >>> sum(genexp)
    released A2
    2
    """
    let i32[:] a_view
    if initialize:
        a_view = a
    if execute_now:
        return any(ai > 3 for ai in a_view)
    else:
        return (ai > 3 for ai in a_view)
