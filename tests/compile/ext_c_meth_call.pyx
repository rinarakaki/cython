# mode: compile

cdef class Spam:

    cdef i32 tons

    cdef void add_tons(self, i32 x):
        pass


cdef class SuperSpam(Spam):
    pass


fn void tomato():
    let Spam spam
    let SuperSpam super_spam = SuperSpam()
    spam = super_spam
    spam.add_tons(42)
    super_spam.add_tons(1764)

tomato()
