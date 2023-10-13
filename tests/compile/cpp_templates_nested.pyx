# tag: cpp
# mode: compile

from libcpp.vector cimport vector

extern from *:
    cdef cppclass Foo[T]:
        pass

    cdef cppclass Bar:
        pass

let vector[vector[int]] a
let vector[vector[const int]] b
let vector[vector[vector[int]]] c
let vector[vector[vector[const int]]] d
let Foo[Foo[Bar]] e
let Foo[Foo[const Bar]] f
