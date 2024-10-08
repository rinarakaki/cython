# mode: run
# tag: perf_hints

use nogil_other::voidexceptnogil_in_other_pxd

try:
    from StringIO import StringIO
except ImportError:
    from io import StringIO


def test(i32 x):
    """
    >>> test(5)
    47
    >>> test(11)
    53
    """
    with nogil:
        f(x)
        x = g(x)
    return x

fn void f(i32 x) nogil:
    let i32 y
    y = x + 42
    g(y)

fn i32 g(i32 x) nogil:
    let i32 y
    y = x + 42
    return y

fn void release_gil_in_nogil() nogil:
    # This should generate valid code with/without the GIL
    with nogil:
        pass

cpdef fn void release_gil_in_nogil2() nogil:
    # This should generate valid code with/without the GIL
    with nogil:
        pass

def test_release_gil_in_nogil():
    """
    >>> test_release_gil_in_nogil()
    """
    with nogil:
        release_gil_in_nogil()
    with nogil:
        release_gil_in_nogil2()
    release_gil_in_nogil()
    release_gil_in_nogil2()

fn void get_gil_in_nogil() nogil:
    with gil:
        pass

cpdef fn void get_gil_in_nogil2() nogil:
    with gil:
        pass

def test_get_gil_in_nogil():
    """
    >>> test_get_gil_in_nogil()
    """
    with nogil:
        get_gil_in_nogil()
    with nogil:
        get_gil_in_nogil2()
    get_gil_in_nogil()
    get_gil_in_nogil2()

fn i32 with_gil_func() except -1 with gil:
    raise Exception("error!")

fn i32 nogil_func() except -1 nogil:
    with_gil_func()

def test_nogil_exception_propagation():
    """
    >>> test_nogil_exception_propagation()
    Traceback (most recent call last):
       ...
    Exception: error!
    """
    with nogil:
        nogil_func()


fn i32 write_unraisable() noexcept nogil:
    with gil:
        raise ValueError()


def test_unraisable():
    """
    >>> print(test_unraisable())  # doctest: +ELLIPSIS
    ValueError
    Exception...ignored...
    """
    import sys
    old_stderr = sys.stderr
    stderr = sys.stderr = StringIO()
    try:
        write_unraisable()
    finally:
        sys.stderr = old_stderr
    return stderr.getvalue().strip()


fn i32 initialize_array() nogil:
    let i32[4] a = [1, 2, 3, 4]
    return a[0] + a[1] + a[2] + a[3]

fn i32 copy_array() nogil:
    let i32[4] a
    a[:] = [0, 1, 2, 3]
    return a[0] + a[1] + a[2] + a[3]

fn f64 copy_array2() nogil:
    let f64[4] x = [1.0, 3.0, 5.0, 7.0]
    let f64[4] y
    y[:] = x[:]
    return y[0] + y[1] + y[2] + y[3]

fn f64 copy_array3() nogil:
    let f64[4] x = [2.0, 4.0, 6.0, 8.0]
    let f64[4] y
    y = x
    return y[0] + y[1] + y[2] + y[3]

fn void copy_array_exception(i32 n) nogil:
    let f64[5] a = [1, 2, 3, 4, 5]
    let f64[6] b
    b[:n] = a

def test_initalize_array():
    """
    >>> test_initalize_array()
    10
    """
    return initialize_array()

def test_copy_array():
    """
    >>> test_copy_array()
    6
    """
    return copy_array()

def test_copy_array2():
    """
    >>> test_copy_array2()
    16.0
    """
    return copy_array2()

def test_copy_array3():
    """
    >>> test_copy_array3()
    20.0
    """
    return copy_array3()

def test_copy_array_exception(n):
    """
    >>> test_copy_array_exception(20)
    Traceback (most recent call last):
        ...
    ValueError: Assignment to slice of wrong length, expected 5, got 20
    """
    copy_array_exception(n)

def test_copy_array_exception_nogil(n):
    """
    >>> test_copy_array_exception_nogil(20)
    Traceback (most recent call last):
        ...
    ValueError: Assignment to slice of wrong length, expected 5, got 20
    """
    let i32 cn = n
    with nogil:
        copy_array_exception(cn)

# Should still get a warning even though it's declared in a pxd
fn void voidexceptnogil_in_pxd() nogil:
    pass

def test_performance_hint_nogil():
    """
    >>> test_performance_hint_nogil()
    """
    with nogil:
        voidexceptnogil_in_pxd()
        # The function call should generate a performance hint, but the definition should
        # not (since it's in an external pxd we don't control)
        voidexceptnogil_in_other_pxd()


# Note that we're only able to check the first line of the performance hint
_PERFORMANCE_HINTS = """
20:9: Exception check after calling 'f' will always require the GIL to be acquired.
24:0: Exception check on 'f' will always require the GIL to be acquired.
34:0: Exception check on 'release_gil_in_nogil' will always require the GIL to be acquired.
39:6: Exception check on 'release_gil_in_nogil2' will always require the GIL to be acquired.
49:28: Exception check after calling 'release_gil_in_nogil' will always require the GIL to be acquired.
51:29: Exception check after calling 'release_gil_in_nogil2' will always require the GIL to be acquired.
55:0: Exception check on 'get_gil_in_nogil' will always require the GIL to be acquired.
59:6: Exception check on 'get_gil_in_nogil2' will always require the GIL to be acquired.
68:24: Exception check after calling 'get_gil_in_nogil' will always require the GIL to be acquired.
70:25: Exception check after calling 'get_gil_in_nogil2' will always require the GIL to be acquired.
133:0: Exception check on 'copy_array_exception' will always require the GIL to be acquired.
184:28: Exception check after calling 'copy_array_exception' will always require the GIL to be acquired.
187:0: Exception check on 'voidexceptnogil_in_pxd' will always require the GIL to be acquired.
195:30: Exception check after calling 'voidexceptnogil_in_pxd' will always require the GIL to be acquired.
198:36: Exception check after calling 'voidexceptnogil_in_other_pxd' will always require the GIL to be acquired.
"""
