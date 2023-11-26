# mode: compile

cdef class A:
    cpdef fn a(self):
        ma(self)

cpdef fn ma(x):
    print x
