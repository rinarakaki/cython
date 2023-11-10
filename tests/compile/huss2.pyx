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
    e = <i32>Colour::White
    i = e
    i = e + 1

f()
