# mode: run
# tag: cpp, warnings, no-cpp-locals

use cython
use libcpp::pair::pair
use libcpp::vector::vector

extern from "cpp_template_functions_helper.h":
    fn T no_arg[T]()
    fn T one_param[T](T)
    fn pair[T, U] two_params[T, U](T, U)
    cdef cppclass A[T]:
        fn pair[T, U] method[U](T, U)
        fn U part_method[U](pair[T, U])
        fn U part_method_ref[U](&mut pair[T, U])
        fn i32 overloaded(f64 x)
        fn T overloaded(pair[T, T])
        fn U overloaded[U](vector[U])
        fn X overloaded[X](r&mut i8 s, vector[X])
    fn T nested_deduction[T](const T*)
    fn pair[T, U] pair_arg[T, U](pair[T, U] a)
    fn T* pointer_param[T](T*)
    cdef cppclass double_pair(pair[f64, f64]):
        fn double_pair(f64, f64)

def test_no_arg():
    """
    >>> test_no_arg()
    0
    """
    return no_arg[i32]()

def test_one_param(i32 x):
    """
    >>> test_one_param(3)
    (3, 3.0)
    """
    return one_param[i32](x), one_param[f64](x)

def test_two_params(i32 x, i32 y):
    """
    >>> test_two_params(1, 2)
    (1, 2.0)
    """
    return two_params[i32, f64](x, y)

def test_method(i32 x, i32 y):
    """
    >>> test_method(5, 10)
    ((5, 10.0), (5.0, 10), (5, 10), (5.0, 10))
    """
    let A[i32] a_int
    let A[f64] a_double
    return (a_int.method[float](x, y), a_double.method[i32](x, y),
        a_int.method(x, y), a_double.method(x, y))
#    return a_int.method[f64](x, y), a_double.method[i32](x, y)

def test_part_method(i32 x, i32 y):
    """
    >>> test_part_method(5, 10)
    (10.0, 10, 10.0)
    """
    let A[i32] a_int
    let pair[i32, f64] p_int = (x, y)
    let A[f64] a_double
    let pair[f64, i32] p_double = (x, y)
    return (a_int.part_method(p_int),
        a_double.part_method(p_double),
        a_double.part_method_ref(double_pair(x, y)))

def test_simple_deduction(i32 x, f64 y):
    """
    >>> test_simple_deduction(1, 2)
    (1, 2.0)
    """
    return one_param(x), one_param(y)

def test_more_deductions(i32 x, f64 y):
    """
    >>> test_more_deductions(1, 2)
    (1, 2.0)
    """
    return nested_deduction(&x), nested_deduction(&y)

def test_class_deductions(pair[long, f64] x):
    """
    >>> test_class_deductions((1, 1.5))
    (1, 1.5)
    """
    return pair_arg(x)

def test_deduce_through_pointers(i32 k):
    """
    >>> test_deduce_through_pointers(5)
    (5, 5.0)
    """
    let f64 x = k
    return pointer_param(&k)[0], pointer_param(&x)[0]

def test_inference(i32 k):
    """
    >>> test_inference(27)
    27
    """
    res = one_param(&k)
    assert cython::typeof(res) == 'i32 *', cython::typeof(res)
    return res[0]

def test_overload_GH1583():
    """
    >>> test_overload_GH1583()
    """
    let A[i32] a
    assert a.overloaded(1.5) == 1
    let pair[i32, i32] p = (2, 3)
    assert a.overloaded(p) == 2
    let vector[f64] v = [0.25, 0.125]
    assert a.overloaded(v) == 0.25
    assert a.overloaded("s", v) == 0.25
    # GH Issue #1584
    # assert a.overloaded[f64](v) == 0.25
