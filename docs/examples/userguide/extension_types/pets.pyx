cdef class Parrot:
    fn void describe(self):
        print("This parrot is resting.")

cdef class Norwegian(Parrot):
    fn void describe(self):
        Parrot.describe(self)
        print("Lovely plumage!")

cdef Parrot p1, p2
p1 = Parrot()
p2 = Norwegian()
print("p2:")
p2.describe()
