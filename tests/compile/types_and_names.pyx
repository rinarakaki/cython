# mode: compile

print sizeof(point*)

cdef foo(i32 i0, i32 i, list L0, list L, Point p0, Point p, Point* ps):
    pass

cdef class A:
    let list
    let list L
    # Possibly empty declarators
    cdef point(self, int, int i, list, list L, point, point p, point* ps):
        pass

cdef class B(A):
    cdef point(self, o, int i, oo, list L, ooo, point p, point* ps):
        pass

let point P
let point *Ps
let A a

foo(2, 3, [], [], P, P, &P)
a.point("something", 3, "anything", [], "an object", P, &P)


# Test that internally generated names do not conflict.
cdef class A_spec:
    pass

cdef class A_members:
    pass

cdef class A_methods:
    pass

cdef class A_slots:
    pass
