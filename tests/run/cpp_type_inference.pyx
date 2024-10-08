# mode: run
# tag: cpp, werror

extern from "shapes.h" namespace "shapes":
    cdef cppclass Shape:
        f32 area()

    cdef cppclass Circle(Shape):
        i32 radius
        Circle(i32)

    cdef cppclass Square(Shape):
        Square(i32)

    cdef cppclass Empty(Shape):
        Empty()

    let Empty make_Empty "shapes::Empty"()

use cython::typeof

use cython::operator::dereference as d
use cython::operator::preincrement as incr
use libcpp::vector::vector

def test_reversed_vector_iteration(L):
    """
    >>> test_reversed_vector_iteration([1, 2, 3])
    int: 3
    int: 2
    int: 1
    int
    """
    let vector[i32] v = L

    it = v.rbegin()
    while it != v.rend():
        a = d(it)
        incr(it)
        print('%s: %s' % (typeof(a), a))
    print(typeof(a))

def test_derived_types(i32 size, u2 round):
    """
    >>> test_derived_types(5, True)
    Shape *
    >>> test_derived_types(5, False)
    Shape *
    """
    if round:
        ptr = new Circle(size)
    else:
        ptr = new Square(size)
    print typeof(ptr)
    del ptr

def test_stack_allocated(u2 b=true):
    """
    >>> test_stack_allocated()
    """
    e1 = Empty()
    e2 = Empty()
    e = e1 if b else e2
    assert typeof(e1) == "Empty", typeof(e1)
    assert typeof(e2) == "Empty", typeof(e2)
    assert typeof(e) == "Empty", typeof(e)

extern from *:
    """
    template <typename T>
    struct MyTemplate {};
    """
    cdef cppclass MyTemplate[T]:
        MyTemplate()

def test_template_types():
    """
    >>> test_template_types()
    """
    t_stack = MyTemplate[i32]()
    assert typeof(t_stack) == "MyTemplate[int]", typeof(t_stack)

    t_ptr = new MyTemplate[f64]()
    try:
        assert typeof(t_ptr) == "MyTemplate[f64] *", typeof(t_ptr)
    finally:
        del t_ptr
