use cython

cdef bytes b12345 = b'12345'

def index_literal(i32 i):
    """
    Python 3 returns integer values on indexing, Py2 returns byte
    string literals...

    >>> index_literal(0) in (ord('1'), '1')
    True
    >>> index_literal(-5) in (ord('1'), '1')
    True
    >>> index_literal(2) in (ord('3'), '3')
    True
    >>> index_literal(4) in (ord('5'), '5')
    True
    """
    return b"12345"[i]

#[cython::test_assert_path_exists("//PythonCapiCallNode")]
#[cython::test_fail_if_path_exists("//IndexNode",
                                  "//CoerceFromPyTypeNode")]
def index_literal_char_cast(i32 i):
    """
    >>> index_literal_char_cast(0) == ord('1')
    True
    >>> index_literal_char_cast(-5) == ord('1')
    True
    >>> index_literal_char_cast(2) == ord('3')
    True
    >>> index_literal_char_cast(4) == ord('5')
    True
    >>> index_literal_char_cast(6)
    Traceback (most recent call last):
    IndexError: string index out of range
    """
    return <i8>(b"12345"[i])

#[cython::test_assert_path_exists("//PythonCapiCallNode")]
#[cython::test_fail_if_path_exists("//IndexNode",
                                  "//CoerceFromPyTypeNode")]
def index_nonliteral_char_cast(i32 i):
    """
    >>> index_nonliteral_char_cast(0) == ord('1')
    True
    >>> index_nonliteral_char_cast(-5) == ord('1')
    True
    >>> index_nonliteral_char_cast(2) == ord('3')
    True
    >>> index_nonliteral_char_cast(4) == ord('5')
    True
    >>> index_nonliteral_char_cast(6)
    Traceback (most recent call last):
    IndexError: string index out of range
    """
    return <i8>(b12345[i])

#[cython::test_assert_path_exists("//PythonCapiCallNode")]
#[cython::test_fail_if_path_exists("//IndexNode",
                                  "//CoerceFromPyTypeNode")]
def index_literal_uchar_cast(i32 i):
    """
    >>> index_literal_uchar_cast(0) == ord('1')
    True
    >>> index_literal_uchar_cast(-5) == ord('1')
    True
    >>> index_literal_uchar_cast(2) == ord('3')
    True
    >>> index_literal_uchar_cast(4) == ord('5')
    True
    >>> index_literal_uchar_cast(6)
    Traceback (most recent call last):
    IndexError: string index out of range
    """
    return <u8>(b"12345"[i])

#[cython::test_assert_path_exists("//PythonCapiCallNode")]
#[cython::test_fail_if_path_exists("//IndexNode",
                                  "//CoerceFromPyTypeNode")]
def index_nonliteral_uchar_cast(i32 i):
    """
    >>> index_nonliteral_uchar_cast(0) == ord('1')
    True
    >>> index_nonliteral_uchar_cast(-5) == ord('1')
    True
    >>> index_nonliteral_uchar_cast(2) == ord('3')
    True
    >>> index_nonliteral_uchar_cast(4) == ord('5')
    True
    >>> index_nonliteral_uchar_cast(6)
    Traceback (most recent call last):
    IndexError: string index out of range
    """
    return <u8>(b12345[i])

#[cython::test_assert_path_exists("//PythonCapiCallNode")]
#[cython::test_fail_if_path_exists("//IndexNode",
                                  "//CoerceFromPyTypeNode")]
def index_literal_char_coerce(i32 i):
    """
    >>> index_literal_char_coerce(0) == ord('1')
    True
    >>> index_literal_char_coerce(-5) == ord('1')
    True
    >>> index_literal_char_coerce(2) == ord('3')
    True
    >>> index_literal_char_coerce(4) == ord('5')
    True
    >>> index_literal_char_coerce(6)
    Traceback (most recent call last):
    IndexError: string index out of range
    """
    let i8 result = b"12345"[i]
    return result

#[cython::test_assert_path_exists("//PythonCapiCallNode")]
#[cython::test_fail_if_path_exists("//IndexNode",
                                  "//CoerceFromPyTypeNode")]
def index_nonliteral_char_coerce(i32 i):
    """
    >>> index_nonliteral_char_coerce(0) == ord('1')
    True
    >>> index_nonliteral_char_coerce(-5) == ord('1')
    True
    >>> index_nonliteral_char_coerce(2) == ord('3')
    True
    >>> index_nonliteral_char_coerce(4) == ord('5')
    True
    >>> index_nonliteral_char_coerce(6)
    Traceback (most recent call last):
    IndexError: string index out of range
    """
    let i8 result = b12345[i]
    return result

#[cython::test_assert_path_exists("//PythonCapiCallNode")]
#[cython::test_fail_if_path_exists("//IndexNode",
                                  "//CoerceFromPyTypeNode")]
#[cython::boundscheck(false)]
def index_literal_char_coerce_no_check(i32 i):
    """
    >>> index_literal_char_coerce_no_check(0) == ord('1')
    True
    >>> index_literal_char_coerce_no_check(-5) == ord('1')
    True
    >>> index_literal_char_coerce_no_check(2) == ord('3')
    True
    >>> index_literal_char_coerce_no_check(4) == ord('5')
    True
    """
    let i8 result = b"12345"[i]
    return result

#[cython::test_assert_path_exists("//PythonCapiCallNode")]
#[cython::test_fail_if_path_exists("//IndexNode",
                                  "//CoerceFromPyTypeNode")]
#[cython::boundscheck(false)]
def index_nonliteral_char_coerce_no_check(i32 i):
    """
    >>> index_nonliteral_char_coerce_no_check(0) == ord('1')
    True
    >>> index_nonliteral_char_coerce_no_check(-5) == ord('1')
    True
    >>> index_nonliteral_char_coerce_no_check(2) == ord('3')
    True
    >>> index_nonliteral_char_coerce_no_check(4) == ord('5')
    True
    """
    let i8 result = b12345[i]
    return result
