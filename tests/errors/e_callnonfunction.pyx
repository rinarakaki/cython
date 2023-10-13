# mode: error

let int i
i()

let float f
f()

struct s:    # FIXME: this might be worth an error ...
    int x
s()

fn int x():
    return 0

x()()

_ERRORS = u"""
4:1: Calling non-function type 'int'
7:1: Calling non-function type 'float'
16:3: Calling non-function type 'int'
"""
