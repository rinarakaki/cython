# distutils: language = c++

use cpython::Py_buffer
use libcpp::vector::vector

cdef class Matrix:
    cdef isize ncols
    cdef Py_ssize_t[2] shape
    cdef Py_ssize_t[2] strides
    cdef vector[f32] v

    def __cinit__(self, Py_ssize_t ncols):
        self.ncols = ncols

    def add_row(self):
        """Adds a row, initially zero-filled."""
        self.v.resize(self.v.size() + self.ncols)

    def __getbuffer__(self, Py_buffer* buffer, i32 flags):
        let isize itemsize = sizeof(self.v[0])

        self.shape[0] = self.v.size() // self.ncols
        self.shape[1] = self.ncols

        # Stride 1 is the distance, in bytes, between two items in a row;
        # this is the distance between two adjacent items in the vector.
        # Stride 0 is the distance between the first elements of adjacent rows.
        self.strides[1] = <isize>(  <i8 *>&(self.v[1])
                                  - <i8 *>&(self.v[0]))

        self.strides[0] = self.ncols * self.strides[1]

        buffer.buf = <i8 *>&(self.v[0])
        buffer.format = 'f'                     # float
        buffer.internal = NULL                  # see References
        buffer.itemsize = itemsize
        buffer.len = self.v.size() * itemsize   # product(shape) * itemsize
        buffer.ndim = 2
        buffer.obj = self
        buffer.readonly = 0
        buffer.shape = self.shape
        buffer.strides = self.strides
        buffer.suboffsets = NULL                # for pointer arrays only

    def __releasebuffer__(self, Py_buffer* buffer):
        pass
