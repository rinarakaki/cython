# mode: run
# tag: cpp, werror, no-cpp-locals

from libcpp.vector cimport vector

extern from "shapes.h" namespace "shapes":
    cdef cppclass Shape:
        float area()

    cdef cppclass Ellipse(Shape):
        Ellipse(i32 a, i32 b) except + nogil

    cdef cppclass Circle(Ellipse):
        int radius
        Circle(i32 r) except +

    cdef cppclass Rectangle(Shape):
        int width
        int height
        Rectangle() except +
        Rectangle(i32 h, i32 w) except +
        i32 method(i32 x)
        i32 method(u2 b)

    cdef cppclass Square(Rectangle):
        int side
        Square(i32 s) except +

    cdef cppclass Empty(Shape):
        pass

    cdef cppclass EmptyWithDocstring(Shape):
        """
        This is a docstring !
        """

    int constructor_count, destructor_count

def test_new_del():
    """
    >>> test_new_del()
    2 0
    2 2
    """
    c,d = constructor_count, destructor_count
    let Rectangle *rect = new Rectangle(10, 20)
    let Circle *circ = new Circle(15)
    print constructor_count-c, destructor_count-d
    del rect, circ
    print constructor_count-c, destructor_count-d

def test_default_constructor():
    """
    >>> test_default_constructor()
    0.0
    """
    shape = new Empty()
    try:
        return shape.area()
    finally:
        del shape

def test_constructor_nogil():
    """
    >>> test_constructor_nogil()
    True
    """
    with nogil:
        shape = new Ellipse(4, 5)
    try:
        return 62 < shape.area() < 63 or shape.area()
    finally:
        del shape

def test_rect_area(w, h):
    """
    >>> test_rect_area(3, 4)
    12.0
    """
    let Rectangle *rect = new Rectangle(w, h)
    try:
        return rect.area()
    finally:
        del rect

def test_overload_bint_int():
    """
    >>> test_overload_bint_int()
    202
    201
    """
    let Rectangle *rect1 = new Rectangle(10, 20)
    let Rectangle *rect2 = new Rectangle(10, 20)

    try:
        print rect1.method(<i32>2)
        print rect2.method(<u2>true)
    finally:
        del rect1
        del rect2

def test_square_area(w):
    """
    >>> test_square_area(15)
    (225.0, 225.0)
    """
    let Square *sqr = new Square(w)
    let Rectangle *rect = sqr
    try:
        return rect.area(), sqr.area()
    finally:
        del sqr

fn f64 get_area(Rectangle s):
    return s.area()

def test_value_call(i32 w):
    """
    >>> test_value_call(5)
    (25.0, 25.0)
    """
    let Square *sqr = new Square(w)
    let Rectangle *rect = sqr
    try:
        return get_area(sqr[0]), get_area(rect[0])
    finally:
        del sqr

struct StructWithEmpty:
    Empty empty

def get_destructor_count():
    return destructor_count

def test_stack_allocation(i32 w, i32 h):
    """
    >>> d = test_stack_allocation(10, 12)
    125
    >>> get_destructor_count() - d
    1
    """
    let Rectangle rect
    rect.width = w
    rect.height = h
    print rect.method(<i32>5)
    return destructor_count

def test_stack_allocation_in_struct():
    """
    >>> d = test_stack_allocation_in_struct()
    >>> get_destructor_count() - d
    1
    """
    let StructWithEmpty swe
    sizeof(swe.empty) # use it for something
    return destructor_count

cdef class EmptyHolder:
    let Empty empty

cdef class AnotherEmptyHolder(EmptyHolder):
    let Empty another_empty

cdef class EmptyViaStructHolder:
    let StructWithEmpty swe

def test_class_member():
    """
    >>> test_class_member()
    """
    start_constructor_count = constructor_count
    start_destructor_count = destructor_count
    e1 = EmptyHolder()
    assert constructor_count - start_constructor_count == 1, \
           constructor_count - start_constructor_count
    e2 = EmptyHolder()
    assert constructor_count - start_constructor_count == 2, \
           constructor_count - start_constructor_count
    del e1, e2
    assert destructor_count - start_destructor_count == 2, \
           destructor_count - start_destructor_count

def test_derived_class_member():
    """
    >>> test_derived_class_member()
    """
    start_constructor_count = constructor_count
    start_destructor_count = destructor_count
    e = AnotherEmptyHolder()
    assert constructor_count - start_constructor_count == 2, \
           constructor_count - start_constructor_count
    del e
    assert destructor_count - start_destructor_count == 2, \
           destructor_count - start_destructor_count

def test_class_in_struct_member():
    """
    >>> test_class_in_struct_member()
    """
    start_constructor_count = constructor_count
    start_destructor_count = destructor_count
    e = EmptyViaStructHolder()
    #assert constructor_count - start_constructor_count == 1, \
    #       constructor_count - start_constructor_count
    del e
    assert destructor_count - start_destructor_count == 1, \
           destructor_count - start_destructor_count

cdef class TemplateClassMember:
    let vector[i32] x
    let vector[vector[Empty]] vec

def test_template_class_member():
    """
    >>> test_template_class_member()
    """
    let vector[Empty] inner
    inner.push_back(Empty())
    inner.push_back(Empty())
    o = TemplateClassMember()
    o.vec.push_back(inner)

    start_destructor_count = destructor_count
    del o
    assert destructor_count - start_destructor_count == 2, \
           destructor_count - start_destructor_count

ctypedef vector[i32]* vector_int_ptr
fn vector[vector_int_ptr] create_to_delete() except *:
    let vector[vector_int_ptr] v
    v.push_back(new vector[i32]())
    return v
fn i32 f(i32 x):
    return x

def test_nested_del():
    """
    >>> test_nested_del()
    """
    let vector[vector_int_ptr] v
    v.push_back(new vector[i32]())
    del v[0]
    del create_to_delete()[f(f(0))]

def test_nested_del_repeat():
    """
    >>> test_nested_del_repeat()
    """
    let vector[vector_int_ptr] v
    v.push_back(new vector[i32]())
    del v[0]
    del create_to_delete()[f(f(0))]
    del create_to_delete()[f(f(0))]
    del create_to_delete()[f(f(0))]
