# mode: compile

pub struct Foo:
    i32 a
    i32 b

struct Blarg:
    i32 c
    i32 d

pub type Zax = Foo

pub class C[type C_Type, object C_Obj]:
    pass

let pub Zax *blarg

let pub C c_pub = C()
let api C c_api = C()

let pub dict o_pub = C()
let api list o_api = C()

cdef api float f(Foo *x):
    pass

cdef pub void g(Blarg *x):
    pass

cdef pub api void h(Zax *x):
    pass

extern from "a_capi.h":
    pass
