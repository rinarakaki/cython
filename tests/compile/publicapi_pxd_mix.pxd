# --

type Int0 = i32
pub type Int1 = i32
api type Int2 = i32
pub api type Int3 = i32

ctypedef         enum EnumA0: EA0
ctypedef pub     enum EnumA1: EA1
ctypedef     api enum EnumA2: EA2
ctypedef pub api enum EnumA3: EA3

enum EnumB0: EB0 = 0
pub enum EnumB1: EB1 = 1
api enum EnumB2: EB2 = 2
pub  api enum EnumB3: EB3 = 3

# --

ctypedef         struct StructA0: 
    i32 SA0
ctypedef pub     struct StructA1: 
    i32 SA1
ctypedef     api struct StructA2:
    i32 SA2
ctypedef pub api struct StructA3:
    i32 SA3

struct StructB0:
    i32 SB0
pub struct StructB1:
    i32 SB1
api struct StructB2:
    i32 SB2
pub api struct StructB3:
    i32 SB3

# --

ctypedef         class Foo0: pass
ctypedef pub     class Foo1 [type PyFoo1_Type, object PyFoo1_Object]: pass
ctypedef     api class Foo2 [type PyFoo2_Type, object PyFoo2_Object]: pass
ctypedef pub api class Foo3 [type PyFoo3_Type, object PyFoo3_Object]: pass

cdef     class Bar0: pass
pub      class Bar1 [type PyBar1_Type, object PyBar1_Object]: pass
cdef api class Bar2 [type PyBar2_Type, object PyBar2_Object]: pass
pub  api class Bar3 [type PyBar3_Type, object PyBar3_Object]: pass

# --

extern from *:
    fn void foo()

fn inline   void bar (): pass
fn          void bar0()
pub         void bar1()
api fn      void bar2()
pub api fn  void bar3()

fn inline  void* spam (object o) except NULL: return NULL
fn         void* spam0(object o) except NULL
pub fn     void* spam1(object o) except NULL
api fn     void* spam2(object o) except NULL nogil
pub api fn void* spam3(object o) except NULL with gil

# --

static         i32 i0 = 0 # XXX implement initialization!!!
pub static     i32 i1
api static     i32 i2
pub api static i32 i3

# --
