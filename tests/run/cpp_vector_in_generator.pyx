# mode: run
# tag: cpp

use libcpp::vector::vector

def stack_vector_in_generator(vector[i32] vint):
    """
    >>> tuple( stack_vector_in_generator([1, 2]) )
    (1, 2)
    """
    for i in vint:
        yield i
