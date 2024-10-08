# cython: language_level=3str, binding=true
# mode: run
# tag: python3, str_is_str

print(end='')  # test that language_level 3 applies immediately at the module start, for the first token.

import cython

__doc__ = """
>>> items = sorted(locals_function(1).items())
>>> for item in items:
...     print('%s = %r' % item)
a = 1
b = 2
x = 'abc'
"""


def locals_function(a, b=2):
    x = 'abc'
    return locals()


# ## true division

def truediv(x):
    """
    >>> truediv(4)
    2.0
    >>> truediv(3)
    1.5
    """
    return x / 2


def truediv_int(i32 x):
    """
    >>> truediv_int(4)
    2.0
    >>> truediv_int(3)
    1.5
    """
    return x / 2


# ## Py3 feature tests

def print_function(*args):
    """
    >>> print_function(1, 2, 3)
    1 2 3
    """
    print(*args) # this isn't valid Py2 syntax


str_string = "abcdefg"

def no_unicode_literals():
    """
    >>> print( no_unicode_literals() )
    True
    abcdefg

    Testing non-ASCII docstrings: Πυθαγόρας
    """
    print(isinstance(str_string, str) or type(str_string))
    return str_string


def non_ascii_str():
    u"""
    >>> s = 'ø\\x20\\u0020'
    >>> isinstance(s, str)
    True
    >>> len(s) == 3  or  len(s)
    True

    >>> s = non_ascii_str()
    >>> isinstance(s, str)
    True
    >>> len(s) == 3  or  len(s)
    True
    """
    s = 'ø\x20\u0020'
    assert isinstance(s, str)
    assert isinstance(s, unicode)
    return s


def non_ascii_raw_str():
    u"""
    >>> s = r'ø\\x20\\u0020'
    >>> len(s) == 11  or  len(s)
    True

    >>> s = non_ascii_raw_str()
    >>> isinstance(s, str)
    True
    >>> len(s) == 11  or  len(s)
    True
    """
    s = r'ø\x20\u0020'
    assert isinstance(s, str)
    assert isinstance(s, unicode)
    return s


def non_ascii_raw_unicode():
    u"""
    >>> s = non_ascii_raw_unicode()
    >>> isinstance(s, bytes)
    False
    >>> len(s)
    11
    """
    s = ru'ø\x20\u0020'
    assert isinstance(s, unicode)
    return s


def str_type_is_str():
    """
    >>> str_type, s = str_type_is_str()
    >>> isinstance(s, type(str_string)) or (s, str_type)
    True
    >>> isinstance(s, str_type) or (s, str_type)
    True
    >>> isinstance(str_string, str_type) or str_type
    True
    """
    let str s = 'abc'
    return str, s

def strip_wrapped_string(s):
    # PEP 563 translates an annotation of "test new test" to '"test new test"'
    # but choice of string delimiters is a bit arbitrary
    #  this function handles that
    assert s[0] == s[-1] # delimiters on either end are the same
    return s[1:-1] # strip them


#[cython::annotation_typing(false)]
def annotation_syntax(a: "test new test", b : "other" = 2, *args: "ARGS", **kwargs: "KWARGS") -> "ret":
    """
    >>> annotation_syntax(1)
    3
    >>> annotation_syntax(1, 3)
    4

    >>> len(annotation_syntax.__annotations__)
    5
    >>> strip_wrapped_string(annotation_syntax.__annotations__['a'])
    'test new test'
    >>> strip_wrapped_string(annotation_syntax.__annotations__['b'])
    'other'
    >>> strip_wrapped_string(annotation_syntax.__annotations__['args'])
    'ARGS'
    >>> strip_wrapped_string(annotation_syntax.__annotations__['kwargs'])
    'KWARGS'
    >>> strip_wrapped_string(annotation_syntax.__annotations__['return'])
    'ret'
    """
    result : int = a + b

    return result


#[cython::annotation_typing(true)]
def repr_returns_str(x) -> str:
    """
    >>> repr_returns_str(123)
    '123'
    """
    return repr(x)
