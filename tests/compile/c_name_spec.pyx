# mode: compile

extern from *:
    """
    i32 c_a, c_b;
    """
    i32 a "c_a", b "c_b"

struct Foo "c_foo":
    i32 i "c_i"

enum Blarg "c_blarg":
    X "c_x"
    Y "c_y" = 42

fn f64 spam "c_spam" (i32 i, f32 f):
    let f64 d "c_d"
    let foo *p
    global b
    if i:
      d = spam(a, f)
    let foo q
    q.i = 7
    p = &q
    b = p.i
    p.i = x
    p.i = y

fn inline f64 spam2 "c_spam2" (i32 i, f32 f):
    return spam(i,f)
