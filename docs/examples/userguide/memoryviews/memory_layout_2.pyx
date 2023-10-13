from cython cimport view

# VALID
fn int[::view.indirect, ::1, :] a
fn int[::view.indirect, :, ::1] b
fn int[::view.indirect_contiguous, ::1, :] c
