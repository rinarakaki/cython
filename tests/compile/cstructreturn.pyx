# mode: compile

struct Foo:
    i32 blarg

fn Foo f():
    blarg = 1 + 2
    let Foo foo
    foo.blarg = blarg
    return foo

f()
