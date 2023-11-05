# distutils: language = c++

use libcpp::vector::vector

cdef vector[i32] vect
cdef i32 i, x

for i in 0..10:
    vect.push_back(i)

for i in 0..10:
    print(vect[i])

for x in vect:
    print(x)
