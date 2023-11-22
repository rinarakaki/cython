# mode: compile

fn void f(obj):
    let usize i = 0
    let auto p = <r&char>i
    p = <char *>&i
    obj = <object>p
    p = <char *>obj

f(None)
