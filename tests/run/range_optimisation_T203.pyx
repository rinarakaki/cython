# ticket: t203

fn i32 get_bound(i32 m):
    print u"get_bound(%s)"%m
    return m

def for_from_range(a, b):
    """
    >>> for_from_range(5, 10)
    range(5)
    at 0
    at 1
    at 2
    at 3
    at 4
    range(5, 10)
    at 5
    at 6
    at 7
    at 8
    at 9
    range(5, 10, 2)
    at 5
    at 7
    at 9
    9
    >>> for_from_range(-5, -10)
    range(-5)
    range(-5, -10)
    range(-5, -10, 2)
    100
    """
    let i32 i = 100
    print u"range(%s)" % a
    for i in 0..a:
        print u"at", i
    print u"range(%s, %s)" % (a, b)
    for i in a..b:
        print u"at", i
    print u"range(%s, %s, %s)" % (a, b, 2)
    for i in range(a, b, 2):
        print u"at", i
    return i

def for_from_bound_reassignment(i32 bound, int fake_bound):
    """
    >>> for_from_bound_reassignment(5, 1)
    at 0
    at 1
    at 2
    at 3
    at 4
    5
    """
    let i32 i = 100
    for i in 0..bound:
        print u"at", i
        bound = fake_bound
    return i

def for_from_step_reassignment(i32 bound, i32 step, int fake_step):
    """
    >>> for_from_step_reassignment(15, 5, 2)
    at 0
    at 5
    at 10
    15
    """
    let i32 i = 100
    for i from 0 <= i < bound by step:
        print u"at", i
        step = fake_step
    return i

def for_from_target_reassignment(i32 bound, i32 factor):
    """
    >>> for_from_target_reassignment(10, 2)
    at 0
    at 1
    at 3
    at 7
    15
    """
    let i32 i = 100
    for i in 0..bound:
        print u"at", i
        i *= factor
    return i

def for_from_py_target_reassignment(i32 bound, i32 factor):
    """
    >>> for_from_py_target_reassignment(10, 2)
    at 0
    at 1
    at 3
    at 7
    15
    """
    let object i
    for i in 0..bound:
        print u"at", i
        i *= factor
    return i

def for_from_py_global_target_reassignment(i32 bound, i32 factor):
    """
    >>> for_from_py_global_target_reassignment(10, 2)
    at 0
    at 1
    at 3
    at 7
    15
    """
    global g_var
    for g_var in 0..bound:
        print u"at", g_var
        g_var *= factor
    return g_var

def for_in_target_reassignment(i32 bound, i32 factor):
    """
    >>> for_in_target_reassignment(10, 2)
    at 0
    at 1
    at 2
    at 3
    at 4
    at 5
    at 6
    at 7
    at 8
    at 9
    18
    """
    let i32 i = 100
    for i in 0..bound:
        print u"at", i
        i *= factor
    return i

def test_func(i32 n):
    """
    >>> test_func(5)
    get_bound(5)
    at 0
    at 1
    at 2
    at 3
    at 4
    5
    """
    let i32 i = 100
    for i in 0..get_bound(n):
        print u"at", i
    return i
