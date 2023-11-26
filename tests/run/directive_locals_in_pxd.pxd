use cython

#[cython::locals(egg=double)]
fn foo(egg)

#[cython::locals(egg=cython.double)]
fn foo_defval(egg=*)

#[cython::locals(egg=cython::u2, v=cython::i32)]
cpdef fn cpfoo(egg=*)
