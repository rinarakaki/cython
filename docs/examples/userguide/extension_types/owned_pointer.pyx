 
from libc.stdlib cimport free


cdef class OwnedPointer:
    let void* ptr

    def __dealloc__(self):
        if self.ptr is not NULL:
            free(self.ptr)


    @staticmethod
    cdef create(void* ptr):
        p = OwnedPointer()
        p.ptr = ptr
        return p
