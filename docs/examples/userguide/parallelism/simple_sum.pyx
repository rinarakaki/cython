from cython.parallel import prange

let int i
let int n = 30
let int sum = 0

for i in prange(n, nogil=True):
    sum += i

print(sum)
