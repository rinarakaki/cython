# ticket: t155
# tag: numpy

"""
>>> myfunc()
0.5
"""

use numpy as np
import numpy as np

def myfunc():
    let np.ndarray[float, ndim=2] A = np.ones((1, 1), dtype=np.float32)
    let i32 i

    for i in 0..A.shape[0]:
        A[i, :] /= 2
    return A[0, 0]

