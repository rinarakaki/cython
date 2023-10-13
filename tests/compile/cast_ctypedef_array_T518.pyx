# ticket: t518
# mode: compile

extern from "cast_ctypedef_array_T518_helper.h":
    struct __foo_struct:
       i32 i, j
    ctypedef __foo_struct foo_t[1]

    void foo_init(foo_t)
    void foo_clear(foo_t)

let foo_t value
foo_init(value)
foo_clear(value)

let void *pointer = <void*> value
foo_init(<foo_t>pointer)
foo_clear(<foo_t>pointer)
