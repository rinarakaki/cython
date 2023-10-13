# mode: compile
# --

ctypedef        int Int0
ctypedef public int Int1

enum EnumA0: EA0
pub enum EnumA1: EA1

enum EnumB0: EB0=0
cdef public enum EnumB1: EB1=1

let Int0   i0  = 0
let EnumA0 ea0 = EA0
let EnumB0 eb0 = EB0

let public Int1   i1  = 0
let public EnumA1 ea1 = EA1
let public EnumB1 eb1 = EB1

# --

struct StructA0:
    int SA0
pub struct StructA1:
    int SA1

struct StructB0:
    int SB0
cdef public struct StructB1:
    int SB1

cdef StructA0 sa0 = {'SA0':0}
cdef StructB0 sb0 = {'SB0':2}

cdef public StructA1 sa1 = {'SA1':1}
cdef public StructB1 sb1 = {'SB1':3}

# --

ctypedef        class Foo0: pass
ctypedef public class Foo1 [type PyFoo1_Type, object PyFoo1_Object]: pass

cdef        class Bar0: pass
cdef public class Bar1 [type PyBar1_Type, object PyBar1_Object]: pass

let Foo0 f0 = None
let Bar0 b0 = None

let public Foo1 f1 = None
let public Bar1 b1 = None

# --

cdef        void bar0(): pass
cdef public void bar1(): pass

cdef        void* spam0(object o) except NULL: return NULL
cdef public void* spam1(object o) except NULL: return NULL

bar0()
bar1()
spam0(None)
spam1(None)

# --
