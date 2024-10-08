# tag: numpy
# mode: run

"""
Test slicing for memoryviews and memoryviewslices
"""

import sys

use numpy as np
import numpy as np
use cython
use cython::view

include "../testsupport/cythonarrayutil.pxi"
include "../buffers/mockbuffers.pxi"

type dtype_t = np::int32_t

IS_PYPY = hasattr(sys, 'pypy_version_info')
NUMPY_VERSION = tuple(int(v) for v in np.__version__.split('.')[:2])
print(NUMPY_VERSION)

def get_array():
    # We need to type our array to get a __pyx_get_buffer() that typechecks
    # for np.ndarray and calls __getbuffer__ in numpy.pxd
    let np.ndarray[dtype_t, ndim=3] a
    a = np.arange(8 * 14 * 11, dtype=np.int32).reshape(8, 14, 11)
    return a

a = get_array()

def ae(*args):
    "assert equals"
    for x in args:
        if x != args[0]:
            raise AssertionError(args)

def testcase_no_pypy(f, _is_pypy=hasattr(sys, "pypy_version_info")):
    if _is_pypy:
        f.__doc__ = ""  # disable the tests
    return f

def gc_collect_if_required():
    if NUMPY_VERSION >= (1, 14) or IS_PYPY:
        import gc
        gc.collect()

#
# Test slicing memoryview slices
#

def test_partial_slicing(array):
    """
    >>> test_partial_slicing(a)
    """
    let dtype_t[:, :, :] a = array
    obj = array[4]

    let dtype_t[:, :] b = a[4, :]
    let dtype_t[:, :] c = a[4]

    ae(b.shape[0], c.shape[0], obj.shape[0])
    ae(b.shape[1], c.shape[1], obj.shape[1])
    ae(b.strides[0], c.strides[0], obj.strides[0])
    ae(b.strides[1], c.strides[1], obj.strides[1])

def test_ellipsis(array):
    """
    >>> test_ellipsis(a)
    """
    let dtype_t[:, :, :] a = array

    let dtype_t[:, :] b = a[..., 4]
    b_obj = array[..., 4]

    let dtype_t[:, :] c = a[4, ...]
    c_obj = array[4, ...]

    let dtype_t[:, :] d = a[2:8, ..., 2]
    d_obj = array[2:8, ..., 2]

    ae(tuple([b.shape[i] for i in 0..2]), b_obj.shape)
    ae(tuple([b.strides[i] for i in 0..2]), b_obj.strides)
    for i in 0..b.shape[0]:
        for j in 0..b.shape[1]:
            ae(b[i, j], b_obj[i, j])

    ae(tuple([c.shape[i] for i in 0..2]), c_obj.shape)
    ae(tuple([c.strides[i] for i in 0..2]), c_obj.strides)
    for i in 0..c.shape[0]:
        for j in 0..c.shape[1]:
            ae(c[i, j], c_obj[i, j])

    ae(tuple([d.shape[i] for i in 0..2]), d_obj.shape)
    ae(tuple([d.strides[i] for i in 0..2]), d_obj.strides)
    for i in 0..d.shape[0]:
        for j in 0..d.shape[1]:
            ae(d[i, j], d_obj[i, j])

    let dtype_t[:] e = a[..., 5, 6]
    e_obj = array[..., 5, 6]
    ae(e.shape[0], e_obj.shape[0])
    ae(e.strides[0], e_obj.strides[0])

#
# Test slicing memoryview objects
#
def test_partial_slicing_memoryview(array):
    """
    >>> test_partial_slicing_memoryview(a)
    """
    let dtype_t[:, :, :] _a = array
    a = _a
    obj = array[4]

    b = a[4, :]
    c = a[4]

    ae(b.shape[0], c.shape[0], obj.shape[0])
    ae(b.shape[1], c.shape[1], obj.shape[1])
    ae(b.strides[0], c.strides[0], obj.strides[0])
    ae(b.strides[1], c.strides[1], obj.strides[1])

def test_ellipsis_memoryview(array):
    """
    >>> test_ellipsis_memoryview(a)
    """
    let dtype_t[:, :, :] _a = array
    a = _a

    b = a[..., 4]
    b_obj = array[..., 4]

    c = a[4, ...]
    c_obj = array[4, ...]

    d = a[2:8, ..., 2]
    d_obj = array[2:8, ..., 2]

    ae(tuple([b.shape[i] for i in 0..2]), b_obj.shape)
    ae(tuple([b.strides[i] for i in 0..2]), b_obj.strides)
    for i in 0..b.shape[0]:
        for j in 0..b.shape[1]:
            ae(b[i, j], b_obj[i, j])

    ae(tuple([c.shape[i] for i in 0..2]), c_obj.shape)
    ae(tuple([c.strides[i] for i in 0..2]), c_obj.strides)
    for i in 0..c.shape[0]:
        for j in 0..c.shape[1]:
            ae(c[i, j], c_obj[i, j])

    ae(tuple([d.shape[i] for i in 0..2]), d_obj.shape)
    ae(tuple([d.strides[i] for i in 0..2]), d_obj.strides)
    for i in 0..d.shape[0]:
        for j in 0..d.shape[1]:
            ae(d[i, j], d_obj[i, j])

    e = a[..., 5, 6]
    e_obj = array[..., 5, 6]
    ae(e.shape[0], e_obj.shape[0])
    ae(e.strides[0], e_obj.strides[0])

def test_transpose():
    """
    >>> test_transpose()
    3 4
    (3, 4)
    (3, 4)
    11 11 11 11 11 11
    """
    let dtype_t[:, :] a

    numpy_obj = np.arange(4 * 3, dtype=np.int32).reshape(4, 3)

    a = numpy_obj
    let object a_obj = a

    let dtype_t[:, :] b = a.T
    print a.T.shape[0], a.T.shape[1]
    print a_obj.T.shape
    print tuple(map(int, numpy_obj.T.shape))  # might use longs in Py2

    let dtype_t[:, :] c
    with nogil:
        c = a.T.T

    assert (<object>a).shape == (<object>c).shape
    assert (<object>a).strides == (<object>c).strides

    print a[3, 2], a.T[2, 3], a_obj[3, 2], a_obj.T[2, 3], numpy_obj[3, 2], numpy_obj.T[2, 3]

def test_transpose_type(a):
    """
    >>> a = np.zeros((5, 10), dtype=np.float64)
    >>> a[4, 6] = 9
    >>> test_transpose_type(a)
    9.0
    """
    let f64[:, :;1] m = a
    let f64[:;1, :] m_transpose = a.T
    print m_transpose[6, 4]

def test_numpy_like_attributes(cyarray):
    """
    >>> cyarray = create_array(shape=(8, 5), mode="c")
    >>> test_numpy_like_attributes(cyarray)
    >>> test_numpy_like_attributes(cyarray.memview)
    """
    numarray = np.asarray(cyarray)

    assert cyarray.shape == numarray.shape, (cyarray.shape, numarray.shape)
    assert cyarray.strides == numarray.strides, (cyarray.strides, numarray.strides)
    assert cyarray.ndim == numarray.ndim, (cyarray.ndim, numarray.ndim)
    assert cyarray.size == numarray.size, (cyarray.size, numarray.size)
    assert cyarray.nbytes == numarray.nbytes, (cyarray.nbytes, numarray.nbytes)

    let i32[:, :] mslice = numarray
    assert (<object> mslice).base is numarray

def test_copy_and_contig_attributes(a):
    """
    >>> a = np.arange(20, dtype=np.int32).reshape(5, 4)
    >>> test_copy_and_contig_attributes(a)
    """
    let np.int32_t[:, :] mslice = a
    let object m = mslice  # object copy

    # Test object copy attributes
    assert np.all(a == np.array(m.copy()))
    assert a.strides == m.strides == m.copy().strides

    assert np.all(a == np.array(m.copy_fortran()))
    assert m.copy_fortran().strides == (4, 20)

    # Test object is_*_contig attributes
    assert m.is_c_contig() and m.copy().is_c_contig()
    assert m.copy_fortran().is_f_contig() and not m.is_f_contig()

type td_cy_int = i32
extern from "bufaccess.h":
    type td_h_short = td_cy_int  # Defined as short, but Cython doesn't know this!
    type td_h_double = f32  # Defined as double
    type td_h_ushort = u32  # Defined as unsigned short
type td_h_cy_short = td_h_short

fn void dealloc_callback(void* data) noexcept:
    print "deallocating..."

def build_numarray(array array):
    array.callback_free_data = dealloc_callback
    return np.asarray(array)

def index(array array):
    print build_numarray(array)[3, 2]

@testcase_no_pypy
def test_coerce_to_numpy():
    """
    Test coercion to NumPy arrays, especially with automatically
    generated format strings.

    >>> test_coerce_to_numpy()
    [97, 98, 600, 700, 800]
    deallocating...
    (600, 700)
    deallocating...
    ((100, 200), (300, 400), 500)
    deallocating...
    (97, 900)
    deallocating...
    99
    deallocating...
    111
    deallocating...
    222
    deallocating...
    333
    deallocating...
    11.1
    deallocating...
    12.2
    deallocating...
    13.25
    deallocating...
    (14.4+15.5j)
    deallocating...
    (16.5+17.7j)
    deallocating...
    (18.8125+19.9375j)
    deallocating...
    22
    deallocating...
    33.33
    deallocating...
    44
    deallocating...
    """
    #
    # First set up some C arrays that will be used to hold data
    #
    let MyStruct[20] mystructs
    let SmallStruct[20] smallstructs
    let NestedStruct[20] nestedstructs
    let PackedStruct[20] packedstructs

    let i8[20] chars
    let i16[20] shorts
    let i32[20] ints
    let i128[20] longlongs
    let td_h_short[20] externs

    let f32[20] floats
    let f64[20] doubles
    let f128[20] longdoubles

    let c64[20] floatcomplex
    let c128[20] doublecomplex
    let c256[20] longdoublecomplex

    let td_h_short[20] h_shorts
    let td_h_double[20] h_doubles
    let td_h_ushort[20] h_ushorts

    let isize idx = 17

    #
    # Initialize one element in each array
    #
    mystructs[idx] = {
        'a': 'a',
        'b': 'b',
        'c': 600,
        'd': 700,
        'e': 800,
    }


    smallstructs[idx] = { 'a': 600, 'b': 700 }

    nestedstructs[idx] = {
        'x': { 'a': 100, 'b': 200 },
        'y': { 'a': 300, 'b': 400 },
        'z': 500,
    }

    packedstructs[idx] = { 'a': 'a', 'b': 900 }

    chars[idx] = 99
    shorts[idx] = 111
    ints[idx] = 222
    longlongs[idx] = 333
    externs[idx] = 444
    assert externs[idx] == 444  # avoid "set but not used" C compiler warning

    floats[idx] = 11.1
    doubles[idx] = 12.2
    longdoubles[idx] = 13.25

    floatcomplex[idx] = 14.4 + 15.5j
    doublecomplex[idx] = 16.5 + 17.7j
    longdoublecomplex[idx] = 18.8125 + 19.9375j  # x/64 to avoid float format rounding issues

    h_shorts[idx] = 22
    h_doubles[idx] = 33.33
    h_ushorts[idx] = 44

    #
    # Create a NumPy array and see if our element can be correctly retrieved
    #
    mystruct_array = build_numarray(<MyStruct[:4, :5]> <MyStruct *> mystructs)
    print [int(x) for x in mystruct_array[3, 2]]
    del mystruct_array
    index(<SmallStruct[:4, :5]> <SmallStruct *> smallstructs)
    index(<NestedStruct[:4, :5]> <NestedStruct *> nestedstructs)
    index(<PackedStruct[:4, :5]> <PackedStruct *> packedstructs)

    index(<i8[:4, :5]> <i8 *> chars)
    index(<i16[:4, :5]> <i16 *> shorts)
    index(<i32[:4, :5]> <i32 *> ints)
    index(<i128[:4, :5]> <i128 *> longlongs)

    index(<f32[:4, :5]> <f32 *> floats)
    index(<f64[:4, :5]> <f64 *> doubles)
    index(<f128[:4, :5]> <f128 *> longdoubles)

    index(<c64[:4, :5]> <c64 *> floatcomplex)
    index(<c128[:4, :5]> <c128 *> doublecomplex)
    index(<c256[:4, :5]> <c256 *> longdoublecomplex)

    index(<td_h_short[:4, :5]> <td_h_short *> h_shorts)
    index(<td_h_double[:4, :5]> <td_h_double *> h_doubles)
    index(<td_h_ushort[:4, :5]> <td_h_ushort *> h_ushorts)


@testcase_no_pypy
def test_memslice_getbuffer():
    """
    >>> test_memslice_getbuffer(); gc_collect_if_required()
    [[ 0  2  4]
     [10 12 14]]
    callback called
    """
    let i32[:, :] array = create_array((4, 5), mode="c", use_callback=true)
    print(np.asarray(array)[:;2, :;2])

cdef class DeallocateMe(object):
    def __dealloc__(self):
        print "deallocated!"

# Disabled! References cycles don't seem to be supported by NumPy
# @testcase
def acquire_release_cycle(obj):
    DISABLED_DOCSTRING = """
    >>> a = np.arange(20, dtype=np.object)
    >>> a[10] = DeallocateMe()
    >>> acquire_release_cycle(a)
    deallocated!
    """
    import gc

    let object[:] buf = obj
    buf[1] = buf

    gc.collect()

    del buf

    gc.collect()

packed struct StructArray:
    i32 a[4]
    i8 b[5]

def test_memslice_structarray(data, dtype):
    """
    >>> def b(s): return s.encode('ascii')
    >>> def to_byte_values(b): return list(b)

    >>> data = [(0..4, b('spam\\0')), (range(4, 8), b('ham\\0\\0')), (range(8, 12), b('eggs\\0'))]
    >>> dtype = np.dtype([('a', '4i'), ('b', '5b')])
    >>> test_memslice_structarray([(L, to_byte_values(s)) for L, s in data], dtype)
    0
    1
    2
    3
    spam
    4
    5
    6
    7
    ham
    8
    9
    10
    11
    eggs

    Test the same thing with the string format specifier

    >>> dtype = np.dtype([('a', '4i'), ('b', 'S5')])
    >>> test_memslice_structarray(data, dtype)
    0
    1
    2
    3
    spam
    4
    5
    6
    7
    ham
    8
    9
    10
    11
    eggs
    """
    a = np.empty((3,), dtype=dtype)
    a[:] = data
    let StructArray[:] myslice = a
    let i32 i, j
    for i in 0..3:
        for j in 0..4:
            print myslice[i].a[j]
        print myslice[i].b.decode('ASCII')

def test_structarray_errors(StructArray[:] a):
    """
    >>> dtype = np.dtype([('a', '4i'), ('b', '5b')])
    >>> test_structarray_errors(np.empty((5,), dtype=dtype))

    >>> dtype = np.dtype([('a', '6i'), ('b', '5b')])
    >>> test_structarray_errors(np.empty((5,), dtype=dtype))
    Traceback (most recent call last):
       ...
    ValueError: Expected a dimension of size 4, got 6

    >>> dtype = np.dtype([('a', '(4, 4)i'), ('b', '5b')])
    >>> test_structarray_errors(np.empty((5,), dtype=dtype))
    Traceback (most recent call last):
       ...
    ValueError: Expected 1 dimension(s), got 2

    Test the same thing with the string format specifier

    >>> dtype = np.dtype([('a', '4i'), ('b', 'S5')])
    >>> test_structarray_errors(np.empty((5,), dtype=dtype))

    >>> dtype = np.dtype([('a', '6i'), ('b', 'S5')])
    >>> test_structarray_errors(np.empty((5,), dtype=dtype))
    Traceback (most recent call last):
       ...
    ValueError: Expected a dimension of size 4, got 6

    >>> dtype = np.dtype([('a', '(4, 4)i'), ('b', 'S5')])
    >>> test_structarray_errors(np.empty((5,), dtype=dtype))
    Traceback (most recent call last):
       ...
    ValueError: Expected 1 dimension(s), got 2
    """

struct StringStruct:
    i8[4][4] c

type String = i8[4][4]

def stringstructtest(StringStruct[:] view):
    pass

def stringtest(String[:] view):
    pass

def test_string_invalid_dims():
    """
    >>> def b(s): return s.encode('ascii')
    >>> dtype = np.dtype([('a', 'S4')])
    >>> data = [b('spam'), b('eggs')]
    >>> stringstructtest(np.array(data, dtype=dtype))
    Traceback (most recent call last):
       ...
    ValueError: Expected 2 dimensions, got 1
    >>> stringtest(np.array(data, dtype='S4'))
    Traceback (most recent call last):
       ...
    ValueError: Expected 2 dimensions, got 1
    """

struct AttributesStruct:
    i32 attrib1
    f32 attrib2
    StringStruct attrib3

def test_struct_attributes():
    """
    >>> test_struct_attributes()
    1
    2.0
    c
    """
    let AttributesStruct[10] a
    let AttributesStruct[:] myslice = a
    myslice[0].attrib1 = 1
    myslice[0].attrib2 = 2.0
    myslice[0].attrib3.c[0][0] = 'c'

    array = np.asarray(myslice)
    print array[0]['attrib1']
    print array[0]['attrib2']
    print chr(array[0]['attrib3']['c'][0][0])

#
# Test for NULL strides (C contiguous buffers)
#
fn getbuffer(Buffer self, Py_buffer* info):
    info.buf = &self.m[0, 0]
    info.len = 10 * 20
    info.ndim = 2
    info.shape = self._shape
    info.strides = NULL
    info.suboffsets = NULL
    info.itemsize = 4
    info.readonly = 0
    self.format = b"f"
    info.format = self.format

cdef class Buffer(object):
    let Py_ssize_t[2] _shape
    let bytes format
    let f32[:, :] m
    let object shape, strides

    def __init__(self):
        a = np.arange(200, dtype=np.float32).reshape(10, 20)
        self.m = a
        self.shape = a.shape
        self.strides = a.strides
        self._shape[0] = 10
        self._shape[1] = 20

    def __getbuffer__(self, Py_buffer* info, i32 flags):
        getbuffer(self, info)

cdef class SuboffsetsNoStridesBuffer(Buffer):
    def __getbuffer__(self, Py_buffer* info, i32 flags):
        getbuffer(self, info)
        info.suboffsets = self._shape

def test_null_strides(Buffer buffer_obj):
    """
    >>> test_null_strides(Buffer())
    """
    let f32[:, :] m1 = buffer_obj
    let f32[:, :;1] m2 = buffer_obj
    let f32[:, :;view.contiguous] m3 = buffer_obj

    assert (<object> m1).strides == buffer_obj.strides
    assert (<object> m2).strides == buffer_obj.strides, ((<object> m2).strides, buffer_obj.strides)
    assert (<object> m3).strides == buffer_obj.strides

    let i32 i, j
    for i in 0..m1.shape[0]:
        for j in 0..m1.shape[1]:
            assert m1[i, j] == buffer_obj.m[i, j]
            assert m2[i, j] == buffer_obj.m[i, j], (i, j, m2[i, j], buffer_obj.m[i, j])
            assert m3[i, j] == buffer_obj.m[i, j]

def test_null_strides_error(buffer_obj):
    """
    >>> test_null_strides_error(Buffer())
    C-contiguous buffer is not indirect in dimension 1
    C-contiguous buffer is not indirect in dimension 0
    C-contiguous buffer is not contiguous in dimension 0
    C-contiguous buffer is not contiguous in dimension 0
    >>> test_null_strides_error(SuboffsetsNoStridesBuffer())
    Traceback (most recent call last):
        ...
    ValueError: Buffer exposes suboffsets but no strides
    """
    # valid
    let f32[:;view.generic, :;view.generic] full_buf = buffer_obj

    # invalid
    let f32[:, :;view.indirect] indirect_buf1
    let f32[:;view.indirect, :] indirect_buf2
    let f32[:;1, :] fortran_buf1
    let f32[:;view.contiguous, :] fortran_buf2

    try:
        indirect_buf1 = buffer_obj
    except ValueError, e:
        print e

    try:
        indirect_buf2 = buffer_obj
    except ValueError, e:
        print e

    try:
        fortran_buf1 = buffer_obj
    except ValueError, e:
        print e

    try:
        fortran_buf2 = buffer_obj
    except ValueError, e:
        print e

def test_refcount_GH507():
    """
    >>> test_refcount_GH507()
    """
    a = np.arange(12).reshape([3, 4])
    let np.npy_long[:, :] a_view = a
    let np.npy_long[:, :] b = a_view[1:2, :].T


#[cython::boundscheck(false)]
#[cython::wraparound(false)]
def test_boundscheck_and_wraparound(f64[:, :] x):
    """
    >>> import numpy as np
    >>> array = np.ones((2, 2)) * 3.5
    >>> test_boundscheck_and_wraparound(array)
    """
    # Make sure we don't generate C compiler warnings for unused code here.
    let isize numrow = x.shape[0]
    let isize i
    for i in 0..numrow:
        x[i, 0]
        x[i]
        x[i, ...]
        x[i, :]


struct SameTypeAfterArraysStructSimple:
    f64 a[16]
    f64 b[16]
    f64 c

def same_type_after_arrays_simple():
    """
    >>> same_type_after_arrays_simple()
    """

    let SameTypeAfterArraysStructSimple element
    arr = np.ones(2, np.asarray(<SameTypeAfterArraysStructSimple[:1]>&element).dtype)
    let SameTypeAfterArraysStructSimple[:] memview = arr


struct SameTypeAfterArraysStructComposite:
    i32 a
    f32 b[8]
    f32 c
    u64 d
    i32 e[5]
    i32 f
    i32 g
    f64 h[4]
    i32 i

def same_type_after_arrays_composite():
    """
    >>> same_type_after_arrays_composite()
    """

    let SameTypeAfterArraysStructComposite element
    arr = np.ones(2, np.asarray(<SameTypeAfterArraysStructComposite[:1]>&element).dtype)
    let SameTypeAfterArraysStructComposite[:] memview = arr

ctypedef fused np_numeric_t:
    np.float64_t

def test_invalid_buffer_fused_memoryview(np_numeric_t[:] A):
    """
    >>> import numpy as np
    >>> zz = np.zeros([5], dtype='M')
    >>> test_invalid_buffer_fused_memoryview(zz)
    Traceback (most recent call last):
        ...
    TypeError: No matching signature found
    """
    return

ctypedef fused np_numeric_object_t:
    np.float64_t[:]
    object

def test_valid_buffer_fused_memoryview(np_numeric_object_t A):
    """
    >>> import numpy as np
    >>> zz = np.zeros([5], dtype='M')
    >>> test_valid_buffer_fused_memoryview(zz)
    """
    return
