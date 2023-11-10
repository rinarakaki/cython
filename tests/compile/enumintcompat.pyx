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
    i = j | <i32>e
    i = <i32>e | j
    i = j ^ <i32>e
    i = j & <i32>e
    i = j << <i32>e
    i = j >> <i32>e
    i = j + <i32>e
    i = j - <i32>e
    i = j * <i32>e
    i = j / <i32>e
    i = j % <i32>e
    # f = j ** e  # Cython prohibits this
    i = <i32>e + <i32>g
    f = h
    i = ~<i32>E::A
    i = -<i32>E::A

f()
