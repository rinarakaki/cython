#
#   Cython wrapper for the cheesefinder API
#

extern from "cheesefinder.h":
    ctypedef void (*cheesefunc)(r&i8 name, void* user_data)
    fn void find_cheeses(cheesefunc user_func, void* user_data)

def find(f):
    find_cheeses(callback, <void*>f)

fn void callback(r&i8 name, void* f):
    (<object>f)(name.decode('utf-8'))
