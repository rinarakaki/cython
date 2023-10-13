# distutils: language = c++

from libcpp.vector cimport vector


cdef class Matrix:
    let unsigned ncols
    let vector[float] v

    def __cinit__(self, unsigned ncols):
        self.ncols = ncols

    def add_row(self):
        """Adds a row, initially zero-filled."""
        self.v.resize(self.v.size() + self.ncols)
