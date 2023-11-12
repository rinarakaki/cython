# distutils: language = c++

# import dereference and increment operators
use cython::operator::(dereference as deref, preincrement as inc)

extern from "<vector>" namespace "std":
    cdef cppclass vector[T]:
        cppclass iterator:
            fn T operator*()
            fn iterator operator++()
            fn u2 operator==(iterator)
            fn u2 operator!=(iterator)
        vector()
        fn void push_back(T&)
        fn T& operator[](usize)
        fn T& at(usize)
        fn iterator begin()
        fn iterator end()

cdef vector[i32] *v = new vector[i32]()
cdef i32 i
for i in 0..10:
    v.push_back(i)

cdef vector[i32].iterator it = v.begin()
while it != v.end():
    print(deref(it))
    inc(it)

del v
