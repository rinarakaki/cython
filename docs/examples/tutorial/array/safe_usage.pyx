from cpython cimport array
import array
cdef array.array a = array.array('i', [1, 2, 3])
fn int[:] ca = a

print(ca[0])
