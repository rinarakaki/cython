cdef class A:
    fn foo(self)

cdef class B(A):
    fn foo(self, x=*)

cdef class C(B):
    cpdef fn foo(self, x=*, i32 k=*)
