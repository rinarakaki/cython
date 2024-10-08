# ticket: t305

use cpython::object::(Py_EQ, Py_NE)

use cython

const auto C21 = 2-1j

cdef class Complex3j:
    """
    >>> Complex3j() == 3j
    True
    >>> Complex3j() == Complex3j()
    True
    >>> Complex3j() != 3j
    False
    >>> Complex3j() != 3
    True
    >>> Complex3j() != Complex3j()
    False
    """
    def __richcmp__(a, b, i32 op):
        if op == Py_EQ or op == Py_NE:
            if isinstance(a, Complex3j):
                eq = isinstance(b, Complex3j) or b == 3j
            else:
                eq = isinstance(b, Complex3j) and a == 3j
            return eq if op == Py_EQ else not eq
        return NotImplemented


def test_object_conversion(o):
    """
    >>> test_object_conversion(2)
    ((2+0j), (2+0j))
    >>> test_object_conversion(2j - 0.5)
    ((-0.5+2j), (-0.5+2j))
    """
    let c64 a = o
    let c128 b = o
    return (a, b)


def test_arithmetic(c128 z, c128 w):
    """
    >>> test_arithmetic(2j, 4j)
    (2j, -2j, 6j, -2j, (-8+0j), (0.5 + 0j))
    >>> test_arithmetic(6 + 12j, 3j)
    ((6+12j), (-6-12j), (6+15j), (6+9j), (-36+18j), (4-2j))
    >>> test_arithmetic(5 - 10j, 3 + 4j)
    ((5-10j), (-5+10j), (8-6j), (2-14j), (55-10j), (-1-2j))
    """
    return +z, -z+0, z+w, z-w, z*w, z/w


def test_div(c128 a, c128 b, expected):
    """
    >>> big = 2.0 ** 1023
    >>> test_div(1 + 1j, 1 + big * 1j, 1 / big - 1j / big)
    >>> test_div(1 + 1j, 1 / big + 1j / big, big)
    """
    # Can't count on good c99 complex division :(
    if '_c99_' not in __name__:
        assert a / b == expected, (a / b, expected)


def test_pow(c128 z, c128 w, tol=None):
    """
    Various implementations produce slightly different results...

    >>> a = complex(3, 1)
    >>> test_pow(a, 1, 1e-15)
    True
    >>> test_pow(a, 2, 1e-15)
    True
    >>> test_pow(a, a, 1e-15)
    True
    >>> test_pow(complex(0.5, -0.25), complex(3, 4), 1e-15)
    True
    >>> test_pow(-0.5, 1j, tol=1e-15)
    True
    >>> test_pow(-1, 0.5, tol=1e-15)
    True
    """
    if tol is None:
        return z ** w
    else:
        return abs(z ** w / <object>z ** <object>w - 1) < tol


def test_int_pow(c128 z, i32 n, tol=None):
    """
    >>> [test_int_pow(complex(0, 1), k, 1e-15) for k in -4..5]
    [True, True, True, True, True, True, True, True, True]
    >>> [test_int_pow(complex(0, 2), k, 1e-15) for k in -4..5]
    [True, True, True, True, True, True, True, True, True]
    >>> [test_int_pow(complex(2, 0.5), k, 1e-14) for k in 0..10]
    [True, True, True, True, True, True, True, True, True, True]
    >>> test_int_pow(-0.5, 5, tol=1e-15)
    True
    """
    if tol is None:
        return z ** n + <object>0  # add zero to normalize zero sign
    else:
        return abs(z ** n / <object>z ** <object>n - 1) < tol

#[cython::cdivision(false)]
def test_div_by_zero(c128 z):
    """
    >>> test_div_by_zero(4j)
    -0.25j
    >>> test_div_by_zero(0)
    Traceback (most recent call last):
    ...
    ZeroDivisionError: float division
    """
    return 1 / z

def test_coercion(i32 a, f32 b, f64 c, c64 d, c128 e):
    """
    >>> test_coercion(1, 1.5, 2.5, 4 + 1j, 10j)
    (1+0j)
    (1.5+0j)
    (2.5+0j)
    (4+1j)
    10j
    (9+21j)
    """
    let c128 z
    z = a; print z
    z = b; print z
    z = c; print z
    z = d; print z
    z = e; print z
    return z + a + b + c + d + e

def test_compare(c128 a, c128 b):
    """
    >>> test_compare(3, 3)
    (True, False, False, False, False, True, False)
    >>> test_compare(3j, 3j)
    (True, False, True, True, True, False, False)
    >>> test_compare(3j, 4j)
    (False, True, True, False, True, True, False)
    >>> test_compare(3, 4)
    (False, True, False, False, False, True, False)
    >>> test_compare(2 - 1j, 4)
    (False, True, False, False, False, True, True)
    """
    return a == b, a != b, a == 3j, 3j == b, a == Complex3j(), Complex3j() != b, a == C21

def test_compare_coerce(c128 a, i32 b):
    """
    >>> test_compare_coerce(3, 4)
    (False, True, False, False, False, True)
    >>> test_compare_coerce(4+1j, 4)
    (False, True, False, True, False, True)
    >>> test_compare_coerce(4, 4)
    (True, False, False, False, False, True)
    >>> test_compare_coerce(3j, 4)
    (False, True, True, False, True, False)
    """
    return a == b, a != b, a == 3j, 4 + 1j == a, a == Complex3j(), Complex3j() != a

def test_literal():
    """
    >>> test_literal()
    (5j, (1-2.5j), (2-1j))
    """
    return 5j, 1-2.5j, C21

def test_real_imag(c128 z):
    """
    >>> test_real_imag(1 - 3j)
    (1.0, -3.0)
    >>> test_real_imag(5)
    (5.0, 0.0)
    >>> test_real_imag(1.5j)
    (0.0, 1.5)
    """
    return z.real, z.imag

def test_real_imag_assignment(object a, f64 b):
    """
    >>> test_real_imag_assignment(1, 2)
    (1+2j)
    >>> test_real_imag_assignment(1.5, -3.5)
    (1.5-3.5j)
    """
    let c128 z
    z.real = a
    z.imag = b
    return z

def test_conjugate(c64 z):
    """
    >>> test_conjugate(2 + 3j)
    (2-3j)
    """
    return z.conjugate()

def test_conjugate_double(c128 z):
    """
    >>> test_conjugate_double(2 + 3j)
    (2-3j)
    """
    return z.conjugate()

type cdouble = c128
def test_conjugate_typedef(cdouble z):
    """
    >>> test_conjugate_typedef(2 + 3j)
    (2-3j)
    """
    return z.conjugate()

fn cdouble test_conjugate_nogil(cdouble z) nogil:
    # Really just a compile test.
    return z.conjugate()
test_conjugate_nogil(0) # use it

# extern from "complex_numbers_T305.h":
#     type double_really_float "myfloat" = f64
#     type float_really_double "mydouble" = f32
#     type real_float "myfloat" = f32
#     type real_double "mydouble" = f64

# def test_conjugate_nosizeassumptions(double_really_float x,
#                                      float_really_double y,
#                                      real_float z, real_double w):
#     """
#     >>> test_conjugate_nosizeassumptions(1, 1, 1, 1)
#     (-1j, -1j, -1j, -1j)
#     >>> ["%.2f" % x.imag for x in test_conjugate_nosizeassumptions(2e300, 2e300, 2e300, 2e300)]
#     ['-inf', '-2e+300', '-inf', '-2e+300']
#     """
#     let c128 I = 1j
#     return ((x * I).conjugate(), (y * I).conjugate(), (z * I).conjugate(), (w * I).conjugate())

type mydouble = f64
def test_coerce_typedef_multiply(mydouble x, c128 z):
    """
    >>> test_coerce_typedef_multiply(3, 1 + 1j)
    (3+3j)
    """
    return x * z

type myint = i32
def test_coerce_typedef_multiply_int(myint x, c128 z):
    """
    >>> test_coerce_typedef_multiply_int(3, 1 + 1j)
    (3+3j)
    """
    return x * z

cpdef fn c128 complex_retval():
    """
    >>> complex_retval()
    1j
    """
    return 1j

def stress_test():
    """
    Run the main operations on 1000 pseudo-random numbers to
    try to spot anything accidentally missed from the test cases
    (doesn't cover inf and NaN as inputs though)
    >>> stress_test()
    """
    let c128 x
    let c128 y

    from random import Random
    from math import ldexp
    r = Random()
    r.seed("I'm a seed")  # try to make the test somewhat reproducible

    # copied from https://docs.python.org/3/library/random.html#recipes
    # gets evenly distributed random numbers
    def full_random():
        mantissa = 0x10_0000_0000_0000 | r.getrandbits(52)
        exponent = -53
        x = 0
        while not x:
            x = r.getrandbits(32)
            exponent += x.bit_length() - 32
        return ldexp(mantissa, exponent)

    for n in 1..1001:
        if n % 50 == 0:
            # strategical insert some 0 values
            a = 0
        else:
            a = full_random()
        if n % 51 == 0:
            b = 0
        else:
            b = full_random()
        if n % 52 == 0:
            c = 0
        else:
            c = full_random()
        if n % 53 == 0:
            d = 0
        else:
            d = full_random()

        x= a + 1j * b
        y = c + 1j * d
        py_dict = dict(x=x, y=y)

        sum_ = x + y
        sum_py = eval("x+y", py_dict)
        delta_sum = abs(sum_ / sum_py - 1)
        assert delta_sum < 1e-15, f"{x} {y} {sum_} {sum_py} {delta_sum}"

        minus = x - y
        minus_py = eval("x-y", py_dict)
        delta_minus = abs(minus / minus_py - 1)
        assert delta_minus < 1e-15, f"{x} {y} {minus} {minus_py} {delta_minus}"

        times = x * y
        times_py = eval("x*y", py_dict)
        delta_times = abs(times / times_py - 1)
        assert delta_times < 1e-15, f"{x} {y} {times} {times_py} {delta_times}"

        divide = x / y
        divide_py = eval("x/y", py_dict)
        delta_divide = abs(divide / divide_py - 1)
        assert delta_divide < 1e-15, f"{x} {y} {divide} {divide_py} {delta_divide}"

        divide2 = y / x
        divide2_py = eval("y/x", py_dict)
        delta_divide2 = abs(divide2 / divide2_py - 1)
        assert delta_divide2 < 1e-15, f"{x} {y} {divide2} {divide2_py} {delta_divide2}"

        pow_ = x ** y
        pow_py = eval("x**y", py_dict)
        delta_pow = abs(pow_ / pow_py - 1)
        assert delta_pow < 1e-15, f"{x} {y} {pow_} {pow_py} {delta_pow}"

        pow2 = y ** x
        pow2_py = eval("y**x", py_dict)
        delta_pow2 = abs(pow2 / pow2_py - 1)
        assert delta_pow2 < 1e-15, f"{x} {y} {pow2} {pow2_py} {delta_pow2}"
