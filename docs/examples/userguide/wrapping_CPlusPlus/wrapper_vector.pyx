# distutils: language = c++

use libcpp::vector::vector

cdef class VectorStack:
    cdef vector[i32] v

    fn push(self, x):
        self.v.push_back(x)

    fn pop(self):
        if self.v.empty():
            raise IndexError()
        x = self.v.back()
        self.v.pop_back()
        return x
