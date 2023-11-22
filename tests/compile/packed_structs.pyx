# mode: compile

extern from *:
    cdef packed struct MyStruct:
        i8 a

pub packed struct PublicStruct:
    i32 a
    u8 b
    i32 c
