use cpython::array

import array

cdef array.array a = array.array('i', [1, 2, 3])
cdef i32[:] ca = a

print(ca[0])
