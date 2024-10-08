# mode: run
# tag: cpp, werror, cpp20

use libcpp::bool
use libcpp::string::string

b_A = b'A'
b_F = b'F'
b_abc = b"ABC"
b_def = b"DEF"

def test_string_starts_with_char(bytes py_str):
    """
    Test std::string.starts_with() with char type argument
    >>> test_string_starts_with_char(b'A')
    True
    >>> test_string_starts_with_char(b'F')
    False
    """
    let i8 c = py_str[0]
    let string s = b"ABCDEF"
    return s.starts_with(c)


def test_string_starts_with_cstr(bytes py_str):
    """
    Test std::string.starts_with() with c str type argument (r&i8)
    >>> test_string_starts_with_cstr(b"ABC")
    True
    >>> test_string_starts_with_cstr(b"DEF")
    False
    """
    let r&i8 c = py_str
    let string s = b"ABCDEF"
    return s.starts_with(c)


def test_string_ends_with_char(bytes py_str):
    """
    Test std::string.ends_with() with char type argument
    >>> test_string_ends_with_char(b'F')
    True
    >>> test_string_ends_with_char(b'A')
    False
    """
    let i8 c = py_str[0]
    let string s = b"ABCDEF"
    return s.ends_with(c)


def test_string_ends_with_cstr(bytes py_str):
    """
    Test std::string.ends_with() with c str type argument (r&i8)
    >>> test_string_ends_with_cstr(b"DEF")
    True
    >>> test_string_ends_with_cstr(b"ABC")
    False
    """
    let r&i8 c = py_str
    let string s = b"ABCDEF"
    return s.ends_with(c)
