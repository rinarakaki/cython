# mode: compile
# --

type     Int0 = i32
pub type Int1 = i32

ctypedef     enum EnumA0: EA0
ctypedef pub enum EnumA1: EA1

enum     EnumB0: EB0=0
pub enum EnumB1: EB1=1

static Int0   i0  = 0
static EnumA0 ea0 = EA0
static EnumB0 eb0 = EB0

pub static Int1   i1  = 0
pub static EnumA1 ea1 = EA1
pub static EnumB1 eb1 = EB1

# --

ctypedef struct     StructA0:
    i32 SA0
ctypedef pub struct StructA1:
    i32 SA1

struct StructB0:
    i32 SB0
pub struct StructB1:
    i32 SB1

static StructA0 sa0 = {'SA0':0}
static StructB0 sb0 = {'SB0':2}

pub static StructA1 sa1 = {'SA1':1}
pub static StructB1 sb1 = {'SB1':3}

# --

ctypedef     class Foo0: pass
ctypedef pub class Foo1 [type PyFoo1_Type, object PyFoo1_Object]: pass

cdef class Bar0: pass
pub class  Bar1 [type PyBar1_Type, object PyBar1_Object]: pass

static Foo0 f0 = None
static Bar0 b0 = None

pub static Foo1 f1 = None
pub static Bar1 b1 = None

# --

fn     void bar0(): pass
pub fn void bar1(): pass

fn     void* spam0(object o) except NULL: return NULL
pub fn void* spam1(object o) except NULL: return NULL

bar0()
bar1()
spam0(None)
spam1(None)

# --
