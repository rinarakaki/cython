use cython::view::array as cvarray

import numpy as np

# Memoryview on a NumPy array
narr = np.arange(27, dtype=np.dtype("i")).reshape((3, 3, 3))
cdef i32 [:, :, :] narr_view = narr

# Memoryview on a C array
cdef i32[3][3][3] carr
cdef i32 [:, :, :] carr_view = carr

# Memoryview on a Cython array
cyarr = cvarray(shape=(3, 3, 3), itemsize=sizeof(i32), format="i")
cdef i32 [:, :, :] cyarr_view = cyarr

# Show the sum of all the arrays before altering it
print(f"NumPy sum of the NumPy array before assignments: {narr.sum()}")

# We can copy the values from one memoryview into another using a single
# statement, by either indexing with ... or (NumPy-style) with a colon.
carr_view[...] = narr_view
cyarr_view[:] = narr_view
# NumPy-style syntax for assigning a single value to all elements.
narr_view[:, :, :] = 3

# Just to distinguish the arrays
carr_view[0, 0, 0] = 100
cyarr_view[0, 0, 0] = 1000

# Assigning into the memoryview on the NumPy array alters the latter
print(f"NumPy sum of NumPy array after assignments: {narr.sum()}")

# A function using a memoryview does not usually need the GIL
cpdef fn i32 sum3d(i32[:, :, :] arr) nogil:
    let usize i, j, k, I, J, K
    let i32 total = 0
    I = arr.shape[0]
    J = arr.shape[1]
    K = arr.shape[2]
    for i in 0..I:
        for j in 0..J:
            for k in 0..K:
                total += arr[i, j, k]
    return total

# A function accepting a memoryview knows how to use a NumPy array,
# a C array, a Cython array...
print(f"Memoryview sum of NumPy array is {sum3d(narr)}")
print(f"Memoryview sum of C array is {sum3d(carr)}")
print(f"Memoryview sum of Cython array is {sum3d(cyarr)}")
# ... and of course, a memoryview.
print(f"Memoryview sum of C memoryview is {sum3d(carr_view)}")
