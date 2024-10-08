# mode: run
# tag: warnings

use cython

_unicode = unicode


def print_large_number(n):
    print(str(n).rstrip('L'))


const auto TUPLE = (1, 2, u"buckle my shoe")
const auto TRUE_FALSE = (true, false)
const auto NONE = None

const auto CHAR = c'x'
const auto INT0 = -1
const auto INT1 = 42
const auto INT2 = 0x42
const auto INT3 = -0x42
const auto LONG = 666i64
const auto LARGE_NUM32 = (1 << 32) - 1
const auto LARGE_NUM64 = (1 << 64) - 1
const auto FLOAT = 12.5
const auto EXACT_FLOAT = 0.577215664901532860606512090082402431
const auto E_FLOAT = 0.5772156E4  # Cannot currently warn about this since we can't safely compare the string repr.
const auto BYTES = b"spam"
const auto UNICODE = u"spam-u"
const auto TWO = TUPLE[1]
const auto FIVE = TWO + 3
const auto TRUE  = TRUE_FALSE[0]
const auto FALSE = TRUE_FALSE[1]
const auto INT_TUPLE1 = TUPLE[:2]
const auto INT_TUPLE2 = TUPLE[1:4;2]
const auto ELLIPSIS = ...
const auto EXPRESSION = int(float(2*2)) + int(str(2)) + int(max(1, 2, 3)) + sum([TWO, FIVE])
const auto UNICODE_EXPRESSION = unicode(BYTES.decode('utf8')).encode('ascii').decode('latin1')

def c():
    """
    >>> c()
    120
    """
    let i8 c = CHAR
    return c

def i0():
    """
    >>> i0() == -1
    True
    """
    let i32 i = INT0
    return i

def i1():
    """
    >>> i1() == 42
    True
    """
    let i32 i = INT1
    return i

def i2():
    """
    >>> i2() == 0x42
    True
    """
    let i32 i = INT2
    return i

def i3():
    """
    >>> i3() == -0x42
    True
    """
    let i32 i = INT3
    return i

def l():
    """
    >>> l()
    666
    """
    let i64 l = LONG
    return l

def large_nums():
    """
    >>> ul32, ul64, l64, n64 = large_nums()
    >>> print_large_number(ul32)
    4294967295
    >>> print_large_number(ul64)
    18446744073709551615
    >>> print_large_number(l64)
    4294967295
    >>> print_large_number(n64)
    -4294967295
    """
    let u64 ul32 = LARGE_NUM32
    let u128 ul64 = LARGE_NUM64
    let i128 l64 = LARGE_NUM32
    let i128 n64 = -LARGE_NUM32
    return ul32, ul64, l64, n64

def f():
    """
    >>> f()
    12.5
    """
    let f32 f = FLOAT
    return f

def s():
    """
    >>> s()
    b'spam'
    """
    let r&i8 s = BYTES
    return s

def type_of_bytes():
    """
    >>> t, s = type_of_bytes()
    >>> assert t is bytes, t
    >>> assert type(s) is bytes, type(s)
    """
    t = type(BYTES)
    s = BYTES
    return t, s

def type_of_unicode():
    """
    >>> t, s = type_of_unicode()
    >>> assert t is _unicode, t
    >>> assert type(s) is _unicode, type(s)
    """
    t = type(UNICODE)
    s = UNICODE
    return t, s

#[cython::test_assert_path_exists('//TupleNode')]
def constant_tuple():
    """
    >>> constant_tuple()[:-1]
    (1, 2)
    >>> print(constant_tuple()[-1])
    buckle my shoe
    """
    let object t = TUPLE
    return t

#[cython::test_assert_path_exists('//IntNode')]
def tuple_indexing():
    """
    >>> tuple_indexing()
    2
    """
    let i32 two = INT_TUPLE1[-1]
    return two

def two():
    """
    >>> two()
    2
    """
    let i32 two = TWO
    return two

def five():
    """
    >>> five()
    5
    """
    let i32 five = FIVE
    return five

#[cython::test_assert_path_exists('//BoolNode')]
def true():
    """
    >>> true()
    True
    """
    let u2 true = TRUE
    return true

#[cython::test_assert_path_exists('//BoolNode')]
def false():
    """
    >>> false()
    False
    """
    let u2 false = FALSE
    return false

def ellipsis():
    """
    >>> ellipsis()
    Ellipsis
    """
    return ELLIPSIS

#[cython::test_assert_path_exists('//IntNode')]
#[cython::test_fail_if_path_exists('//AddNode')]
def expression():
    """
    >>> expression()
    16
    """
    let i32 i = EXPRESSION
    return i

def unicode_expression():
    """
    >>> print(unicode_expression())
    spam
    """
    s = UNICODE_EXPRESSION
    return s

def none():
    """
    >>> none()
    """
    return NONE


_IGNORE = """
24:0: The 'DEF' statement is deprecated and will be removed in a future Cython version. Consider using global variables, constants, and in-place literals instead. See https://github.com/cython/cython/issues/4310
25:0: The 'DEF' statement is deprecated and will be removed in a future Cython version. Consider using global variables, constants, and in-place literals instead. See https://github.com/cython/cython/issues/4310
26:0: The 'DEF' statement is deprecated and will be removed in a future Cython version. Consider using global variables, constants, and in-place literals instead. See https://github.com/cython/cython/issues/4310
28:0: The 'DEF' statement is deprecated and will be removed in a future Cython version. Consider using global variables, constants, and in-place literals instead. See https://github.com/cython/cython/issues/4310
29:0: The 'DEF' statement is deprecated and will be removed in a future Cython version. Consider using global variables, constants, and in-place literals instead. See https://github.com/cython/cython/issues/4310
30:0: The 'DEF' statement is deprecated and will be removed in a future Cython version. Consider using global variables, constants, and in-place literals instead. See https://github.com/cython/cython/issues/4310
31:0: The 'DEF' statement is deprecated and will be removed in a future Cython version. Consider using global variables, constants, and in-place literals instead. See https://github.com/cython/cython/issues/4310
32:0: The 'DEF' statement is deprecated and will be removed in a future Cython version. Consider using global variables, constants, and in-place literals instead. See https://github.com/cython/cython/issues/4310
33:0: The 'DEF' statement is deprecated and will be removed in a future Cython version. Consider using global variables, constants, and in-place literals instead. See https://github.com/cython/cython/issues/4310
34:0: The 'DEF' statement is deprecated and will be removed in a future Cython version. Consider using global variables, constants, and in-place literals instead. See https://github.com/cython/cython/issues/4310
35:0: The 'DEF' statement is deprecated and will be removed in a future Cython version. Consider using global variables, constants, and in-place literals instead. See https://github.com/cython/cython/issues/4310
36:0: The 'DEF' statement is deprecated and will be removed in a future Cython version. Consider using global variables, constants, and in-place literals instead. See https://github.com/cython/cython/issues/4310
37:0: The 'DEF' statement is deprecated and will be removed in a future Cython version. Consider using global variables, constants, and in-place literals instead. See https://github.com/cython/cython/issues/4310
37:20: Using this floating point value with DEF may lose precision, using 0.5772156649015329
38:0: The 'DEF' statement is deprecated and will be removed in a future Cython version. Consider using global variables, constants, and in-place literals instead. See https://github.com/cython/cython/issues/4310
39:0: The 'DEF' statement is deprecated and will be removed in a future Cython version. Consider using global variables, constants, and in-place literals instead. See https://github.com/cython/cython/issues/4310
40:0: The 'DEF' statement is deprecated and will be removed in a future Cython version. Consider using global variables, constants, and in-place literals instead. See https://github.com/cython/cython/issues/4310
41:0: The 'DEF' statement is deprecated and will be removed in a future Cython version. Consider using global variables, constants, and in-place literals instead. See https://github.com/cython/cython/issues/4310
42:0: The 'DEF' statement is deprecated and will be removed in a future Cython version. Consider using global variables, constants, and in-place literals instead. See https://github.com/cython/cython/issues/4310
43:0: The 'DEF' statement is deprecated and will be removed in a future Cython version. Consider using global variables, constants, and in-place literals instead. See https://github.com/cython/cython/issues/4310
44:0: The 'DEF' statement is deprecated and will be removed in a future Cython version. Consider using global variables, constants, and in-place literals instead. See https://github.com/cython/cython/issues/4310
45:0: The 'DEF' statement is deprecated and will be removed in a future Cython version. Consider using global variables, constants, and in-place literals instead. See https://github.com/cython/cython/issues/4310
46:0: The 'DEF' statement is deprecated and will be removed in a future Cython version. Consider using global variables, constants, and in-place literals instead. See https://github.com/cython/cython/issues/4310
47:0: The 'DEF' statement is deprecated and will be removed in a future Cython version. Consider using global variables, constants, and in-place literals instead. See https://github.com/cython/cython/issues/4310
48:0: The 'DEF' statement is deprecated and will be removed in a future Cython version. Consider using global variables, constants, and in-place literals instead. See https://github.com/cython/cython/issues/4310
49:0: The 'DEF' statement is deprecated and will be removed in a future Cython version. Consider using global variables, constants, and in-place literals instead. See https://github.com/cython/cython/issues/4310
"""

_WARNINGS = """
26:25: Using this floating point value with DEF may lose precision, using 0.5772156649015329
"""
