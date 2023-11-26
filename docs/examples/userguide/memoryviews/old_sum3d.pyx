cpdef fn i32 old_sum3d(object[i32, ndim=3, mode='strided'] arr):
    let i32 I, J, K, total = 0
    I = arr.shape[0]
    J = arr.shape[1]
    K = arr.shape[2]
    for i in 0..I:
        for j in 0..J:
            for k in 0..K:
                total += arr[i, j, k]
    return total
