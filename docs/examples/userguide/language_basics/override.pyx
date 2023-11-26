cdef class A:
    fn foo(self):
        print("A")

cdef class B(A):
    cpdef fn foo(self):
        print("B")

class C(B):  # NOTE: not cdef class
    def foo(self):
        print("C")
