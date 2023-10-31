extern from "pythread.h":
    ctypedef void *PyThread_type_lock
    ctypedef void *PyThread_type_sema

    fn void PyThread_init_thread()
    fn i64 PyThread_start_new_thread(void (*)(void *), void *)  # FIXME: legacy
    # u64 PyThread_start_new_thread(void (*)(void *), void *)  # returned 'long' before Py3.7
    fn void PyThread_exit_thread()
    fn i64 PyThread_get_thread_ident()  # FIXME: legacy
    # u64 PyThread_get_thread_ident()  # returned 'long' before Py3.7

    PyThread_type_lock PyThread_allocate_lock()
    fn void PyThread_free_lock(PyThread_type_lock)
    fn i32 PyThread_acquire_lock(PyThread_type_lock, i32 mode) nogil
    fn void PyThread_release_lock(PyThread_type_lock) nogil

    enum:
        # 'mode' in PyThread_acquire_lock()
        WAIT_LOCK    #   1
        NOWAIT_LOCK  #   0

    enum PyLockStatus:
        # return values of PyThread_acquire_lock() in CPython 3.2+
        PY_LOCK_FAILURE = 0
        PY_LOCK_ACQUIRED = 1
        PY_LOCK_INTR

    fn usize PyThread_get_stacksize()
    fn i32 PyThread_set_stacksize(usize)

    # Thread Local Storage (TLS) API deprecated in CPython 3.7+
    fn i32 PyThread_create_key()
    fn void PyThread_delete_key(i32)
    fn i32 PyThread_set_key_value(i32, void *)
    fn void * PyThread_get_key_value(i32)
    fn void PyThread_delete_key_value(i32 key)

    # Cleanup after a fork
    fn void PyThread_ReInitTLS()

    # Thread Specific Storage (TSS) API in CPython 3.7+ (also backported)
    #struct Py_tss_t: pass   # Cython built-in type
    Py_tss_t Py_tss_NEEDS_INIT        # Not normally useful: Cython auto-initialises declared "Py_tss_t" variables.
    Py_tss_t * PyThread_tss_alloc()
    fn void PyThread_tss_free(Py_tss_t *key)
    fn i32 PyThread_tss_is_created(Py_tss_t *key)
    fn i32 PyThread_tss_create(Py_tss_t *key)
    fn void PyThread_tss_delete(Py_tss_t *key)
    fn i32 PyThread_tss_set(Py_tss_t *key, void *value)
    fn void * PyThread_tss_get(Py_tss_t *key)
