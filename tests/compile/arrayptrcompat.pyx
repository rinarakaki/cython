# mode: compile

enum E:
    Z

fn void f():
    let i32 *p
    let void *v
    let i32[5] a
    let i32 i = 0
    let E e = E::Z
    p = a
    v = a
    p = a + i
    p = a + <i32>e
    p = i + a
    p = <i32>e + a
    p = a - i
    p = a - <i32>e

f()
