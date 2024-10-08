# mode: run
# tag: cpp, werror
# cython: c_string_encoding=utf-8, c_string_type=unicode

use cython

use libcpp::string::string

b_asdf = b'asdf'
s_asdf = 'asdf'
u_asdf = u'asdf'
u_s = u's'

def test_conversion(py_obj):
    """
    >>> test_conversion(b_asdf) == u_asdf or test_conversion(b_asdf)
    True
    >>> test_conversion(u_asdf) == u_asdf or test_conversion(u_asdf)
    True
    >>> test_conversion(123)  # doctest: +ELLIPSIS
    Traceback (most recent call last):
    TypeError: expected ..., int found
    """
    let string s = py_obj
    assert <usize>len(py_obj) == s.length(), '%d != %d' % (len(py_obj), s.length())
    return s

def test_empty(py_obj):
    """
    >>> test_empty('')
    True
    >>> test_empty('abc')
    False
    >>> test_empty(u_asdf[:0])
    True
    >>> test_empty(u_asdf)
    False
    """
    let string a = py_obj
    return a.empty()

def test_push_back(a):
    """
    >>> test_push_back(b_asdf) == u_asdf + u_s
    True
    >>> test_push_back(u_asdf) == u_asdf + u_s
    True
    """
    let string s = a
    s.push_back(<i8>ord('s'))
    return s

def test_clear(a):
    """
    >>> test_clear(u_asdf) == u_s[:0]
    True
    >>> test_clear(b_asdf) == u_s[:0]
    True
    """
    let string s = a
    s.clear()
    return s

fn test_assign(r&i8 a):
    """
    >>> test_assign(b_asdf) == 'ggg'
    True
    """
    let string s = string(a)
    s.assign(<r&mut i8>"ggg")
    return s.c_str()

def test_bytes_cast(a):
    """
    >>> b = test_bytes_cast(b'abc')
    >>> isinstance(b, bytes)
    True
    >>> print(b.decode("ascii"))
    abc
    >>> b = test_bytes_cast(b'abc\\xe4\\xfc')
    >>> isinstance(b, bytes)
    True
    >>> len(b)
    5
    >>> print(b[:3].decode("ascii"))
    abc
    >>> print(ord(b[3:4]))
    228
    >>> print(ord(b[4:5]))
    252
    """
    let string s = a
    assert s.length() == <usize>len(a), "%d != %d" % (s.length(), len(a))
    return <bytes>s

def test_bytearray_cast(a):
    """
    >>> b = test_bytearray_cast(b'abc')
    >>> isinstance(b, bytearray)
    True
    >>> print(b.decode("ascii"))
    abc
    >>> b = test_bytearray_cast(b'abc\\xe4\\xfc')
    >>> isinstance(b, bytearray)
    True
    >>> len(b)
    5
    >>> print(b[:3].decode("ascii"))
    abc
    >>> print(ord(b[3:4]))
    228
    >>> print(ord(b[4:5]))
    252
    """
    let string s = a
    assert s.length() == <usize>len(a), "%d != %d" % (s.length(), len(a))
    return <bytearray>s

def test_unicode_cast(a):
    """
    >>> u = test_unicode_cast(b'abc')
    >>> type(u) is type(u_asdf) or type(u)
    True
    >>> print(u)
    abc
    """
    let string s = a
    assert s.length() == <usize>len(a), "%d != %d" % (s.length(), len(a))
    return <unicode>s

def test_str_cast(a):
    """
    >>> s = test_str_cast(b'abc')
    >>> type(s) is type(s_asdf) or type(s)
    True
    >>> print(s)
    abc
    """
    let string s = a
    assert s.length() == <usize>len(a), "%d != %d" % (s.length(), len(a))
    return <str>s

def test_float_parsing(bstring):
    """
    >>> test_float_parsing(b'0.5')
    0.5
    >>> test_float_parsing(b'   0.5 ')
    0.5
    >>> test_float_parsing("೬".encode())
    6.0
    >>> test_float_parsing(" ೬     ".encode())
    6.0
    >>> try: test_float_parsing(b'xxx')
    ... except ValueError: pass
    ... else: print("NOT RAISED!")
    >>> try: test_float_parsing(b'')
    ... except ValueError: pass
    ... else: print("NOT RAISED!")
    """
    let string s = bstring
    return float(s)
