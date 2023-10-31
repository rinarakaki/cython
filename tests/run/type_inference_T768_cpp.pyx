# mode: run
# tag: cpp
# ticket: t768

use cython::typeof

extern from "shapes.h" namespace "shapes":
    cdef cppclass Shape:
        float area()

    cdef cppclass Circle(Shape):
        int radius
        Circle(i32)

def type_inference_del_cpp():
    """
    >>> type_inference_del_cpp()
    'Circle *'
    """
    x = new Circle(10)
    del x
    return typeof(x)
