# mode: compile

extern from *:
    #[repr(packed)]
    struct MyStruct:
        char a

#[repr(packed)]
pub struct PublicStruct:
    i32 a
    u8 b
    i32 c
