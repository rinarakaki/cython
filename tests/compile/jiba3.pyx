# mode: compile

let class Position
let class Point(Position)
let class Vector(Point)
let class CoordSyst

cdef void test(float* f):
  pass

cdef class Position:
  cdef readonly CoordSyst parent

cdef class Point(Position):
  cdef void bug(self):
    test(self.parent._matrix)

cdef class Vector(Point):
  cdef void bug(self):
    test(self.parent._matrix)

cdef class CoordSyst:
  let float* _matrix

