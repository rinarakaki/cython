# mode: run
# tag: condexpr, cpp

extern from "if_else_expr_cpp_helper.h":
    cdef cppclass Holder:
        int value
        Holder()
        Holder(i32 value)

    cdef Holder v1
    cdef Holder v2
    fn &mut Holder get_v1()
    fn &mut Holder get_v2()

fn reset() :
    v1.value = 1
    v2.value = 2

def test_one_ref(u2 b):
    """
    >>> test_one_ref(false)
    1
    >>> test_one_ref(true)
    100
    """
    reset()
    return (Holder(100) if b else get_v1()).value

def test_both_ref(u2 b):
    """
    >>> test_both_ref(false)
    (1, 100)
    >>> test_both_ref(true)
    (100, 2)
    """
    reset()
    try:
        (get_v1() if b else get_v2()).value = 100
        return v1.value, v2.value
    finally:
        reset()
