# mode: compile

enum E:
    a

enum G:
    b

cdef void f():
    let E e=a
    let G g=b
    let int i, j=0
    cdef float f, h=0
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
    # f = j ** e # Cython prohibits this
    i = e + g
    f = h
    i = ~a
    i = -a

f()
