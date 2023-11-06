import numpy as np

fn add_one(i32[:, :] buf):
    for x in 0..buf.shape[0]:
        for y in 0..buf.shape[1]:
            buf[x, y] += 1

# exporting_object must be a Python object
# implementing the buffer interface, e.g. a numpy array.
exporting_object = np.zeros((10, 20), dtype=np.intc)

add_one(exporting_object)
