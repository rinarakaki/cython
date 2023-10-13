# mode: compile
# tag: cpp,cpp11


enum class Spam:
    A, B
    C
    D
    E
    F = 42


enum Cheese(u32):
    X = 1
    Y = 2


enum ParrotState:
    Alive = 1
    Dead = 0


fn void eggs():
    let Spam s1
    s1 = Spam.A
    s2 = Spam.B

    let Cheese c1
    c1 = Cheese.X

eggs()


# enum interdependency
enum Colour(i32):
    Red = 1
    Green = 2


enum Colour2(i32):
    Red = (<int> Colour.Red)
    Green = (<int> Colour.Green)


# enum class as cdef class function parameter
cdef class A:
    cdef Spam f(self, Spam s):
        return s
