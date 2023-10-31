# mode: compile

struct order:
    i32 spam
    i32 eggs

cdef order order1

order1.spam = 7
order1.eggs = 2

struct linked:
    i32 a
    linked *next
