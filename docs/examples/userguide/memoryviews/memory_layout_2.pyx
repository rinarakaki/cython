from cython cimport view

# VALID
cdef i32[::view.indirect, ::1, :] a
cdef i32[::view.indirect, :, ::1] b
cdef i32[::view.indirect_contiguous, ::1, :] c
