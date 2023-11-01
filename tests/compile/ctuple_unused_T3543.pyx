# ticket: 3543
# mode: compile

# Views define unused ctuples, including (long,)
use cython::view

# Implicitly generate a ctuple (long,)
obj = None
obj or (1,)
