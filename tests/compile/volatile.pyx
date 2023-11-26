# mode: compile

static volatile i32 x = 1

static const volatile i8* greeting1 = "hello world"
static volatile i8* greeting2 = "goodbye"

extern from "stdlib.h":
    fn volatile void* malloc(usize)

fn volatile i64* test(volatile usize s):
    let volatile i64* arr = <i64*><volatile i64*>malloc(s)
    return arr

test(64)
