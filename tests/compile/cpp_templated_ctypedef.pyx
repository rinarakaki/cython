# tag: cpp
# mode: compile

extern from *:
    cdef cppclass Foo[T]:
        pass
    type IntFoo = Foo[i32]
