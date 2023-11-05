# mode: compile

enum Foo:
    Var

fn void func():
    let Foo x
    map = [Foo::Var]
    x = map[0]

func()
