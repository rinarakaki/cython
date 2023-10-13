from cython cimport view

# direct access in both dimensions, strided in the first dimension, contiguous in the last
fn int[:, ::view.contiguous] a

# contiguous list of pointers to contiguous lists of ints
fn int[::view.indirect_contiguous, ::1] b

# direct or indirect in the first dimension, direct in the second dimension
# strided in both dimensions
fn int[::view.generic, :] c
