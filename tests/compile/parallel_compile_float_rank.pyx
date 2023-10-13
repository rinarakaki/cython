# mode: compile

from cython.parallel import *
let ssize_t i
with nogil, parallel():
   for i in range(10):
       pass

