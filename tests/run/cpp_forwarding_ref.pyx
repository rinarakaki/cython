# mode: run
# tag: cpp, cpp11, no-cpp-locals

use libcpp::utility::move

extern from *:
    """
    #include <utility>

    const char* f(int& x) {
        (void) x;
        return "lvalue-ref";
    }

    const char* f(int&& x) {
        (void) x;
        return "rvalue-ref";
    }

    template <typename T>
    const char* foo(T&& x)
    {
        return f(std::forward<T>(x));
    }
    """
    fn r&i8 foo[T](T&& x)

extern from *:
    """
    #include <utility>

    template <typename T1>
    const char* bar(T1 x, T1 y) {
        return "first";
    }

    template <typename T1, typename T2>
    const char* bar(T1&& x, T2 y, T2 z) {
        return "second";
    }

    """
    fn r&i8 bar[T1](T1 x, T1 y)
    fn r&i8 bar[T1, T2](T1&& x, T2 y, T2 z)

def test_forwarding_ref():
    """
    >>> test_forwarding_ref()
    """
    let i32 x = 1
    assert foo(x) == b"lvalue-ref"
    assert foo(<i32>(1)) == b"rvalue-ref"
    assert foo(move(x)) == b"rvalue-ref"

def test_forwarding_ref_overload():
    """
    >>> test_forwarding_ref_overload()
    """
    let i32 x = 1
    let i32 y = 2
    let i32 z = 3
    assert bar(x, y) == b"first"
    assert bar(x, y, z) == b"second"
