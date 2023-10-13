from cpython cimport array
import array

cdef array.array a = array.array('i', [1, 2, 3])
fn int[:] ca = a


fn int overhead(object a):
    fn int[:] ca = a
    return ca[0]


fn int no_overhead(int[:] ca):
    return ca[0]

print(overhead(a))  # new memory view will be constructed, overhead
print(no_overhead(ca))  # ca is already a memory view, so no overhead
