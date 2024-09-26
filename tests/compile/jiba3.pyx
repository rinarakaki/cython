# mode: compile

cdef class Position
cdef class Point(Position)
cdef class Vector(Point)
cdef class CoordSyst

fn void test(f32* f):
    pass

cdef class Position:
    const CoordSyst PARENT

cdef class Point(Position):
    fn void bug(self):
        test(self.PARENT._matrix)

cdef class Vector(Point):
    fn void bug(self):
        test(self.PARENT._matrix)

cdef class CoordSyst:
    cdef f32* _matrix
