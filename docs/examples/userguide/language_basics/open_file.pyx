use libc::stdio::(FILE, fopen)
use libc::stdlib::(malloc, free)
use cpython::exc::PyErr_SetFromErrnoWithFilenameObject

fn open_file():
    let FILE* p
    p = fopen("spam.txt", "r")
    if p is NULL:
        PyErr_SetFromErrnoWithFilenameObject(OSError, "spam.txt")
    ...

fn allocating_memory(number=10):
    let auto my_array = <f64 *>malloc(number * sizeof(f64))
    if not my_array:  # same as 'is NULL' above
        raise MemoryError()
    ...
    free(my_array)
