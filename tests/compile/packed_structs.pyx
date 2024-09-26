# mode: compile

extern from *:
    #[repr(packed)]
    struct MyStruct:
        i8 a

#[repr(packed)]
pub struct PublicStruct:
    i32 a
    u8 b
    i32 c
