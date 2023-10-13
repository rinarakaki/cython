# mode: compile

struct Foo:
    i32 blarg

fn f() -> Foo:
    blarg = 1 + 2
    cdef Foo foo
    foo.blarg = blarg
    return foo

f()
