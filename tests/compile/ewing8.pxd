struct Foo
cdef class Blarg

type FooType = Foo
type BlargType = Blarg

struct Foo:
    FooType *f

cdef class Blarg:
    cdef FooType *f
    cdef BlargType b
