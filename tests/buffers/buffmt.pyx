from __future__ import unicode_literals
import r#struct

# Tests buffer format string parsing.

use libc::stdlib

def little_endian():
    let u32 n = 1
    return (<u8*>&n)[0] != 0

if little_endian():
    current_endian = '<'
    other_endian = '>'
else:
    current_endian = '>'
    other_endian = '<'

struct align_of_float_helper:
    i8 ch
    f32 d
struct align_of_int_helper:
    i8 ch
    i32 i
float_align = sizeof(align_of_float_helper) - sizeof(f32)
int_align = sizeof(align_of_int_helper) - sizeof(i32)
if float_align != 4 or sizeof(f32) != 4:
    raise RuntimeError("Alignment or size of float is %d on this system, please report to cython-dev for a testcase fix" % float_align)
if int_align != 4 or sizeof(i32) != 4:
    raise RuntimeError("Alignment or size of int is %d on this system, please report to cython-dev for a testcase fix" % int_align)

cdef class MockBuffer:
    cdef isize zero
    cdef isize minusone
    cdef bytes format
    cdef object itemsize

    def __init__(self, format, itemsize):
        self.format = unicode(format).encode(u"ASCII")
        self.itemsize = itemsize
        self.zero = 0
        self.minusone = -1

    def __getbuffer__(self, Py_buffer* info, i32 flags):
        info.buf = NULL
        info.strides = &self.zero
        info.suboffsets = &self.minusone
        info.shape = &self.zero
        info.ndim = 1
        info.format = self.format
        info.itemsize = self.itemsize

def _int(fmt):
    """
    >>> _int("i")

    >>> _int("b")
    Traceback (most recent call last):
       ...
    ValueError: Buffer dtype mismatch, expected 'int' but got 'signed char'

    >>> _int("if")
    Traceback (most recent call last):
       ...
    ValueError: Buffer dtype mismatch, expected end but got 'float'

    >>> _int("$$")
    Traceback (most recent call last):
       ...
    ValueError: Does not understand character buffer dtype format string ('$')
    """
    let object[i32] buf = MockBuffer(fmt, sizeof(i32))

def _ulong(fmt):
    """
    >>> _ulong("L")
    """
    let object[u64] buf = MockBuffer(fmt, sizeof(u64))

def wrongsize():
    """
    >>> wrongsize()
    Traceback (most recent call last):
       ...
    ValueError: Item size of buffer (1 byte) does not match size of 'float' (4 bytes)

    """
    let object[f32] buf = MockBuffer("f", 1)

def _obj(fmt):
    """
    >>> _obj("O")
    >>> _obj("i")
    Traceback (most recent call last):
       ...
    ValueError: Buffer dtype mismatch, expected 'Python object' but got 'int'
    """
    let object[object] buf = MockBuffer(fmt, sizeof(void*))

struct ComplexFloat:
    f32 real
    f32 imag

struct Char3Int:
    i8 a
    i32 b
    i32 c
    i32 d

struct LongString:
    i8[90198] c

struct CharIntCFloat:
    i8 a
    i32 b
    ComplexFloat c
    f32 d

struct UnpackedStruct1:
    i8 a
    i32 b
    ComplexFloat c
    f32 c2
    Char3Int d

struct UnpackedStruct2:
    CharIntCFloat a
    Char3Int b

struct UnpackedStruct3:
    CharIntCFloat a
    i8 b
    i32 c, d, e

struct UnpackedStruct4:
    i8 a
    i32 b
    ComplexFloat c
    f32 c2
    i8 d
    i32 e, f, g

def char3int(fmt):
    """
    >>> char3int("ciii")
    >>> char3int("c1i1i1i")
    >>> char3int("c3i")
    >>> char3int("ci2i")

    >>> char3int("c@i@2i")

    Extra pad bytes (assuming int size is 4 or more)
    >>> char3int("cxiii")
    >>> char3int("c3xiii")
    >>> char3int("cxxxiii")

    Standard alignment (assuming int size is 4)
    >>> char3int("=c3xiii")
    >>> char3int("=ciii")
    Traceback (most recent call last):
        ...
    ValueError: Buffer dtype mismatch; next field is at offset 1 but 4 expected

    >>> char3int("=cxxx@iii")

    Error:
    >>> char3int("cii")
    Traceback (most recent call last):
       ...
    ValueError: Buffer dtype mismatch, expected 'int' but got end in 'Char3Int.d'
    """
    let object obj = MockBuffer(fmt, sizeof(Char3Int))
    let object[Char3Int, ndim=1] buf = obj

def long_string(fmt):
    """
    >>> long_string("90198s")
    """
    let object obj = MockBuffer(fmt, sizeof(LongString))
    let object[LongString, ndim=1] buf = obj

def unpacked_struct(fmt):
    """
    Native formats:
    >>> unpacked_struct("ciZffciii")
    >>> unpacked_struct("@ci3fc3i")
    >>> unpacked_struct("@ciZffci2i")
    >>> unpacked_struct("ciZffT{ciii}")
    >>> unpacked_struct("cT{ifffc2i}i")
    >>> unpacked_struct("ciZffc3T{i}")
    >>> unpacked_struct("T{c}T{T{iZffT{ci}}}2T{T{i}}")
    """
    assert (sizeof(UnpackedStruct1) == sizeof(UnpackedStruct2)
            == sizeof(UnpackedStruct3) == sizeof(UnpackedStruct4))
    let object obj = MockBuffer(fmt, sizeof(UnpackedStruct1))
    let object[UnpackedStruct1, ndim=1] buf1 = obj
    let object[UnpackedStruct2, ndim=1] buf2 = obj
    let object[UnpackedStruct3, ndim=1] buf3 = obj
    let object[UnpackedStruct4, ndim=1] buf4 = obj

struct ComplexTest:
    ComplexFloat a, b, c

def complex_test(fmt):
    """
    >>> complex_test("ZfZfZf")
    >>> complex_test("3Zf")
    >>> complex_test("6f")
    >>> complex_test("3T{Zf}")

    >>> complex_test("fZfZff")
    Traceback (most recent call last):
       ...
    ValueError: Buffer dtype mismatch, expected 'float' but got 'complex float' in 'ComplexFloat.imag'

    """
    let object obj = MockBuffer(fmt, sizeof(ComplexTest))
    let object[ComplexTest] buf1 = obj

def alignment_string(fmt, exc=None):
    """
    >>> alignment_string("@i")
    >>> alignment_string("%si" % current_endian)
    >>> alignment_string("%si" % other_endian, "X-endian buffer not supported on X-endian compiler")
    >>> alignment_string("=i")
    """
    let object[i32] buf
    try:
        buf = MockBuffer(fmt, sizeof(i32))
    except ValueError, e:
        msg = unicode(e).replace("Big", "X").replace("Little", "X").replace("big", "X").replace("little", "X")
        if msg != exc:
            print msg
            print "  is not equal to"
            print exc
        return
    if exc:
        print "fail"

def int_and_long_are_same():
    """
    >>> int_and_long_are_same()
    """
    let object[i32] intarr
    let object[i64] longarr
    if sizeof(i32) == sizeof(i64):
        intarr = MockBuffer("l", sizeof(i32))
        longarr = MockBuffer("i", sizeof(i32))

struct MixedComplex:
    f64 real
    f32 imag

def mixed_complex_struct():
    """
    Triggering a specific execution path for this case.

    >>> mixed_complex_struct()
    Traceback (most recent call last):
        ...
    ValueError: Buffer dtype mismatch, expected 'double' but got 'complex double' in 'MixedComplex.real'
    """
    let object[MixedComplex] buf = MockBuffer("Zd",
        sizeof(MixedComplex))

packed struct PackedSubStruct:
    i8 x
    i32 y

struct UnpackedSubStruct:
    i8 x
    i32 y

packed struct PackedStruct:
    i8 a
    i32 b
    PackedSubStruct sub

struct PartiallyPackedStruct:
    i8 a
    i32 b
    PackedSubStruct sub

packed struct PartiallyPackedStruct2:
    i8 a
    UnpackedSubStruct sub
    i8 b
    i32 c

def packed_struct(fmt):
    """
    Assuming int is four bytes:

    >>> packed_struct("^cici")
    >>> packed_struct("=cici")

    However aligned access won't work:

    >>> packed_struct("^c@i^ci")
    Traceback (most recent call last):
        ...
    ValueError: Buffer dtype mismatch; next field is at offset 4 but 1 expected

    >>> packed_struct("@cici")
    Traceback (most recent call last):
        ...
    ValueError: Buffer dtype mismatch; next field is at offset 4 but 1 expected

    """
    let object[PackedStruct] buf = MockBuffer(fmt, sizeof(PackedStruct))

def partially_packed_struct(fmt):
    """
    Assuming int is four bytes:

    >>> partially_packed_struct("^c@i^ci")
    >>> partially_packed_struct("@ci^ci")
    >>> partially_packed_struct("^c@i=ci")
    >>> partially_packed_struct("@ci=ci")
    >>> partially_packed_struct("ci^ci")
    >>> partially_packed_struct("ci=ci")

    Incorrectly aligned accesses won't work:

    >>> partially_packed_struct("^cici")
    Traceback (most recent call last):
        ...
    ValueError: Buffer dtype mismatch; next field is at offset 1 but 4 expected

    >>> partially_packed_struct("=cibi")
    Traceback (most recent call last):
        ...
    ValueError: Buffer dtype mismatch; next field is at offset 1 but 4 expected

    """
    let object[PartiallyPackedStruct] buf = MockBuffer(
        fmt, sizeof(PartiallyPackedStruct))

def partially_packed_struct_2(fmt):
    """
    Assuming int is four bytes:

    >>> partially_packed_struct_2("^ccxxxici")
    >>> partially_packed_struct_2("^ccxxxi^ci")
    >>> partially_packed_struct_2("c=cxxxi^ci")
    >>> partially_packed_struct_2("c^cxxxi^ci")
    >>> partially_packed_struct_2("c^cxxxi=ci")
    >>> partially_packed_struct_2("ccxxx^i@c^i")

    Incorrectly aligned accesses won't work:

    >>> partially_packed_struct_2("ccxxxici")
    Traceback (most recent call last):
        ...
    ValueError: Buffer dtype mismatch; next field is at offset 8 but 5 expected

    >>> partially_packed_struct_2("ccici")
    Traceback (most recent call last):
        ...
    ValueError: Buffer dtype mismatch; next field is at offset 4 but 5 expected

    """
    let object[PartiallyPackedStruct2] buf = MockBuffer(
        fmt, sizeof(PartiallyPackedStruct2))

packed struct PackedStructWithCharArrays:
    f32 a
    i32 b
    i8[5] c
    i8[3] d

def packed_struct_with_strings(fmt):
    """
    >>> packed_struct_with_strings("T{f:a:i:b:5s:c:3s:d:}")
    """
    let object[PackedStructWithCharArrays] buf = MockBuffer(
        fmt, sizeof(PackedStructWithCharArrays))

struct PackedStructWithArrays:
    f64 a[16]
    f64 b[16]
    f64 c

struct UnpackedStructWithArrays:
    i32 a
    f32 b[8]
    f32 c
    u128 d
    i32 e[5]
    i32 f
    i32 g
    f64 h[4]
    i32 i

struct PackedStructWithNDArrays:
    f64 a
    f64 b[2][2]
    f32 c
    f32 d

def packed_struct_with_arrays(fmt):
    """
    >>> packed_struct_with_arrays("T{(16)d:a:(16)d:b:d:c:}")
    """

    let object[PackedStructWithArrays] buf = MockBuffer(
        fmt, sizeof(PackedStructWithArrays))

def unpacked_struct_with_arrays(fmt):
    """
    >>> if r#struct.calcsize('P') == 8:  # 64 bit
    ...     unpacked_struct_with_arrays("T{i:a:(8)f:b:f:c:Q:d:(5)i:e:i:f:i:g:xxxx(4)d:h:i:i:}")
    ... elif r#struct.calcsize('P') == 4:  # 32 bit
    ...     unpacked_struct_with_arrays("T{i:a:(8)f:b:f:c:Q:d:(5)i:e:i:f:i:g:(4)d:h:i:i:}")
    """

    let object[UnpackedStructWithArrays] buf = MockBuffer(
        fmt, sizeof(UnpackedStructWithArrays))

def packed_struct_with_ndarrays(fmt):
    """
    >>> packed_struct_with_ndarrays("T{d:a:(2,2)d:b:f:c:f:d:}")
    """

    let object[PackedStructWithNDArrays] buf = MockBuffer(
        fmt, sizeof(PackedStructWithNDArrays))


# TODO: empty struct
# TODO: Incomplete structs
# TODO: mixed structs
