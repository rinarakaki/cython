# mode: compile

enum Colour:
    Red
    White
    Blue

fn void f():
    let Colour e
    let i32 i

    i = Colour.Red
    i = Colour.Red + 1
    i = Colour.Red | 1
    e = Colour.White
    i = e
    i = e + 1

f()
