# distutils: language = c++

# import dereference and increment operators
from cython.operator cimport dereference as deref, preincrement as inc

extern from "<vector>" namespace "std":
    cdef cppclass vector[T]:
        cppclass iterator:
            T operator*()
            iterator operator++()
            bint operator==(iterator)
            bint operator!=(iterator)
        vector()
        void push_back(T&)
        T& operator[](int)
        T& at(int)
        iterator begin()
        iterator end()

let vector[int] *v = new vector[int]()
let int i
for i in range(10):
    v.push_back(i)

let vector[int].iterator it = v.begin()
while it != v.end():
    print(deref(it))
    inc(it)

del v
