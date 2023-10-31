# mode: error

cimport cython.parallel.parallel as p
use cython::parallel::something

import cython.parallel.parallel as p
from cython.parallel import something

use cython::parallel::prange

import cython.parallel

prange(1, 2, 3, schedule='dynamic')

cdef i32 i

with nogil, cython.parallel.parallel():
    for i in prange(10, schedule='invalid_schedule'):
        pass

with cython.parallel.parallel():
    print "hello world!"

cdef i32 *x = NULL

with nogil, cython.parallel.parallel():
    for j in prange(10):
        pass

    for x[1] in prange(10):
        pass

    for x in prange(10):
        pass

    with cython.parallel.parallel():
        pass

with nogil, cython.parallel.parallel:
    pass

cdef i32 y

for i in prange(10, nogil=true):
    i = y * 4
    y = i

for i in prange(10, nogil=true):
    y = i
    i = y * 4
    y = i


with nogil, cython.parallel.parallel():
    i = y
    y = i

for i in prange(10, nogil=true):
    y += i
    y *= i

with nogil, cython.parallel.parallel("invalid"):
    pass

with nogil, cython.parallel.parallel(invalid=true):
    pass

def f(x):
    let i32 i

    with nogil, cython.parallel.parallel():
        with gil:
            yield x

        for i in prange(10):
            with gil:
                yield x

# Disabled nesting:

for i in prange(10, nogil=true):
    for y in prange(10):
        pass

with nogil, cython.parallel.parallel():
    for i in prange(10):
        for i in prange(10):
            pass


# Assign to private from parallel block in prange:
cdef int myprivate1, myprivate2

with nogil, cython.parallel.parallel():
    myprivate1 = 1
    for i in prange(10):
        myprivate1 = 3
        myprivate2 = 4
    myprivate2 = 2

# Disallow parallel with block reductions:
i = 0
with nogil, cython.parallel.parallel():
    i += 1

# Use of privates after the parallel with block
with nogil, cython.parallel.parallel():
    i = 1

print i
i = 2
print i

# Reading of reduction variables in the prange block
cdef i32 sum = 0
for i in prange(10, nogil=true):
    sum += i
    with gil:
        print sum

for pyobj in prange("hello"):
    pass

from cython import parallel
with nogil, parallel.parallel():
    for i in parallel.prange(10):
        pass

cdef i32[:] dst, src = object()
for i in prange(10, nogil=true):
    dst = src

for i in prange(10, nogil=true, chunksize=20):
    pass

for i in prange(10, nogil=true, schedule='static', chunksize=-1):
    pass

for i in prange(10, nogil=true, schedule='runtime', chunksize=10):
    pass

fn i32 chunksize():
    return 10

for i in prange(10, nogil=true, schedule='static', chunksize=chunksize()):
    pass

with nogil, cython.parallel.parallel():
    with cython.parallel.parallel():
        pass


_ERRORS = u"""
4:4: cython.parallel.parallel is not a module
5:0: No such directive: cython.parallel.something
7:7: cython.parallel.parallel is not a module
8:0: No such directive: cython.parallel.something
14:6: prange() can only be used as part of a for loop
14:6: prange() can only be used without the GIL
19:19: Invalid schedule argument to prange: invalid_schedule
22:29: The parallel section may only be used without the GIL
28:8: target may not be a Python object as we don't have the GIL
31:9: Can only iterate over an iteration variable
34:8: Must be of numeric type, not int *
37:33: Nested parallel with blocks are disallowed
40:12: The parallel directive must be called
46:8: local variable 'y' referenced before assignment
56:8: local variable 'y' referenced before assignment
61:4: Reduction operator '*' is inconsistent with previous reduction operator '+'
63:36: cython.parallel.parallel() does not take positional arguments
66:36: Invalid keyword argument: invalid
74:12: 'yield' not allowed in parallel sections
78:16: 'yield' not allowed in parallel sections
98:8: Cannot assign to private of outer parallel block
99:8: Cannot assign to private of outer parallel block
105:4: Reductions not allowed for parallel blocks
111:6: local variable 'i' referenced before assignment
120:14: Cannot read reduction variable in loop body
122:19: prange() can only be used without the GIL
122:20: stop argument must be numeric
132:4: Memoryview slices can only be shared in parallel sections
134:42: Must provide schedule with chunksize
137:62: Chunksize must not be negative
140:62: Chunksize not valid for the schedule runtime
146:70: Calling gil-requiring function not allowed without gil
150:33: Nested parallel with blocks are disallowed
"""
