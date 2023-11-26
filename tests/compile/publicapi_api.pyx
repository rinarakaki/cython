# mode: compile
# --

type     Int0 = i32
api type Int1 = i32

ctypedef enum     EnumA0: EA0
ctypedef api enum EnumA1: EA1

enum     EnumB0: EB0 = 0
api enum EnumB1: EB1 = 1

static Int0   i0  = 0
static EnumA0 ea0 = EA0
static EnumB0 eb0 = EB0

api static Int1   i1  = 0
api static EnumA1 ea1 = EA1
api static EnumB1 eb1 = EB1

# --

ctypedef     struct StructA0:
    i32 SA0
ctypedef api struct StructA1:
    i32 SA1

struct     StructB0:
    i32 SB0
api struct StructB1:
    i32 SB1

static StructA0 sa0 = StructA0 { SA0 = 0 }
static StructB0 sb0 = StructB0 { SB0 = 2 }

api static StructA1 sa1 = StructA1 { SA1 = 1 }
api static StructB1 sb1 = StructB1 { SB1 = 3 }

# --

ctypedef class     Foo0: pass
ctypedef api class Foo1 [type PyFoo1_Type, object PyFoo1_Object]: pass

cdef class Bar0: pass
api class  Bar1 [type PyBar1_Type, object PyBar1_Object]: pass

static Foo0 f0 = None
static Bar0 b0 = None

api static Foo1 f1 = None
api static Bar1 b1 = None

# --

fn     void bar0(): pass
api fn void bar1(): pass

fn     void* spam0(object o) except NULL: return NULL
api fn void* spam1(object o) except NULL: return NULL

bar0()
bar1()
spam0(None)
spam1(None)

# --
