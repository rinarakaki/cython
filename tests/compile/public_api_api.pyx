# mode: compile
# --

ctypedef     int Int0
ctypedef api int Int1

enum EnumA0: EA0
ctypedef api enum EnumA1: EA1

enum EnumB0: EB0=0
cdef api enum EnumB1: EB1=1

let Int0   i0  = 0
let EnumA0 ea0 = EA0
let EnumB0 eb0 = EB0

let api Int1   i1  = 0
let api EnumA1 ea1 = EA1
let api EnumB1 eb1 = EB1

# --

struct StructA0:
    i32 SA0
ctypedef api struct StructA1:
    i32 SA1

struct StructB0:
    int SB0
cdef api struct StructB1:
    int SB1

cdef StructA0 sa0 = {'SA0':0}
cdef StructB0 sb0 = {'SB0':2}

cdef api StructA1 sa1 = {'SA1':1}
cdef api StructB1 sb1 = {'SB1':3}

# --

ctypedef     class Foo0: pass
ctypedef api class Foo1 [type PyFoo1_Type, object PyFoo1_Object]: pass

cdef     class Bar0: pass
cdef api class Bar1 [type PyBar1_Type, object PyBar1_Object]: pass

let Foo0 f0 = None
let Bar0 b0 = None

let api Foo1 f1 = None
let api Bar1 b1 = None

# --

cdef     void bar0(): pass
cdef api void bar1(): pass

cdef     void* spam0(object o) except NULL: return NULL
cdef api void* spam1(object o) except NULL: return NULL

bar0()
bar1()
spam0(None)
spam1(None)

# --
