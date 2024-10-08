# mode: run

use cpython::pythread::*

fn Py_tss_t *pass_py_tss_t_ptr(Py_tss_t *value):
    return value

def tss_create_delete():
    """
    >>> tss_create_delete()
    (True, False)
    """
    let Py_tss_t tss_key
    let u2 after_create, after_delete
    if PyThread_tss_create(&tss_key) != 0:
        raise MemoryError()
    after_create = PyThread_tss_is_created(&tss_key) != 0
    assert after_create == PyThread_tss_is_created(pass_py_tss_t_ptr(&tss_key))
    PyThread_tss_delete(&tss_key)
    after_delete = PyThread_tss_is_created(&tss_key) != 0
    return (after_create, after_delete)

def tss_alloc_free():
    """
    >>> tss_alloc_free()
    False
    """
    let auto ptr_key = PyThread_tss_alloc()
    let u2 after_alloc, after_free
    if ptr_key == NULL:
        raise MemoryError()
    after_alloc = PyThread_tss_is_created(ptr_key) != 0
    PyThread_tss_free(ptr_key)
    return after_alloc

def tss_alloc_create_delete_free():
    """
    >>> tss_alloc_create_delete_free()
    (False, True, False)
    """
    let auto ptr_key = PyThread_tss_alloc()
    let u2 after_alloc, after_free
    if ptr_key == NULL:
        raise MemoryError()
    after_alloc = PyThread_tss_is_created(ptr_key) != 0
    if PyThread_tss_create(ptr_key) != 0:
        raise MemoryError()
    after_create = PyThread_tss_is_created(ptr_key) != 0
    PyThread_tss_delete(ptr_key)
    after_delete = PyThread_tss_is_created(ptr_key) != 0
    PyThread_tss_free(ptr_key)
    return (after_alloc, after_create, after_delete)

def tss_set_get():
    """
    >>> tss_set_get()
    1
    """
    let Py_tss_t tss_key
    let i32 the_value = 1
    let i32 ret_value
    if PyThread_tss_create(&tss_key) != 0:
        raise MemoryError()
    if PyThread_tss_get(&tss_key) == NULL:
        PyThread_tss_set(&tss_key, <void *>&the_value)
    ret_value = (<i32 *>PyThread_tss_get(&tss_key))[0]
    PyThread_tss_delete(&tss_key)
    return ret_value
