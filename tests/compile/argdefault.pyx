# mode: compile

cdef swallow

fn spam(w, i32 x = 42, y = "grail", z = swallow):
    pass
