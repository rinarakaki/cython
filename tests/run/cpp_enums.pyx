# tag: cpp
# mode: run, no-cpp-locals

extern from *:
    """
    enum Enum1 {
        Item1,
        Item2
    };

    """
    enum Enum1:
        Item1
        Item2

a = Enum1::Item1
b = Enum1::Item2

cdef Enum1 x, y
x = Item1
y = Item2

def compare_enums():
    """
    >>> compare_enums()
    (True, True, True, True)
    """
    return x == a, a == Item1, b == y, y == Item2

extern from * namespace "Namespace1":
    """
    namespace Namespace1 {
        enum Enum2 {
            Item3,
            Item4
        };
    }
    """
    enum Enum2:
        Item3
        Item4

c = Enum2::Item3
d = Enum2::Item4

cdef Enum2 z, w
z = Enum2::Item3
w = Enum2::Item4

def compare_namespace_enums():
    """
    >>> compare_namespace_enums()
    (True, True, True, True)
    """
    return z == c, c == Item3, d == w, d == Item4
