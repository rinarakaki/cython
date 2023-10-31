
extern from "Python.h":

    ###########################################################################
    # Warning:
    #
    # The CObject API is deprecated as of Python 3.1. Please switch to
    # the new Capsules API.
    ###########################################################################

    fn i32 PyCObject_Check(object p)
    #     Return true if its argument is a PyCObject.

    fn object PyCObject_FromVoidPtr(void* cobj, void (*destr)(void *))
    #     Return value: New reference.
    #
    #     Create a PyCObject from the void * cobj. The destr function will
    #     be called when the object is reclaimed, unless it is NULL.

    fn object PyCObject_FromVoidPtrAndDesc(void* cobj, void* desc, void (*destr)(void *, void *))
    #     Return value: New reference.
    #
    #     Create a PyCObject from the void * cobj. The destr function will
    #     be called when the object is reclaimed. The desc argument can be
    #     used to pass extra callback data for the destructor function.

    fn void* PyCObject_AsVoidPtr(object self) except? NULL
    #     Return the object void * that the PyCObject self was created with.

    fn void* PyCObject_GetDesc(object self) except? NULL
    #     Return the description void * that the PyCObject self was created with.

    fn i32 PyCObject_SetVoidPtr(object self, void* cobj) except 0
    #     Set the void pointer inside self to cobj. The PyCObject must not
    #     have an associated destructor. Return true on success, false on
    #     failure.
