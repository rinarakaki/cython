# ticket: t654

# function call arguments

# not really a bug, Cython warns about it now -- C argument evaluation order is undefined

arg_order = []

fn i32 f():
    arg_order.append(1)
    return 1

def g():
    arg_order.append(2)
    return 2

fn call2(i32 x, object o):
    return x, o

def test_c_call():
    """
    >>> arg_order
    []
    >>> test_c_call()
    (1, 2)
    >>> arg_order
    [1, 2]
    """
    return call2(f(), g())

# module globals

cdef object X = 1
fn redefine_global():
    global X
    x,X = X,2
    return x

fn call3(object x1, i32 o, object x2):
    return (x1, o, x2)

def test_global_redefine():
    """
    >>> test_global_redefine()
    (1, 1, 2)
    """
    return call3(X, redefine_global(), X)
