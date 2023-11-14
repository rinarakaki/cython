# mode: error

use cython
use cython::view

cdef i16[:;1, :;1] both
cdef i16[:;1, :, :, :;1] both2
cdef i8[:;2] err0
cdef i8[:;-100] err1
cdef i8[:;-1] err2
cdef i128[1:;1, 0x01:, '0'   :, false:] fort_contig0
cdef i8[1:;] bad_start
cdef u64[:, :1] bad_stop
cdef u64[:, :;1, :] neither_c_or_f
cdef i8[:;1-1+1] expr_spec
cdef i8[:;blargh] bad_name
cdef f64[:;alist[0]['view'].full] expr_attribute

cdef object[:;1, :] unconformable1 = object()
cdef object[:, :;1] unconformable2 = unconformable1

cdef i32[:;1, :] dtype_unconformable = object()
unconformable1 = dtype_unconformable

# These are INVALID
cdef i32[:;view.contiguous, :;1] a1
# cdef i32[:;view.generic_contiguous, :;1] a2

# cdef i32[:;view.contiguous, :;view.generic_contiguous] a3
# cdef i32[:;view.generic_contiguous, :;view.generic_contiguous] a4

cdef i32[:;view.contiguous, :;view.contiguous] a5
cdef i32[:, :;view.contiguous, :;view.indirect_contiguous] a6

# cdef i32[:;view.generic_contiguous, :;view.contiguous] a7
# cdef i32[:;view.contiguous, :;view.generic_contiguous] a8

ctypedef i32 *intp
cdef intp[:, :] myarray

cdef i32[:] a10 = <i32[:10]> object()
cdef i32[:] a11 = <i32[:5.4]> <i32 *> 1

struct Valid:
    i32 array[1][2][3][4][5][6][7][8]
struct Invalid:
    i32 array[1][2][3][4][5][6][7][8][9]

cdef Valid[:] validslice
cdef Invalid[:] invalidslice

cdef i32[:, :, :, :] four_D
four_D[None, None, None, None]
four_D[None, None, None, None, None]

cdef i32[:, :, :, :, :, :, :, :] eight_D = object()

cdef f64[:] m
print <i64> &m

# These are VALID
cdef i32[:;view.indirect_contiguous, :;view.contiguous] a9
four_D[None, None, None]

_ERRORS = u'''
6:16: Cannot specify an array that is both C and Fortran contiguous.
7:22: Cannot specify an array that is both C and Fortran contiguous.
8:10: Step must be omitted, 1, or a valid specifier.
9:11: Step must be omitted, 1, or a valid specifier.
10:11: Step must be omitted, 1, or a valid specifier.
11:10: Start must not be given.
12:8: Start must not be given.
13:13: Axis specification only allowed in the 'step' slot.
14:8: Fortran contiguous specifier must follow an indirect dimension
15:13: Invalid axis specification.
16:10: Invalid axis specification.
17:19: no expressions allowed in axis spec, only names and literals.
20:37: Memoryview 'object[::1, :]' not conformable to memoryview 'object[:, ::1]'.
23:17: Different base types for memoryviews (int, Python object)
26:8: Dimension may not be contiguous
32:8: Only one direct contiguous axis may be specified.
33:8:Only dimensions 3 and 2 may be contiguous and direct
39:9: Invalid base type for memoryview slice: intp
41:35: Can only create cython.array from pointer or array
42:24: Cannot assign type 'double' to 'Py_ssize_t'
50:12: Invalid base type for memoryview slice: Invalid
53:6: More dimensions than the maximum number of buffer dimensions were used.
54:6: More dimensions than the maximum number of buffer dimensions were used.
56:8: More dimensions than the maximum number of buffer dimensions were used.
59:12: Cannot take address of memoryview slice
'''
