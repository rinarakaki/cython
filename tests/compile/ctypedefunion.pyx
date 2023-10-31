# mode: compile

union Pet:
    i32 cat
    f32 dog

cdef Pet sam

sam.cat = 1
sam.dog = 2.7
