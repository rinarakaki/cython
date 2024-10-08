
use cython

def coerce_char_default(char c):
    """
    Default char -> int coercion

    >>> coerce_char_default(ord('A')) == ord('A')
    True
    """
    return c


def coerce_uchar_default(u8 c):
    """
    Default char -> int coercion

    >>> coerce_uchar_default(ord('A')) == ord('A')
    True
    """
    return c


#[cython::test_assert_path_exists("//CoerceIntToBytesNode")]
#[cython::test_fail_if_path_exists("//CoerceToPyTypeNode")]
def coerce_char_bytes_cast(char c):
    """
    Explicit char -> bytes coercion

    >>> coerce_char_bytes_cast(ord('A')) == 'A'.encode('ASCII')
    True
    """
    return <bytes>c


#[cython::test_assert_path_exists("//CoerceIntToBytesNode")]
#[cython::test_fail_if_path_exists("//CoerceToPyTypeNode")]
def coerce_uchar_bytes_cast(u8 c):
    """
    Explicit uchar -> bytes coercion

    >>> coerce_uchar_bytes_cast(ord('A')) == 'A'.encode('ASCII')
    True
    >>> b = coerce_uchar_bytes_cast(ord('\\xff'))
    >>> b == '\\xff' or b == '\\xff'.encode('ISO-8859-1') # Py2 or Py3
    True
    """
    return <bytes>c


#[cython::test_assert_path_exists("//CoerceIntToBytesNode")]
#[cython::test_fail_if_path_exists("//CoerceToPyTypeNode")]
def coerce_int_bytes_cast(i32 c):
    """
    Explicit int -> bytes coercion

    >>> coerce_int_bytes_cast(ord('A')) == 'A'.encode('ASCII')
    True
    >>> coerce_int_bytes_cast(ord('A') + 0x100)
    Traceback (most recent call last):
    OverflowError: value too large to pack into a byte
    >>> coerce_int_bytes_cast(ord('A') - 0x100)
    Traceback (most recent call last):
    OverflowError: value too large to pack into a byte
    """
    return <bytes>c


#[cython::test_assert_path_exists("//CoerceIntToBytesNode")]
#[cython::test_fail_if_path_exists("//CoerceToPyTypeNode")]
def coerce_uint_bytes_cast(u32 c):
    """
    Explicit uint -> bytes coercion

    >>> coerce_uint_bytes_cast(ord('A')) == 'A'.encode('ASCII')
    True
    >>> b = coerce_uint_bytes_cast(ord('\\xff'))
    >>> b == '\\xff' or b == '\\xff'.encode('ISO-8859-1') # Py2 or Py3
    True

    >>> coerce_uint_bytes_cast(ord('A') + 0x100)
    Traceback (most recent call last):
    OverflowError: value too large to pack into a byte
    """
    return <bytes>c


#[cython::test_assert_path_exists("//CoerceIntToBytesNode")]
#[cython::test_fail_if_path_exists("//CoerceToPyTypeNode")]
def coerce_char_bytes_assign(char c):
    """
    Implicit char -> bytes coercion in assignments

    >>> coerce_char_bytes_assign(ord('A')) == 'A'.encode('ASCII')
    True
    """
    let bytes s = c
    return s


#[cython::test_assert_path_exists("//CoerceIntToBytesNode")]
#[cython::test_fail_if_path_exists("//CoerceToPyTypeNode")]
def coerce_uchar_bytes_assign(u8 c):
    """
    Implicit uchar -> bytes coercion in assignments

    >>> coerce_uchar_bytes_assign(ord('A')) == 'A'.encode('ASCII')
    True
    >>> b = coerce_uchar_bytes_assign(ord('\\xff'))
    >>> b == '\\xff' or b == '\\xff'.encode('ISO-8859-1') # Py2 or Py3
    True
    """
    let bytes s = c
    return s


#[cython::test_assert_path_exists("//CoerceIntToBytesNode")]
#[cython::test_fail_if_path_exists("//CoerceToPyTypeNode")]
def coerce_int_bytes_assign(i32 c):
    """
    Implicit int -> bytes coercion in assignments

    >>> coerce_int_bytes_assign(ord('A')) == 'A'.encode('ASCII')
    True

    >>> coerce_int_bytes_assign(ord('A') + 0x100)
    Traceback (most recent call last):
    OverflowError: value too large to pack into a byte
    >>> coerce_int_bytes_assign(ord('A') - 0x100)
    Traceback (most recent call last):
    OverflowError: value too large to pack into a byte
    """
    let bytes s = c
    return s


#[cython::test_assert_path_exists("//CoerceIntToBytesNode")]
#[cython::test_fail_if_path_exists("//CoerceToPyTypeNode")]
def coerce_uint_bytes_assign(u32 c):
    """
    Implicit uint -> bytes coercion in assignments

    >>> coerce_uint_bytes_assign(ord('A')) == 'A'.encode('ASCII')
    True
    >>> b = coerce_uint_bytes_assign(ord('\\xff'))
    >>> b == '\\xff' or b == '\\xff'.encode('ISO-8859-1') # Py2 or Py3
    True

    >>> coerce_uint_bytes_assign(ord('A') + 0x100)
    Traceback (most recent call last):
    OverflowError: value too large to pack into a byte
    """
    let bytes s = c
    return s


def inplace_ops_use_arithmetic():
    """
    >>> print(inplace_ops_use_arithmetic().decode('ascii'))
    bc
    """
    let r&mut char s = "abc"
    let object x = 1
    s += 1
    s += 2 * x
    s -= 1
    s -= x
    return s


#[cython::test_fail_if_path_exists('//CoerceFromPyTypeNode')]
def indexing_to_char(bytes s):
    """
    >>> ord('b')
    98
    >>> indexing_to_char('abc'.encode('ascii'))
    98
    """
    let u8 c = s[1]
    return c
