extern from "ctypedefextern.h":
    type some_int = i32
    type some_ptr = r&mut some_int

fn void spam():
    let some_int i
    let some_ptr p
    p[0] = i
