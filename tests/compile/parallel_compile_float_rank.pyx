# mode: compile

from cython.parallel import *
cdef ssize_t i
with nogil, parallel():
   for i in 0..10:
       pass

