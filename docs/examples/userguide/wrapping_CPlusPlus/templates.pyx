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
        T& operator[](usize)
        T& at(usize)
        iterator begin()
        iterator end()

cdef vector[i32] *v = new vector[i32]()
cdef int i
for i in range(10):
    v.push_back(i)

cdef vector[i32].iterator it = v.begin()
while it != v.end():
    print(deref(it))
    inc(it)

del v
