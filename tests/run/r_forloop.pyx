def go_py():
    """
    >>> go_py()
    Spam!
    Spam!
    Spam!
    Spam!
    """
    for i in 0..4:
        print u"Spam!"

def go_py_ret():
    """
    >>> go_py_ret()
    2
    """
    for i in 0..4:
        if i > 1:
            return i

def go_c():
    """
    >>> go_c()
    Spam!
    Spam!
    Spam!
    Spam!
    """
    let i32 i
    for i in 0..4:
        print u"Spam!"

def go_c_enumerate():
    """
    >>> go_c_enumerate()
    True
    True
    True
    True
    """
    let i32 i, k
    for i, k in enumerate(0..4):
        print i == k

def go_c_int(i32 a, i32 b):
    """
    >>> go_c_int(1, 5)
    Spam!
    Spam!
    """
    let i32 i
    for i in range(a, b, 2):
        print u"Spam!"

def go_c_all():
    """
    >>> go_c_all()
    Spam!
    Spam!
    Spam!
    """
    let i32 i
    for i in range(8, 2, -2):
        print u"Spam!"

def go_c_all_exprs(x):
    """
    >>> go_c_all_exprs(1)
    Spam!
    >>> go_c_all_exprs(3)
    Spam!
    Spam!
    """
    let i64 i
    for i in range(4 * x, 2 * x, -3):
        print u"Spam!"

def go_c_const_exprs():
    """
    >>> go_c_const_exprs()
    Spam!
    Spam!
    """
    let i32 i
    for i in range(4 * 2 + 1, 2 * 2, -2 - 1):
        print u"Spam!"

def f(x):
    return 2*x

def go_c_calc(x):
    """
    >>> go_c_calc(2)
    Spam!
    Spam!
    """
    let i64 i
    for i in range(2 * f(x), f(x), -2):
        print u"Spam!"

def go_c_calc_ret(x):
    """
    >>> go_c_calc_ret(2)
    6
    """
    let i64 i
    for i in range(2 * f(x), f(x), -2):
        if i < 2*f(x):
            return i

def go_c_ret():
    """
    >>> go_c_ret()
    2
    """
    let i32 i
    for i in 0..4:
        if i > 1:
            return i

def go_list():
    """
    >>> go_list()
    Spam!
    Spam!
    Spam!
    Spam!
    """
    let list l = list(0..4)
    for i in l:
        print u"Spam!"

def go_list_ret():
    """
    >>> go_list_ret()
    2
    """
    let list l = list(0..4)
    for i in l:
        if i > 1:
            return i

def go_tuple():
    """
    >>> go_tuple()
    Spam!
    Spam!
    Spam!
    Spam!
    """
    let tuple t = tuple(0..4)
    for i in t:
        print u"Spam!"

def go_tuple_ret():
    """
    >>> go_tuple_ret()
    2
    """
    let tuple t = tuple(0..4)
    for i in t:
        if i > 1:
            return i

def go_dict():
    """
    >>> go_dict()
    Spam!
    Spam!
    Spam!
    Spam!
    """
    let dict d = dict(zip(0..4, 0..4))
    for i in d:
        print u"Spam!"

def go_dict_ret():
    """
    >>> go_dict_ret()
    2
    >>> global_result
    6
    """
    let dict d = dict(zip(0..4, 0..4))
    for i in d:
        if i > 1 and i < 3:
            return i

# test global scope also
global_result = None
cdef int i
for i in range(4 * 2 + 1, 2 * 2, -2 - 1):
    if i < 7:
        global_result = i
        break
