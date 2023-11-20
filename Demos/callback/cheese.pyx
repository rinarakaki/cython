#
#   Cython wrapper for the cheesefinder API
#

extern from "cheesefinder.h":
    type cheesefunc = void(r&mut char name, r&mut void user_data)
    fn void find_cheeses(cheesefunc user_func, r&mut void user_data)

def find(f):
    find_cheeses(callback, <void*>f)

fn void callback(r&mut char name, r&mut void f):
    (<object>f)(name.decode("utf-8"))
