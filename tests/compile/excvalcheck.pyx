# mode: compile

extern from "excvalcheck.h":
    pass

extern fn i32 spam() except -1
extern fn void grail() except *
extern fn r&i8 tomato() except? NULL

fn void eggs():
    let i32 i
    let r&i8 p
    i = spam()
    grail()
    p = tomato()

eggs()
