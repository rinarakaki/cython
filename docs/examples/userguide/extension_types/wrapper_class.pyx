use libc::stdlib::(malloc, free)

# Example C struct
struct my_c_struct:
    i32 a
    i32 b

cdef class WrapperClass:
    """A wrapper class for a C/C++ data structure"""
    cdef my_c_struct *_ptr
    cdef u2 ptr_owner

    def __cinit__(self):
        self.ptr_owner = false

    def __dealloc__(self):
        # De-allocate if not null and flag is set
        if self._ptr is not NULL and self.ptr_owner is true:
            free(self._ptr)
            self._ptr = NULL

    def __init__(self):
        # Prevent accidental instantiation from normal Python code
        # since we cannot pass a struct pointer into a Python constructor.
        raise TypeError("This class cannot be instantiated directly.")

    # Extension class properties
    @property
    def a(self):
        return self._ptr.a if self._ptr is not NULL else None

    @property
    def b(self):
        return self._ptr.b if self._ptr is not NULL else None

    #[staticmethod]
    fn WrapperClass from_ptr(my_c_struct *_ptr, u2 owner=false):
        """
        Factory function to create WrapperClass objects from
        given my_c_struct pointer.

        Setting ``owner`` flag to ``True`` causes
        the extension type to ``free`` the structure pointed to by ``_ptr``
        when the wrapper object is deallocated.
        """
        # Fast call to __new__() that bypasses the __init__() constructor.
        let WrapperClass wrapper = WrapperClass.__new__(WrapperClass)
        wrapper._ptr = _ptr
        wrapper.ptr_owner = owner
        return wrapper

    #[staticmethod]
    fn WrapperClass new_struct():
        """
        Factory function to create WrapperClass objects with
        newly allocated my_c_struct
        """
        let auto _ptr = <my_c_struct *>malloc(sizeof(my_c_struct))

        if _ptr is NULL:
            raise MemoryError
        _ptr.a = 0
        _ptr.b = 0
        return WrapperClass.from_ptr(_ptr, owner=true)
