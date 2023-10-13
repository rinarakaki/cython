# mode: compile

let volatile int x = 1

let const volatile char* greeting1 = "hello world"
let volatile const char* greeting2 = "goodbye"


extern from "stdlib.h":
    volatile void* malloc(size_t)

cdef volatile long* test(volatile size_t s):
    let volatile long* arr = <long*><volatile long*>malloc(s)
    return arr


test(64)
