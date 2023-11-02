# mode: compile

ctypedef i32 *IntPtr
type ULong = u64
cdef extern IntPtr spam
cdef extern ULong grail
