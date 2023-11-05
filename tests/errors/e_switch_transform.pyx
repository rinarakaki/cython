# cython: optimize.use_switch=true
# mode: error
# tag: cerror

import cython

extern from *:
    enum:
        One "1"
        OneAgain "1+0"

def is_not_one(i32 i):
    return i != One and i != OneAgain
