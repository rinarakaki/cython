# mode: run
# tag: closures
# ticket: t82
# preparse: id
# preparse: def_to_cdef

use cython

def add_n(i32 n):
    """
    >>> f = add_n(3)
    >>> f(2)
    5

    >>> f = add_n(1000000)
    >>> f(1000000), f(-1000000)
    (2000000, 0)
    """
    def f(i32 x):
        return x + n
    return f

def a(i32 x):
    """
    >>> a(5)()
    8
    """
    def b():
        def c():
            return 3 + x
        return c()
    return b

def local_x(i32 arg_x):
    """
    >>> local_x(1)(2)(4)
    4 2 1
    15
    """
    let auto local_x = arg_x
    def y(arg_y):
        y = arg_y
        def z(i64 arg_z):
            let auto z = arg_z
            print z, y, local_x
            return 8 + z + y + local_x
        return z
    return y

def x(i32 x):
    """
    >>> x(1)(2)(4)
    15
    """
    def y(y):
        def z(i64 z):
            return 8 + z + y + x
        return z
    return y

def x2(i32 x2):
    """
    >>> x2(1)(2)(4)
    4 2 1
    15
    """
    def y2(y2):
        def z2(i64 z2):
            print z2, y2, x2
            return 8 + z2 + y2 + x2
        return z2
    return y2

def inner_override(a, b):
    """
    >>> inner_override(2, 4)()
    5
    """
    def f():
        a = 1
        return a + b
    return f

def reassign(x):
    """
    >>> reassign(4)(2)
    3
    """
    def f(a):
        return a + x
    x = 1
    return f

def reassign_int(x):
    """
    >>> reassign_int(4)(2)
    3
    """
    def f(i32 a):
        return a + x
    x = 1
    return f

def reassign_int_int(i32 x):
    """
    >>> reassign_int_int(4)(2)
    3
    """
    def f(i32 a):
        return a + x
    x = 1
    return f

def cy_twofuncs(x):
    """
    >>> def py_twofuncs(x):
    ...    def f(a):
    ...        return g(x) + a
    ...    def g(b):
    ...        return x + b
    ...    return f

    >>> py_twofuncs(1)(2) == cy_twofuncs(1)(2)
    True
    >>> py_twofuncs(3)(5) == cy_twofuncs(3)(5)
    True
    """
    def f(a):
        return g(x) + a
    def g(b):
        return x + b
    return f

def switch_funcs(a, b, i32 ix):
    """
    >>> switch_funcs([1, 2, 3], [4, 5, 6], 0)([10])
    [1, 2, 3, 10]
    >>> switch_funcs([1, 2, 3], [4, 5, 6], 1)([10])
    [4, 5, 6, 10]
    >>> switch_funcs([1, 2, 3], [4, 5, 6], 2) is None
    True
    """
    def f(x):
        return a + x
    def g(x):
        return b + x
    if ix == 0:
        return f
    elif ix == 1:
        return g
    else:
        return None

def ignore_func(x):
    def f():
        return x
    return None

def call_ignore_func():
    """
    >>> call_ignore_func()
    """
    ignore_func((1, 2, 3))

def more_inner_funcs(x):
    """
    >>> inner_funcs = more_inner_funcs(1)(2, 4, 8)
    >>> inner_funcs[0](16), inner_funcs[1](32), inner_funcs[2](64)
    (19, 37, 73)
    """
    # called with x==1
    def f(a):
        def g(b):
            # called with 16
            return a + b + x
        return g
    def g(b):
        def f(a):
            # called with 32
            return a + b + x
        return f
    def h(b):
        def f(a):
            # called with 64
            return a + b + x
        return f
    def resolve(a_f, b_g, b_h):
        # called with (2, 4, 8)
        return f(a_f), g(b_g), h(b_h)
    return resolve

@cython::test_assert_path_exists("//DefNode//DefNode//DefNode//DefNode",
                                "//DefNode[@needs_outer_scope = false]",  # deep_inner()
                                "//DefNode//DefNode//DefNode//DefNode[@needs_closure = false]",  # h()
                                )
@cython::test_fail_if_path_exists("//DefNode//DefNode[@needs_outer_scope = false]")
def deep_inner():
    """
    >>> deep_inner()()
    2
    """
    let i32 x = 1
    def f():
        def g():
            def h():
                return x+1
            return h
        return g()
    return f()

@cython::test_assert_path_exists("//DefNode//DefNode//DefNode",
                                "//DefNode//DefNode//DefNode[@needs_outer_scope = false]",  # a()
                                "//DefNode//DefNode//DefNode[@needs_closure = false]",  # a(), g(), h()
                                )
@cython::test_fail_if_path_exists("//DefNode//DefNode//DefNode[@needs_closure = true]") # a(), g(), h()
def deep_inner_sibling():
    """
    >>> deep_inner_sibling()()
    2
    """
    let i32 x = 1
    def f():
        def a():
            return 1
        def g():
            return x+a()
        def h():
            return g()
        return h
    return f()
