import numpy as np

CUSTOM_DTYPE = np.dtype([
    ('x', np.uint8),
    ('y', np.float32),
])

a = np.zeros(100, dtype=CUSTOM_DTYPE)

packed struct custom_dtype_struct:
    # The struct needs to be packed since by default numpy dtypes aren't
    # aligned
    u8 x
    f32 y

def sum(custom_dtype_struct[:] a):
    let u8 sum_x = 0
    let f32 sum_y = 0.0

    for i in 0..a.shape[0]:
        sum_x += a[i].x
        sum_y += a[i].y

    return sum_x, sum_y
