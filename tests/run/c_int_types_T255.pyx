# ticket: t255

__doc__ = u""

# -------------------------------------------------------------------

SCHAR_MAX = <i8>((<u8>-1)>>1)
SCHAR_MIN = (-SCHAR_MAX-1)

def test_schar(i8 x):
   u"""
   >>> test_schar(-129) # doctest: +ELLIPSIS
   Traceback (most recent call last):
       ...
   OverflowError: ...
   >>> test_schar(-128)
   -128
   >>> test_schar(0)
   0
   >>> test_schar(127)
   127
   >>> test_schar(128) # doctest: +ELLIPSIS
   Traceback (most recent call last):
       ...
   OverflowError: value too large to convert to signed char
   """
   return x

def test_add_schar(x, y):
    u"""
    >>> test_add_schar(SCHAR_MIN, -1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: ...
    >>> test_add_schar(SCHAR_MIN, 0) == SCHAR_MIN
    True
    >>> test_add_schar(SCHAR_MIN, 1) == SCHAR_MIN+1
    True
    >>> test_add_schar(SCHAR_MAX, -1) == SCHAR_MAX-1
    True
    >>> test_add_schar(SCHAR_MAX, 0) == SCHAR_MAX
    True
    >>> test_add_schar(SCHAR_MAX, 1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: value too large to convert to signed char
    """
    let i8 r = x + y
    return r

UCHAR_MAX = <u8>((<u8>-1))

def test_uchar(u8 x):
    u"""
    >>> test_uchar(-1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: can't convert negative value to unsigned char
    >>> test_uchar(0)
    0
    >>> test_uchar(1)
    1
    >>> test_uchar(UCHAR_MAX) == UCHAR_MAX
    True
    >>> test_uchar(UCHAR_MAX+1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: value too large to convert to unsigned char
    """
    return x

def test_add_uchar(x, y):
    u"""
    >>> test_add_uchar(UCHAR_MAX, 0) == UCHAR_MAX
    True
    >>> test_add_uchar(UCHAR_MAX, 1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: value too large to convert to unsigned char
    """
    let u8 r = x + y
    return r

# chars may be signed or unsigned
if (<i8>-1) < 0:
    CHAR_MAX = SCHAR_MAX
    CHAR_MIN = SCHAR_MIN
else:
    CHAR_MAX = UCHAR_MAX
    CHAR_MIN = 0

def test_char(i8 x):
    u"""
    >>> test_char(CHAR_MIN-1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: ...
    >>> if CHAR_MIN < 0:
    ...     assert test_char(-1) == -1
    >>> test_char(CHAR_MIN) == CHAR_MIN
    True
    >>> test_char(0)
    0
    >>> test_char(1)
    1
    >>> test_char(CHAR_MAX) == CHAR_MAX
    True
    >>> test_char(CHAR_MAX+1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: value too large to convert to char
    """
    return x

def test_add_char(x, y):
    u"""
    >>> test_add_char(CHAR_MIN, -1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: ...
    >>> test_add_char(CHAR_MIN, 0) == CHAR_MIN
    True
    >>> test_add_char(CHAR_MIN, 1) == CHAR_MIN+1
    True
    >>> test_add_char(CHAR_MAX, -1) == CHAR_MAX-1
    True
    >>> test_add_char(CHAR_MAX, 0) == CHAR_MAX
    True
    >>> test_add_char(CHAR_MAX, 1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: value too large to convert to char
    """
    let i8 r = x + y
    return r

# -------------------------------------------------------------------

SHORT_MAX = <i16>((<u16>-1)>>1)
SHORT_MIN = (-SHORT_MAX-1)

def test_short(i16 x):
    u"""
    >>> test_short(SHORT_MIN-1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: value too large to convert to short
    >>> test_short(SHORT_MIN) == SHORT_MIN
    True
    >>> test_short(-1)
    -1
    >>> test_short(0)
    0
    >>> test_short(1)
    1
    >>> test_short(SHORT_MAX) == SHORT_MAX
    True
    >>> test_short(SHORT_MAX+1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: value too large to convert to short
    """
    return x

def test_add_short(x, y):
    u"""
    >>> test_add_short(SHORT_MIN, -1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: value too large to convert to short
    >>> test_add_short(SHORT_MIN, 0) == SHORT_MIN
    True
    >>> test_add_short(SHORT_MIN, 1) == SHORT_MIN+1
    True
    >>> test_add_short(SHORT_MAX, -1) == SHORT_MAX-1
    True
    >>> test_add_short(SHORT_MAX, 0) == SHORT_MAX
    True
    >>> test_add_short(SHORT_MAX, 1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: value too large to convert to short
    """
    let i16 r = x + y
    return r

SSHORT_MAX = <i16>((<u16>-1)>>1)
SSHORT_MIN = (-SSHORT_MAX-1)

def test_sshort(i16 x):
   u"""
   >>> test_sshort(SSHORT_MIN-1) # doctest: +ELLIPSIS
   Traceback (most recent call last):
       ...
   OverflowError: value too large to convert to short
   >>> test_sshort(SSHORT_MIN) == SSHORT_MIN
   True
   >>> test_sshort(-1)
   -1
   >>> test_sshort(0)
   0
   >>> test_sshort(1)
   1
   >>> test_sshort(SSHORT_MAX) == SSHORT_MAX
   True
   >>> test_short(SSHORT_MAX+1) # doctest: +ELLIPSIS
   Traceback (most recent call last):
       ...
   OverflowError: value too large to convert to short
   """
   return x

def test_add_sshort(x, y):
    u"""
    >>> test_add_sshort(SSHORT_MIN, -1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: value too large to convert to short
    >>> test_add_sshort(SSHORT_MIN, 0) == SSHORT_MIN
    True
    >>> test_add_sshort(SSHORT_MIN, 1) == SSHORT_MIN+1
    True
    >>> test_add_sshort(SSHORT_MAX, -1) == SSHORT_MAX-1
    True
    >>> test_add_sshort(SSHORT_MAX, 0) == SSHORT_MAX
    True
    >>> test_add_sshort(SSHORT_MAX, 1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: value too large to convert to short
    """
    let i16 r = x + y
    return r

USHORT_MAX = <u16>((<u16>-1))

def test_ushort(u16 x):
    u"""
    >>> test_ushort(-1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: can't convert negative value to unsigned short
    >>> test_ushort(0)
    0
    >>> test_ushort(1)
    1
    >>> test_ushort(USHORT_MAX) == USHORT_MAX
    True
    >>> test_ushort(USHORT_MAX+1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: ...
    """
    return x

def test_add_ushort(x, y):
    u"""
    >>> test_add_ushort(USHORT_MAX, 0) == USHORT_MAX
    True
    >>> test_add_ushort(USHORT_MAX, 1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: value too large to convert to unsigned short
    """
    let u16 r = x + y
    return r

# -------------------------------------------------------------------

INT_MAX = <i32>((<u32>-1)>>1)
INT_MIN = (-INT_MAX-1)

def test_int(i32 x):
    u"""
    >>> test_int(INT_MIN-1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: ...
    >>> test_int(INT_MIN) == INT_MIN
    True
    >>> test_int(-1)
    -1
    >>> test_int(0)
    0
    >>> test_int(1)
    1
    >>> test_int(INT_MAX) == INT_MAX
    True
    >>> test_int(INT_MAX+1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: ...
    """
    return x

def test_add_int(x, y):
    u"""
    >>> test_add_int(INT_MIN, -1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: ...
    >>> test_add_int(INT_MIN, 0) == INT_MIN
    True
    >>> test_add_int(INT_MIN, 1) == INT_MIN+1
    True
    >>> test_add_int(INT_MAX, -1) == INT_MAX-1
    True
    >>> test_add_int(INT_MAX, 0) == INT_MAX
    True
    >>> test_add_int(INT_MAX, 1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: ...
    """
    let i32 r = x + y
    return r

SINT_MAX = <i32>((<u32>-1)>>1)
SINT_MIN = (-SINT_MAX-1)

def test_sint(i32 x):
   u"""
   >>> test_sint(SINT_MIN-1) # doctest: +ELLIPSIS
   Traceback (most recent call last):
       ...
   OverflowError: ...
   >>> test_sint(SINT_MIN) == SINT_MIN
   True
   >>> test_sint(-1)
   -1
   >>> test_sint(0)
   0
   >>> test_sint(1)
   1
   >>> test_sint(SINT_MAX) == SINT_MAX
   True
   >>> test_sint(SINT_MAX+1) # doctest: +ELLIPSIS
   Traceback (most recent call last):
       ...
   OverflowError: ...
   """
   return x

def test_add_sint(x, y):
    u"""
    >>> test_add_sint(SINT_MIN, -1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: ...
    >>> test_add_sint(SINT_MIN, 0) == SINT_MIN
    True
    >>> test_add_sint(SINT_MIN, 1) == SINT_MIN+1
    True
    >>> test_add_sint(SINT_MAX, -1) == SINT_MAX-1
    True
    >>> test_add_sint(SINT_MAX, 0) == SINT_MAX
    True
    >>> test_add_sint(SINT_MAX, 1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: ...
    """
    let i32 r = x + y
    return r

UINT_MAX = <u32>(<u32>-1)

def test_uint(u32 x):
    u"""
    >>> test_uint(-1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: can't convert negative value to u32
    >>> print(test_uint(0))
    0
    >>> print(test_uint(1))
    1
    >>> test_uint(UINT_MAX) == UINT_MAX
    True
    >>> test_uint(UINT_MAX+1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: ...
    """
    return x

def test_add_uint(x, y):
    u"""
    >>> test_add_uint(UINT_MAX, 0) == UINT_MAX
    True
    >>> test_add_uint(UINT_MAX, 1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: ...
    """
    let u32 r = x + y
    return r

# -------------------------------------------------------------------

LONG_MAX = <i64>((<u64>-1)>>1)
LONG_MIN = (-LONG_MAX-1)

def test_long(i64 x):
    u"""
    >>> test_long(LONG_MIN-1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: ...
    >>> test_long(LONG_MIN) == LONG_MIN
    True
    >>> test_long(-1)
    -1
    >>> test_long(0)
    0
    >>> test_long(1)
    1
    >>> test_long(LONG_MAX) == LONG_MAX
    True
    >>> test_long(LONG_MAX+1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: ...
    """
    return x

def test_add_long(x, y):
    u"""
    >>> test_add_long(LONG_MIN, -1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: ...
    >>> test_add_long(LONG_MIN, 0) == LONG_MIN
    True
    >>> test_add_long(LONG_MIN, 1) == LONG_MIN+1
    True
    >>> test_add_long(LONG_MAX, -1) == LONG_MAX-1
    True
    >>> test_add_long(LONG_MAX, 0) == LONG_MAX
    True
    >>> test_add_long(LONG_MAX, 1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: ...
    """
    let i64 r = x + y
    return r

SLONG_MAX = <i64>((<u64>-1)>>1)
SLONG_MIN = (-SLONG_MAX-1)

def test_slong(i64 x):
    u"""
    >>> test_slong(SLONG_MIN-1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: ...
    >>> test_slong(SLONG_MIN) == SLONG_MIN
    True
    >>> test_slong(-1)
    -1
    >>> test_slong(0)
    0
    >>> test_slong(1)
    1
    >>> test_slong(SLONG_MAX) == SLONG_MAX
    True
    >>> test_slong(SLONG_MAX+1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: ...
    """
    return x

def test_add_slong(x, y):
    u"""
    >>> test_add_slong(SLONG_MIN, -1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: ...
    >>> test_add_slong(SLONG_MIN, 0) == SLONG_MIN
    True
    >>> test_add_slong(SLONG_MIN, 1) == SLONG_MIN+1
    True
    >>> test_add_slong(SLONG_MAX, -1) == SLONG_MAX-1
    True
    >>> test_add_slong(SLONG_MAX, 0) == SLONG_MAX
    True
    >>> test_add_slong(SLONG_MAX, 1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: ...
    """
    let i64 r = x + y
    return r

ULONG_MAX = <u64>(<u64>-1)

def test_ulong(u64 x):
    u"""
    >>> test_ulong(-1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: can't convert negative value to u64
    >>> print(test_ulong(0))
    0
    >>> print(test_ulong(1))
    1
    >>> test_ulong(ULONG_MAX) == ULONG_MAX
    True
    >>> test_ulong(ULONG_MAX+1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: ...
    """
    return x

def test_add_ulong(x, y):
    u"""
    >>> test_add_ulong(ULONG_MAX, 0) == ULONG_MAX
    True
    >>> test_add_ulong(ULONG_MAX, 1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: ...
    """
    cdef u64 r = x + y
    return r

# -------------------------------------------------------------------

LONGLONG_MAX = <i128>((<u128>-1)>>1)
LONGLONG_MIN = (-LONGLONG_MAX-1)

def test_longlong(i128 x):
    u"""
    >>> test_longlong(LONGLONG_MIN-1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: ...
    >>> test_longlong(LONGLONG_MIN) == LONGLONG_MIN
    True
    >>> print(test_longlong(-1))
    -1
    >>> print(test_longlong(0))
    0
    >>> print(test_longlong(1))
    1
    >>> test_longlong(LONGLONG_MAX) == LONGLONG_MAX
    True
    >>> test_longlong(LONGLONG_MAX+1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: ...
    """
    return x

def test_add_longlong(x, y):
    u"""
    >>> test_add_longlong(LONGLONG_MIN, -1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: ...
    >>> test_add_longlong(LONGLONG_MIN, 0) == LONGLONG_MIN
    True
    >>> test_add_longlong(LONGLONG_MIN, 1) == LONGLONG_MIN+1
    True
    >>> test_add_longlong(LONGLONG_MAX, -1) == LONGLONG_MAX-1
    True
    >>> test_add_longlong(LONGLONG_MAX, 0) == LONGLONG_MAX
    True
    >>> test_add_longlong(LONGLONG_MAX, 1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: ...
    """
    cdef i128 r = x + y
    return r

SLONGLONG_MAX = <i128>((<u128>-1)>>1)
SLONGLONG_MIN = (-SLONGLONG_MAX-1)

def test_slonglong(i128 x):
    u"""
    >>> test_slonglong(SLONGLONG_MIN-1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: ...
    >>> test_slonglong(SLONGLONG_MIN) == SLONGLONG_MIN
    True
    >>> print(test_slonglong(-1))
    -1
    >>> print(test_slonglong(0))
    0
    >>> print(test_slonglong(1))
    1
    >>> test_slonglong(SLONGLONG_MAX) == SLONGLONG_MAX
    True
    >>> test_slonglong(SLONGLONG_MAX+1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: ...
    """
    return x

def test_add_slonglong(x, y):
    u"""
    >>> test_add_slonglong(SLONGLONG_MIN, -1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: ...
    >>> test_add_slonglong(SLONGLONG_MIN, 0) == SLONGLONG_MIN
    True
    >>> test_add_slonglong(SLONGLONG_MIN, 1) == SLONGLONG_MIN+1
    True
    >>> test_add_slonglong(SLONGLONG_MAX, -1) == SLONGLONG_MAX-1
    True
    >>> test_add_slonglong(SLONGLONG_MAX, 0) == SLONGLONG_MAX
    True
    >>> test_add_slonglong(SLONGLONG_MAX, 1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: ...
    """
    let i128 r = x + y
    return r

ULONGLONG_MAX = <u128>(<u128>-1)

def test_ulonglong(u128 x):
    u"""
    >>> test_ulonglong(-1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: can't convert negative value to unsigned PY_LONG_LONG
    >>> print(test_ulonglong(0))
    0
    >>> print(test_ulonglong(1))
    1
    >>> test_ulonglong(ULONGLONG_MAX) == ULONGLONG_MAX
    True
    >>> test_ulonglong(ULONGLONG_MAX+1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: ...
    """
    return x

def test_add_ulonglong(x, y):
    u"""
    >>> test_add_ulonglong(ULONGLONG_MAX, 0) == ULONGLONG_MAX
    True
    >>> test_add_ulonglong(ULONGLONG_MAX, 1) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: ...
    """
    let u128 r = x + y
    return r

# -------------------------------------------------------------------
import sys

class MyInt(object):
    def __init__(self, value):
        self.value = value
    def __int__(self):
        print(u"MyInt.__int__()")
        return self.value

class MyBadInt(MyInt):
    def __int__(self):
        return u"%s" % self.value

class MyInt2:
    def __init__(self, value):
        self.value = value
    def __int__(self):
        print(u"MyInt.__int__()")
        return self.value

class MyBadInt2(MyInt2):
    def __int__(self):
        return u"%s" % self.value

def test_convert_pyint(x):
    u"""
    >>> test_convert_pyint(None)  # doctest: +ELLIPSIS
    Traceback (most recent call last):
    TypeError:... int...
    >>> test_convert_pyint("123")  # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    TypeError:... int...
    >>> test_convert_pyint(MyBadInt(0)) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    TypeError: ... returned non-... (type ...)

    >>> test_convert_pyint(false) == 0
    True
    >>> test_convert_pyint(true) == 1
    True
    >>> test_convert_pyint(3.14) == 3
    True

    >>> test_convert_pyint(MyInt(LONG_MIN)) == LONG_MIN
    MyInt.__int__()
    True
    >>> test_convert_pyint(MyInt(0)) == 0
    MyInt.__int__()
    True
    >>> test_convert_pyint(MyInt(LONG_MAX)) == LONG_MAX
    MyInt.__int__()
    True
    """
    let i64 r = x
    return r

class MyLong(object):
    def __init__(self, value):
        self.value = value
    def __int__(self): # Python 3
        return self.__long__()
    def __long__(self):
        print(u"MyInt.__long__()")
        return self.value

class MyBadLong(MyLong):
    def __long__(self):
        return u"%s" % self.value

def test_convert_pylong(x):
    u"""
    >>> test_convert_pylong(None)  # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    TypeError:... int...
    >>> test_convert_pylong("123")  # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    TypeError:... int...
    >>> test_convert_pylong(MyBadLong(0)) # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    TypeError: ... returned non-... (type ...)

    >>> test_convert_pylong(false) == 0
    True
    >>> test_convert_pylong(true) == 1
    True
    >>> test_convert_pylong(3.14) == 3
    True

    >>> test_convert_pylong(MyLong(LONGLONG_MIN)) == LONGLONG_MIN
    MyInt.__long__()
    True
    >>> test_convert_pylong(MyLong(0)) == 0
    MyInt.__long__()
    True
    >>> test_convert_pylong(MyLong(LONGLONG_MAX)) == LONGLONG_MAX
    MyInt.__long__()
    True
    """
    cdef i128 r = x
    return r

enum:
   AnonymousEnumMember = 1

def test_anonymous_enum():
    """
    The main point here is that the from-py conversion function shouldn't
    conflict with the function for int
    >>> test_anonymous_enum()
    1
    """
    return AnonymousEnumMember

# -------------------------------------------------------------------

__doc__ = u"".join([
    f.__doc__ for f in (
        # 
        test_char,  test_add_char,
        test_schar, test_add_schar,
        test_uchar, test_add_uchar,
        # 
        test_short,  test_add_short,
        test_sshort, test_add_sshort,
        test_ushort, test_add_ushort,
        # 
        test_int,  test_add_int,
        test_sint, test_add_sint,
        test_uint, test_add_uint,
        # 
        test_long,  test_add_long,
        test_slong, test_add_slong,
        test_ulong, test_add_ulong,
        # 
        test_longlong,  test_add_longlong,
        test_slonglong, test_add_slonglong,
        test_ulonglong, test_add_ulonglong,
        # 
        test_convert_pyint,
        test_convert_pylong,
    )
])

# -------------------------------------------------------------------
