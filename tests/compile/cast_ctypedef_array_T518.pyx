# ticket: t518
# mode: compile

extern from "cast_ctypedef_array_T518_helper.h":
    struct __foo_struct:
       i32 i, j
    type foo_t = __foo_struct[1]

    fn void foo_init(foo_t)
    fn void foo_clear(foo_t)

static foo_t value
foo_init(value)
foo_clear(value)

static void* pointer = <void*>value
foo_init(<foo_t>pointer)
foo_clear(<foo_t>pointer)
