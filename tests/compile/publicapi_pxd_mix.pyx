# mode: compile

cdef class Foo1: pass
cdef class Foo2: pass
cdef class Foo3: pass

cdef class Bar1: pass
cdef class Bar2: pass
cdef class Bar3: pass

fn         void bar0(): pass
pub fn     void bar1(): pass
api fn     void bar2(): pass
pub api fn void bar3(): pass

fn         void* spam0(object o) except NULL: return NULL
pub fn     void* spam1(object o) except NULL: return NULL
api fn     void* spam2(object o) except NULL nogil: return NULL
pub api fn void* spam3(object o) except NULL with gil: return NULL

static         i32 i0 = 0  # XXX This should not be required!
pub static     i32 i1 = 1
api static     i32 i2 = 2
pub api static i32 i3 = 3
