cdef class Base:
    cpdef fn str noargs(self)
    cpdef fn str int_arg(self, i32 i)
    cpdef fn str _class(tp)

cdef class Derived(Base):
    cpdef fn str noargs(self)
    cpdef fn str int_arg(self, i32 i)
    cpdef fn str _class(tp)

cdef class DerivedDerived(Derived):
    cpdef fn str noargs(self)
    cpdef fn str int_arg(self, i32 i)
    cpdef fn str _class(tp)

cdef class Derived2(Base):
    cpdef fn str noargs(self)
    cpdef fn str int_arg(self, i32 i)
    cpdef fn str _class(tp)
