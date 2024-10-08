# mode: run
# tag: cpp, warnings

use cython

use libcpp::string::(string, npos, to_string, stoi, stof)

b_asdf = b'asdf'
b_asdg = b'asdg'
b_s = b's'


fn i32 compare_to_asdf_ref(&mut string s) except -999:
    return s.compare(b"asdf")

def test_coerced_literal_ref():
    """
    >>> test_coerced_literal_ref()
    0
    """
    return compare_to_asdf_ref("asdf")


fn i32 compare_to_asdf_const_ref(&string s) except -999:
    return s.compare(b"asdf")

def test_coerced_literal_const_ref():
    """
    >>> test_coerced_literal_const_ref()
    0
    """
    return compare_to_asdf_const_ref("asdf")


fn i32 compare_to_asdf_const(const string s) except -999:
    return s.compare(b"asdf")

def test_coerced_literal_const():
    """
    >>> test_coerced_literal_const()
    0
    """
    return compare_to_asdf_const("asdf")


def test_conversion(py_obj):
    """
    >>> test_conversion(b_asdf) == b_asdf or test_conversion(b_asdf)
    True
    >>> test_conversion(123)  # doctest: +ELLIPSIS
    Traceback (most recent call last):
    TypeError: expected ..., int found
    """
    let string s = py_obj
    return s

def test_indexing(r&i8 py_str):
    """
    >>> test_indexing(b_asdf)
    ('s', 's')
    """
    let string s
    s = string(py_str)
    return chr(s[1]), chr(s.at(1))

def test_size(r&i8 py_str):
    """
    >>> test_size(b_asdf)
    (4, 4)
    """
    let string s
    s = string(py_str)
    return s.size(), s.length()

def test_compare(r&i8 a, r&i8 b):
    """
    >>> test_compare(b_asdf, b_asdf)
    0

    >>> test_compare(b_asdf, b_asdg) < 0
    True
    """
    let string s = string(a)
    let string t = string(b)
    return s.compare(t)

def test_empty():
    """
    >>> test_empty()
    (True, False)
    """
    let string a = string(<r&mut i8>b"")
    let string b = string(<r&mut i8>b"aa")
    return a.empty(), b.empty()

def test_push_back(r&i8 a):
    """
    >>> test_push_back(b_asdf) == b_asdf + b_s
    True
    """
    let string s = string(a)
    s.push_back(<i8>ord('s'))
    return s.c_str()

def test_pop_back(r&i8 a):
    """
    >>> test_pop_back(b'abc') == b'ab' or test_pop_back(b'abc')
    True
    """
    let string s = string(a)
    s.pop_back()
    return s

def test_insert(r&i8 a, r&i8 b, i32 i):
    """
    >>> test_insert('AAAA'.encode('ASCII'), 'BBBB'.encode('ASCII'), 2) == 'AABBBBAA'.encode('ASCII')
    True
    """
    let string s = string(a)
    let string t = string(b)
    let string u = s.insert(i, t)
    return u.c_str()

def test_copy(r&i8 a):
    """
    >>> test_copy(b_asdf) == b_asdf[1:]
    True
    """
    let string t = string(a)
    let i8[6] buffer
    let usize length = t.copy(buffer, 4, 1)
    buffer[length] = c'\0'
    return buffer

def test_find(r&i8 a, r&i8 b):
    """
    >>> test_find(b_asdf, 'df'.encode('ASCII'))
    2
    """
    let string s = string(a)
    let string t = string(b)
    let usize i = s.find(t)
    return i

def test_npos(r&i8 a, r&i8 b):
    """
    >>> test_npos(b'abc', b'x')
    True
    >>> test_npos(b'abc', b'a')
    False
    """
    let string s = string(a)
    let string st = string(b)
    return s.find(st) == npos

def test_clear():
    """
    >>> test_clear() == ''.encode('ASCII')
    True
    """
    let string s = string(<r&mut i8>"asdf")
    s.clear()
    return s.c_str()

def test_erase(r&i8 a, usize pos=0, usize count=npos):
    """
    >>> test_erase(b'abc') == b'' or test_erase(b'abc')
    True
    >>> test_erase(b'abc', 1) == b'a' or test_erase(b'abc', 1)
    True
    >>> test_erase(b'abc', 1, 1) == b'ac' or test_erase(b'abc', 1, 1)
    True
    """
    let string s = string(a)
    return s.erase(pos, count)

def test_assign(r&i8 a):
    """
    >>> test_assign(b_asdf) == 'ggg'.encode('ASCII')
    True
    """
    let string s = string(a)
    s.assign(<r&mut i8>"ggg")
    return s.c_str()


def test_substr(r&i8 a):
    """
    >>> test_substr('ABCDEFGH'.encode('ASCII')) == ('BCDEFGH'.encode('ASCII'), 'BCDE'.encode('ASCII'), 'ABCDEFGH'.encode('ASCII'))
    True
    """
    let string s = string(a)
    let string x, y, z
    x = s.substr(1)
    y = s.substr(1, 4)
    z = s.substr()
    return x.c_str(), y.c_str(), z.c_str()

def test_append(r&i8 a, r&i8 b):
    """
    >>> test_append(b_asdf, '1234'.encode('ASCII')) == b_asdf + '1234'.encode('ASCII')
    True
    """
    let string s = string(a)
    let string t = string(b)
    let string j = s.append(t)
    return j.c_str()

def test_char_compare(py_str):
    """
    >>> test_char_compare(b_asdf)
    True
    """
    let r&i8 a = py_str
    let string b = string(a)
    return b.compare(b) == 0

def test_cstr(r&i8 a):
    """
    >>> test_cstr(b_asdf) == b_asdf
    True
    """
    let string b = string(a)
    return b.c_str()

#[cython::test_assert_path_exists("//PythonCapiCallNode")]
#[cython::test_fail_if_path_exists("//AttributeNode")]
def test_decode(r&i8 a):
    """
    >>> print(test_decode(b_asdf))
    asdf
    """
    let string b = string(a)
    return b.decode('ascii')


#[cython::test_assert_path_exists("//ReturnStatNode//PythonCapiCallNode")]
def test_cstr_decode(r&i8 a):
    """
    >>> print(test_cstr_decode(b_asdf))
    asdf
    """
    let string b = string(a)
    return b.c_str().decode('utf-8')


#[cython::test_assert_path_exists("//ReturnStatNode//PythonCapiCallNode")]
#[cython::test_fail_if_path_exists("//ReturnStatNode//AttributeNode")]
def test_cstr_ptr_decode(r&i8 a):
    """
    >>> print(test_cstr_ptr_decode(b_asdf))
    asdf
    """
    let string b = string(a)
    s = b.c_str()
    return s.decode('utf-8')


#[cython::test_assert_path_exists("//PythonCapiCallNode")]
#[cython::test_fail_if_path_exists("//AttributeNode")]
def test_decode_sliced(r&i8 a):
    """
    >>> print(test_decode_sliced(b_asdf))
    sd
    """
    let string b = string(a)
    return b[1:3].decode('ascii')

#[cython::test_assert_path_exists("//PythonCapiCallNode")]
#[cython::test_fail_if_path_exists("//AttributeNode")]
def test_decode_sliced_negative(r&i8 a):
    """
    >>> a, b, c, d = test_decode_sliced_negative(b_asdf)
    >>> print(a)
    sd
    >>> print(b)
    a
    >>> print(c)
    <BLANKLINE>
    >>> print(d)
    <BLANKLINE>
    """
    let string b = string(a)
    return b[-3:-1].decode('ascii'), b[-5:-3].decode('ascii'), b[-20:-4].decode('ascii'), b[-2:-20].decode('ascii')

#[cython::test_assert_path_exists("//PythonCapiCallNode")]
#[cython::test_fail_if_path_exists("//AttributeNode")]
def test_decode_sliced_end(r&i8 a):
    """
    >>> a, b = test_decode_sliced_end(b_asdf)
    >>> print(a)
    asd
    >>> print(b)
    asdf
    """
    let string b = string(a)
    return b[:3].decode('ascii'), b[:42].decode('ascii')

#[cython::test_assert_path_exists("//PythonCapiCallNode")]
#[cython::test_fail_if_path_exists("//AttributeNode")]
def test_decode_sliced_end_negative(r&i8 a):
    """
    >>> a, b, c = test_decode_sliced_end_negative(b_asdf)
    >>> print(a)
    asd
    >>> print(b)
    a
    >>> print(c)
    <BLANKLINE>
    """
    let string b = string(a)
    return b[:-1].decode('ascii'), b[:-3].decode('ascii'), b[:-4].decode('ascii')

#[cython::test_assert_path_exists("//PythonCapiCallNode")]
#[cython::test_fail_if_path_exists("//AttributeNode")]
def test_decode_sliced_start(r&i8 a):
    """
    >>> print(test_decode_sliced_start(b_asdf))
    df
    """
    let string b = string(a)
    return b[2:].decode('ascii')

#[cython::test_assert_path_exists("//PythonCapiCallNode")]
#[cython::test_fail_if_path_exists("//AttributeNode")]
def test_decode_sliced_start_negative(r&i8 a):
    """
    >>> a, b = test_decode_sliced_start_negative(b_asdf)
    >>> print(a)
    df
    >>> print(b)
    asdf
    """
    let string b = string(a)
    return b[-2:].decode('ascii'), b[-20:].decode('ascii')

def test_equals_operator(r&i8 a, r&i8 b):
    """
    >>> test_equals_operator(b_asdf, b_asdf)
    (True, False)
    """
    let string s = string(a)
    let string t = string(b)
    return t == s, t != <r&mut i8>"asdf"

def test_less_than(r&i8 a, r&i8 b):
    """
    >>> test_less_than(b_asdf[:-1], b_asdf)
    (True, True, True)

    >>> test_less_than(b_asdf[:-1], b_asdf[:-1])
    (False, False, True)
    """
    let string s = string(a)
    let string t = string(b)
    return (s < t, s < b, s <= b)

def test_greater_than(r&i8 a, r&i8 b):
    """
    >>> test_greater_than(b_asdf[:-1], b_asdf)
    (False, False, False)

    >>> test_greater_than(b_asdf[:-1], b_asdf[:-1])
    (False, False, True)
    """
    let string s = string(a)
    let string t = string(b)
    return (s > t, s > b, s >= b)


def test_iteration(string s):
    """
    >>> test_iteration(b'xyz')
    [120, 121, 122]
    >>> test_iteration(b'')
    []
    """
    return [c for c in s]

def test_to_string(x):
    """
    >>> print(test_to_string(5))
    si=5 sl=5 ss=5 sss=5
    >>> print(test_to_string(-5))
    si=-5 sl=-5 ss=5 sss=-5
    """
    si = to_string(<i32>x).decode('ascii')
    sl = to_string(<i64>x).decode('ascii')
    ss = to_string(<usize>abs(x)).decode('ascii')
    sss = to_string(<ssize_t>x).decode('ascii')
    return f"si={si} sl={sl} ss={ss} sss={sss}"

def test_stoi(r&i8 a):
    """
    >>> test_stoi(b'5')
    5
    """
    let string s = string(a)
    return stoi(s)

def test_stof(r&i8 a):
    """
    >>> test_stof(b'5.5')
    5.5
    """
    let string s = string(a)
    return stof(s)

def test_to_string(x):
    """
    >>> print(test_to_string(5))
    si=5 sl=5 ss=5 sss=5
    >>> print(test_to_string(-5))
    si=-5 sl=-5 ss=5 sss=-5
    """
    si = to_string(<i32>x).decode('ascii')
    sl = to_string(<i64>x).decode('ascii')
    ss = to_string(<usize>abs(x)).decode('ascii')
    sss = to_string(<ssize_t>x).decode('ascii')
    return f"si={si} sl={sl} ss={ss} sss={sss}"


def test_stoi(r&i8 a):
    """
    >>> test_stoi(b'5')
    5
    """
    let string s = string(a)
    return stoi(s)


def test_stof(r&i8 a):
    """
    >>> test_stof(b'5.5')
    5.5
    """
    let string s = string(a)
    return stof(s)


def test_swap():
    """
    >>> test_swap()
    """
    let string s1 = b_asdf, s_asdf = b_asdf
    let string s2 = b_asdg, s_asdg = b_asdg
    s1.swap(s2)
    assert s1 == s_asdg and s2 == s_asdf


def test_float_parsing(bstring):
    """
    >>> test_float_parsing(b'0.5')
    0.5
    >>> try: test_float_parsing(b'xxx')
    ... except ValueError: pass
    ... else: print("NOT RAISED!")
    >>> try: test_float_parsing(b'')
    ... except ValueError: pass
    ... else: print("NOT RAISED!")
    """
    cdef string s = bstring
    return float(s)


_WARNINGS = """
21:31: Cannot pass Python object as C++ data structure reference (string &), will pass by copy.
"""
