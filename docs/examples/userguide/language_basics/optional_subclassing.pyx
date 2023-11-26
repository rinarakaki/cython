cdef class A:
    fn foo(self):
        print("A")

cdef class B(A):
    fn foo(self, x=None):
        print("B", x)

cdef class C(B):
    cpdef fn foo(self, x=true, i32 k=3):
        print("C", x, k)
