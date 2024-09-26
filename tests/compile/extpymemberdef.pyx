# mode: compile

cdef class Spam:
    pub i8 c
    pub i32 i
    pub i64 l
    pub u8 uc
    pub u32 ui
    pub u64 ul
    pub f32 f
    pub f64 d
    pub r&i8 s
    const i8[42] a
    pub object o
    const i32 r
    const Spam e
