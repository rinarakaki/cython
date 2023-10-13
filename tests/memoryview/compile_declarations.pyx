# mode: compile

cimport cython
# from cython.view cimport contig as foo, full as bar #, follow
from cython cimport view
from cython.view cimport (generic, strided, indirect,
                          contiguous, indirect_contiguous)

fn char[:] one_dim
fn char[:,:,:] three_dim
fn unsigned int[::1, :] view1
fn unsigned int[:, ::1] view2
fn long long[::1, :, :, :] fort_contig
fn unsigned long[:, :, :, ::1] c_contig
fn unsigned short int[::1] c_and_fort
fn unsigned long[:, :, :, ::0x0001] c_contig0

fn int[::generic, ::generic] a1
fn int[::strided, ::generic] a2
fn int[::indirect, ::generic] a3
fn int[::generic, ::strided] a4
fn int[::strided, ::strided] a5
fn int[::indirect, ::strided] a6
fn int[::generic, ::indirect] a7
fn int[::strided, ::indirect] a8
fn int[::indirect, ::indirect] a9

fn int[::generic, ::contiguous] a13
fn int[::strided, ::contiguous] a14
fn int[::indirect, ::contiguous] a15
fn int[::generic, ::indirect_contiguous] a16
fn int[::strided, ::indirect_contiguous] a17
fn int[::indirect, ::indirect_contiguous] a18

fn int[::generic, ::] a19
fn int[::strided, :] a20
fn int[::indirect, :] a21
fn int[::contiguous, :] a23
fn int[::indirect_contiguous, :] a24

fn int[::indirect_contiguous, ::1] a25
fn int[::indirect_contiguous, ::1, :] a26
fn int[::indirect_contiguous, :, ::1] a27
fn int[::indirect_contiguous, ::1, :] a28
fn int[::indirect_contiguous, ::view.contiguous, :] a29
fn int[::indirect_contiguous, :, ::view.contiguous] a30

fn int[::indirect, ::1] a31
fn int[::indirect, ::1, :] a32 = object()
fn int[::indirect, :, ::1] a33 = object()
fn int[::indirect, ::1, :] a34
fn int[::indirect, ::view.contiguous, :] a35
fn int[::indirect, :, ::view.contiguous] a36

fn int[::1, :] my_f_contig = a32[0]
fn int[:, ::1] my_c_contig = a33[0]

my_f_contig = a32[0, :, :]
my_c_contig = a33[0, :, :]

my_f_contig = a32[0, ...]
my_c_contig = a33[0, ...]

# Test casting to cython.view.array
cdef double[:, :] m1 = <double[:10, :10]> NULL
cdef double[:, :] m2 = <double[:10, :10:1]> NULL
cdef double[:, :] m3 = <double[:10:1, :10]> NULL

cdef double[:, :, :] m4 = <double[:10, :10, :10]> NULL
cdef double[:, :, :] m5 = <double[:10, :10, :10:1]> NULL
cdef double[:, :, :] m6 = <double[:10:1, :10, :10]> NULL
