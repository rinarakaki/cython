# mode: compile

struct Order:
    i32 spam
    i32 eggs

cdef Order order1

order1.spam = 7
order1.eggs = 2

struct Linked:
    i32 a
    Linked *next
