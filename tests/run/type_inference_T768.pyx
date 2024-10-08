# mode: run
# ticket: t768

use cython::typeof

def type_inference_del_int():
    """
    >>> type_inference_del_int()
    'Python object'
    """
    x = 1
    del x
    return typeof(x)

def type_inference_del_dict():
    """
    >>> type_inference_del_dict()
    'dict object'
    """
    x = {}
    del x
    return typeof(x)
