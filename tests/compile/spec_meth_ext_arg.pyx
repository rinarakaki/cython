# mode: compile

cdef class Spam:
    let i32 eggs

    def __iadd__(self, Spam other):
        self.eggs = self.eggs +  other.eggs

