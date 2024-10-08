# ticket: t254

def double_target(a, b):
    """
    >>> double_target(0, 4)
    at 0.0
    at 1.0
    at 2.0
    at 3.0
    4.0
    """
    let f64 x
    for x in a..b:
        print u"at", x
    return x

def double_step(a, b, dx):
    """
    >>> double_step(0, 2, 0.5)
    at 0.0
    at 0.5
    at 1.0
    at 1.5
    2.0
    """
    let f64 x
    for x from a <= x < b by dx:
        print u"at", x
    return x

def double_step_typed(a, b, f64 dx):
    """
    >>> double_step_typed(0, 2, 0.5)
    at 0.0
    at 0.5
    at 1.0
    at 1.5
    2.0
    """
    let f64 x
    for x from a <= x < b by dx:
        print u"at", x
    return x

def double_step_py_target(a, b, f64 dx):
    """
    >>> double_step_py_target(0, 2, 0.5)
    at 0.0
    at 0.5
    at 1.0
    at 1.5
    2.0
    """
    let object x
    for x from a <= x < b by dx:
        print u"at", x
    return x

def int_step_py_target(a, b, i32 dx):
    """
    >>> int_step_py_target(0, 2, 1)
    at 0
    at 1
    2
    """
    let object x
    for x from a <= x < b by dx:
        print u"at", x
    return x
