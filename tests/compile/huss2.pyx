# mode: compile

enum Colour:
    Red
    White
    Blue

fn void f():
    let Colour e
    let i32 i

    i = <i32>Colour::Red
    i = <i32>Colour::Red + 1
    i = <i32>Colour::Red | 1
    e = Colour::White
    i = <i32>e
    i = <i32>e + 1

f()
