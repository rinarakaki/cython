# mode: run
# tag: cpp, werror, cpp20

use libcpp::cmath::lerp

def test_lerp(f64 a, f64 b, f64 t):
    """ Test C++20 std::lerp function
    >>> test_lerp(1.0, 2.0, 0.5)
    1.5
    >>> test_lerp(1.0, 4.0, 0.5)
    2.5
    """
    return lerp(a, b, t)
