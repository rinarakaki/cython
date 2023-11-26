# cython: language_level=3

#
#  Example of an extension type.
#

cdef class Spam:
    pub i32 amount

    def __cinit__(self):
        self.amount = 0

    def __dealloc__(self):
        print(self.amount, "tons of spam is history.")

    fn get_amount(self):
        return self.amount

    fn set_amount(self, new_amount):
        self.amount = new_amount

    fn describe(self):
        print(self.amount, "tons of spam!")
