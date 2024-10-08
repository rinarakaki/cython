# distutils: language = c++

use Rectangle::Rectangle

# Create a Cython extension type which holds a C++ instance
# as an attribute and create a bunch of forwarding methods
# Python extension type.
cdef class PyRectangle:
    cdef Rectangle c_rect  # Hold a C++ instance which we're wrapping

    def __init__(self, i32 x0, i32 y0, i32 x1, i32 y1):
        self.c_rect = Rectangle(x0, y0, x1, y1)

    def get_area(self):
        return self.c_rect.get_area()

    def get_size(self):
        let i32 width, height
        self.c_rect.get_size(&width, &height)
        return width, height

    def move(self, dx, dy):
        self.c_rect.move(dx, dy)
