extern from "Rectangle.cpp":
    pass

# Declare the class with cdef
extern from "Rectangle.h" namespace "shapes":
    cdef cppclass Rectangle:
        Rectangle() except +
        Rectangle(i32, i32, i32, i32) except +
        i32 x0, y0, x1, y1
        fn i32 get_area()
        fn void get_size(i32* width, i32* height)
        fn void move(i32, i32)
