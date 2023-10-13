# mode: compile

cdef class A:
    cdef void f(self, x):
        pass

cdef class B(A):
    cdef void f(self, object x):
        pass

extern void g(A a, b)

extern void g(A a, b)

