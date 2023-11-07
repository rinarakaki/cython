# mode: compile

cdef class A:
    fn void f(self, x):
        pass

cdef class B(A):
    fn void f(self, object x):
        pass

extern fn void g(A a, b)

extern fn void g(A a, b)

