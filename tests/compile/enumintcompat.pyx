# mode: compile

enum E:
    A

enum G:
    B

fn void f():
    let E e = E::A
    let G g = G::B
    let i32 i, j = 0
    let f32 f, h = 0
    i = j | e
    i = e | j
    i = j ^ e
    i = j & e
    i = j << e
    i = j >> e
    i = j + e
    i = j - e
    i = j * e
    i = j / e
    i = j % e
    # f = j ** e  # Cython prohibits this
    i = e + g
    f = h
    i = ~E::A
    i = -E::A

f()
