# mode: compile

pub struct Foo:
    i32 a, b

struct Blarg:
    i32 c, d

pub type Zax = Foo

pub class C[type C_Type, object C_Obj]:
    pass

pub Zax *blarg

pub C c_pub = C()
cdef api C c_api = C()

pub dict o_pub = C()
cdef api list o_api = C()

api fn f32 f(Foo *x):
    pass

pub fn void g(Blarg *x):
    pass

pub api fn void h(Zax *x):
    pass

extern from "a_capi.h":
    pass
