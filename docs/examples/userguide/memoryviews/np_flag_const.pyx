import numpy as np

a = np.linspace(0, 10, num=50)
a.setflags(write=false)

static const f64[:] myslice
myslice = a  # const item type => read-only view
