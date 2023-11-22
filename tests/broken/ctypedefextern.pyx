extern from "ctypedefextern.h":
    type some_int = i32
    ctypedef some_int *some_ptr

fn void spam():
    let some_int i
    let some_ptr p
    p[0] = i
