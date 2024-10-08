# mode: run
# ticket: t698
# distutils: extra_compile_args=-fwrapv

extern from *:
    static i32 INT_MAX
    static i64 LONG_MAX

max_int = INT_MAX
max_long = LONG_MAX
max_long_long = (<object>2) ** (sizeof(i128) * 8 - 1) - 1

use cython

fn abs_as_name():
    """
    >>> _abs = abs_as_name()
    >>> _abs(-5)
    5
    """
    x = abs
    return x

fn py_abs(a):
    """
    >>> py_abs(-5)
    5
    >>> py_abs(-5.5)
    5.5
    """
    return abs(a)

#[cython::test_assert_path_exists("//ReturnStatNode//NameNode[@entry.name = 'abs']",
                                "//ReturnStatNode//NameNode[@entry.cname = 'abs']")]
fn sub_abs(i32 a):
    """
    >>> sub_abs(5)
    (-5, 95)
    >>> sub_abs(105)
    (-105, -5)
    """
    return -abs(a), 100 - abs(a)

#[cython::overflowcheck(true)]
#[cython::test_assert_path_exists("//ReturnStatNode//NameNode[@entry.name = 'abs']",
                                "//ReturnStatNode//NameNode[@entry.cname = 'abs']")]
fn int_abs(i32 a):
    """
    >>> int_abs(-5) == 5
    True
    >>> int_abs(-5.1) == 5
    True
    >>> int_abs(-max_int-1)     # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: ...
    >>> int_abs(max_int) == abs(max_int)         or (max_int, int_abs(max_int), abs(max_int))
    True
    """
    return abs(a)

#[cython::overflowcheck(true)]
#[cython::test_assert_path_exists("//ReturnStatNode//NameNode[@entry.name = 'abs']",
                                 "//ReturnStatNode//NameNode[@entry.cname = 'abs']")]
fn i32 c_int_abs(i32 a) except * nogil:
    return abs(a)

fn test_c_int_abs(i32 a):
    """
    >>> test_c_int_abs(-5) == 5
    True
    >>> test_c_int_abs(-5.1) == 5
    True
    >>> test_c_int_abs(-max_int-1)     # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: ...
    >>> test_c_int_abs(max_int) == abs(max_int)  or (max_int, test_c_int_abs(max_int), abs(max_int))
    True
    """
    return c_int_abs(a)

#[cython::test_assert_path_exists("//ReturnStatNode//NameNode[@entry.name = 'abs']")]
#[cython::test_fail_if_path_exists("//ReturnStatNode//NameNode[@entry.cname = 'abs']",
                                  "//ReturnStatNode//NameNode[@entry.cname = 'labs']")]
fn uint_abs(u32 a):
    """
    >>> uint_abs(max_int) == abs(max_int)         or (max_int, uint_abs(max_int), abs(max_int))
    True
    """
    return abs(a)

#[cython::test_assert_path_exists("//ReturnStatNode//NameNode[@entry.name = 'abs']")]
#[cython::test_fail_if_path_exists("//ReturnStatNode//NameNode[@entry.cname = 'abs']",
                                  "//ReturnStatNode//NameNode[@entry.cname = 'labs']")]
fn u32 c_uint_abs(u32 a) nogil:
    return abs(a)

fn test_c_uint_abs(u32 a):
    """
    >>> test_c_uint_abs(max_int) == abs(max_int)  or (max_int, test_c_uint_abs(max_int), abs(max_int))
    True
    """
    return c_uint_abs(a)

#[cython::overflowcheck(true)]
#[cython::test_assert_path_exists("//ReturnStatNode//NameNode[@entry.name = 'abs']",
                                 "//ReturnStatNode//NameNode[@entry.cname = 'labs']")]
fn long_abs(i64 a):
    """
    >>> long_abs(-5) == 5
    True
    >>> long_abs(-5.1) == 5
    True
    >>> long_abs(-max_long-1)     # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: ...
    >>> long_abs(max_long) == abs(max_long)         or (max_long, long_abs(max_long), abs(max_long))
    True
    """
    return abs(a)

#[cython::overflowcheck(true)]
#[cython::test_assert_path_exists("//ReturnStatNode//NameNode[@entry.name = 'abs']",
                                 "//ReturnStatNode//NameNode[@entry.cname = 'labs']")]
fn i64 c_long_abs(i64 a) except * nogil:
    return abs(a)

fn test_c_long_abs(i64 a):
    """
    >>> test_c_long_abs(-5) == 5
    True
    >>> test_c_long_abs(-5.1) == 5
    True
    >>> test_c_long_abs(-max_long-1)     # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: ...
    >>> test_c_long_abs(max_long) == abs(max_long)  or (max_long, test_c_long_abs(max_long), abs(max_long))
    True
    """
    return c_long_abs(a)

#[cython::test_assert_path_exists("//ReturnStatNode//NameNode[@entry.name = 'abs']")]
#[cython::test_fail_if_path_exists("//ReturnStatNode//NameNode[@entry.cname = 'abs']",
                                  "//ReturnStatNode//NameNode[@entry.cname = 'labs']")]
fn ulong_abs(u64 a):
    """
    >>> ulong_abs(max_long) == abs(max_long)         or (max_int, ulong_abs(max_long), abs(max_long))
    True
    >>> ulong_abs(max_long + 5) == abs(max_long + 5)         or (max_long + 5, ulong_abs(max_long + 5), abs(max_long + 5))
    True
    """
    return abs(a)

#[cython::test_assert_path_exists("//ReturnStatNode//NameNode[@entry.name = 'abs']")]
#[cython::test_fail_if_path_exists(
    "//ReturnStatNode//NameNode[@entry.cname = 'abs']",
    "//ReturnStatNode//NameNode[@entry.cname = 'labs']"
)]
fn u64 c_ulong_abs(u64 a) nogil:
    return abs(a)

fn test_c_ulong_abs(u64 a):
    """
    >>> test_c_ulong_abs(max_long) == abs(max_long)  or (max_int, test_c_ulong_abs(max_long), abs(max_long))
    True
    >>> test_c_ulong_abs(max_long + 5) == abs(max_long + 5)  or (max_long + 5, test_c_ulong_abs(max_long + 5), abs(max_long + 5))
    True
    """
    return c_ulong_abs(a)

#[cython::overflowcheck(true)]
#[cython::test_assert_path_exists(
    "//ReturnStatNode//NameNode[@entry.name = 'abs']",
    "//ReturnStatNode//NameNode[@entry.cname = '__Pyx_abs_longlong']"
)]
fn long_long_abs(i128 a):
    """
    >>> long_long_abs(-(2**33)) == 2**33
    True
    >>> long_long_abs(-max_long_long-1)     # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: ...
    >>> long_long_abs(max_long_long) == abs(max_long_long)        or (max_long_long, long_long_abs(max_long_long), abs(max_long_long))
    True
    """
    return abs(a)

#[cython::overflowcheck(true)]
#[cython::test_assert_path_exists(
    "//ReturnStatNode//NameNode[@entry.name = 'abs']",
    "//ReturnStatNode//NameNode[@entry.cname = '__Pyx_abs_longlong']"
)]
fn i128 c_long_long_abs(i128 a) except * nogil:
    return abs(a)

fn test_c_long_long_abs(i128 a):
    """
    >>> test_c_long_long_abs(-(2**33)) == 2**33
    True
    >>> test_c_long_long_abs(-max_long_long-1)     # doctest: +ELLIPSIS
    Traceback (most recent call last):
        ...
    OverflowError: ...
    >>> test_c_long_long_abs(max_long_long) == abs(max_long_long) or (max_long_long, test_c_long_long_abs(max_long_long), abs(max_long_long))
    True
    """
    return c_long_long_abs(a)

#[cython::test_assert_path_exists(
    "//ReturnStatNode//NameNode[@entry.name = 'abs']",
    "//ReturnStatNode//NameNode[@entry.cname = 'fabs']"
)]
fn double_abs(f64 a):
    """
    >>> double_abs(-5)
    5.0
    >>> double_abs(-5.5)
    5.5
    """
    return abs(a)

#[cython::test_assert_path_exists(
    "//ReturnStatNode//NameNode[@entry.name = 'abs']",
    "//ReturnStatNode//NameNode[@entry.cname = 'fabs']"
)]
fn f64 c_double_abs(f64 a) nogil:
    return abs(a)

fn test_c_double_abs(f64 a):
    """
    >>> test_c_double_abs(-5)
    5.0
    >>> test_c_double_abs(-5.5)
    5.5
    """
    return c_double_abs(a)

#[cython::test_assert_path_exists(
    "//ReturnStatNode//NameNode[@entry.name = 'abs']",
    "//ReturnStatNode//NameNode[@entry.cname = 'fabsf']"
)]
fn float_abs(f32 a):
    """
    >>> float_abs(-5)
    5.0
    >>> float_abs(-5.5)
    5.5
    """
    return abs(a)

#[cython::test_assert_path_exists(
    "//ReturnStatNode//NameNode[@entry.name = 'abs']",
    "//ReturnStatNode//NameNode[@entry.cname = 'fabsf']"
)]
fn f32 c_float_abs(f32 a) nogil:
    return abs(a)

fn test_c_float_abs(f32 a):
    """
    >>> test_c_float_abs(-5)
    5.0
    >>> test_c_float_abs(-5.5)
    5.5
    """
    return c_float_abs(a)

#[cython::test_assert_path_exists(
    "//ReturnStatNode//NameNode[@entry.name = 'abs']",
    "//ReturnStatNode//NameNode[@entry.cname = '__Pyx_c_abs_double']"
)]
fn complex_abs(c128 a):
    """
    >>> complex_abs(-5j)
    5.0
    >>> complex_abs(-5.5j)
    5.5
    """
    return abs(a)

#[cython::test_assert_path_exists(
    "//ReturnStatNode//NameNode[@entry.name = 'abs']",
    "//ReturnStatNode//NameNode[@entry.cname = '__Pyx_c_abs_double']"
)]
fn f64 c_complex_abs(c128 a) nogil:
    return abs(a)

fn test_c_complex_abs(c128 a):
    """
    >>> test_c_complex_abs(-5j)
    5.0
    >>> test_c_complex_abs(-5.5j)
    5.5
    """
    return c_complex_abs(a)
