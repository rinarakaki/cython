# tag: cpp
# mode: compile

extern from *:
    cdef cppclass Foo[T]:
        pass
    ctypedef Foo[i32] IntFoo
