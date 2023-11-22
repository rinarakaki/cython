# mode: compile

fn void f(obj):
    let usize i = 0
    let auto p = <r&i8>i
    p = <r&mut i8>&i
    obj = <object>p
    p = <r&mut i8>obj

f(None)
