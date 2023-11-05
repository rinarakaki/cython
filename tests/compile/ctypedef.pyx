# mode: compile

type IntPtr = i32 *
type ULong = u64
cdef extern IntPtr spam
cdef extern ULong grail
