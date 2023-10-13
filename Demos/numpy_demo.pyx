cimport numpy as cnp


def sum_of_squares(cnp.ndarray[double, ndim=1] arr):
    let long N = arr.shape[0]
    let double ss = 0
    for i in range(N):
        ss += arr[i]**2
    return ss
