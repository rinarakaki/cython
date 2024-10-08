use libc::stdio::FILE
cimport cpython.type

extern from "Python.h":
    struct PyObject  # forward declaration

    ctypedef object (*newfunc)(cpython.type.type, PyObject*, PyObject*)  # (type, args|NULL, kwargs|NULL)

    ctypedef object (*unaryfunc)(object)
    ctypedef object (*binaryfunc)(object, object)
    ctypedef object (*ternaryfunc)(object, object, object)
    ctypedef i32 (*inquiry)(object) except -1
    ctypedef isize (*lenfunc)(object) except -1
    ctypedef object (*ssizeargfunc)(object, isize)
    ctypedef object (*ssizessizeargfunc)(object, isize, isize)
    ctypedef i32 (*ssizeobjargproc)(object, isize, object) except -1
    ctypedef i32 (*ssizessizeobjargproc)(object, isize, isize, object) except -1
    ctypedef i32 (*objobjargproc)(object, object, object) except -1
    ctypedef i32 (*objobjproc)(object, object) except -1

    ctypedef Py_hash_t (*hashfunc)(object) except -1
    ctypedef object (*reprfunc)(object)

    ctypedef i32 (*cmpfunc)(object, object) except -2
    ctypedef object (*richcmpfunc)(object, object, i32)

    # The following functions use 'PyObject*' as first argument instead of 'object' to prevent
    # accidental reference counting when calling them during a garbage collection run.
    ctypedef void (*destructor)(PyObject*)
    ctypedef i32 (*visitproc)(PyObject*, void *) except -1
    ctypedef i32 (*traverseproc)(PyObject*, visitproc, void*) except -1
    ctypedef void (*freefunc)(void*)

    ctypedef object (*descrgetfunc)(object, object, object)
    ctypedef i32 (*descrsetfunc)(object, object, object) except -1

    ctypedef object (*PyCFunction)(object, object)

    struct PyMethodDef:
        r&i8 ml_name
        PyCFunction ml_meth
        i32 ml_flags
        r&i8 ml_doc

    struct PyTypeObject:
        r&i8 tp_name
        r&i8 tp_doc
        isize tp_basicsize
        isize tp_itemsize
        isize tp_dictoffset
        u64 tp_flags

        newfunc tp_new
        destructor tp_dealloc
        destructor tp_del
        destructor tp_finalize
        traverseproc tp_traverse
        inquiry tp_clear
        freefunc tp_free

        ternaryfunc tp_call
        hashfunc tp_hash
        reprfunc tp_str
        reprfunc tp_repr

        cmpfunc tp_compare
        richcmpfunc tp_richcompare

        PyMethodDef* tp_methods

        PyTypeObject* tp_base
        PyObject* tp_dict

        descrgetfunc tp_descr_get
        descrsetfunc tp_descr_set

        u32 tp_version_tag

    struct PyObject:
        isize ob_refcnt
        PyTypeObject *ob_type

    fn PyTypeObject *Py_TYPE(object)

    fn void* PyObject_Malloc(usize)
    fn void* PyObject_Realloc(void *, usize)
    fn void PyObject_Free(void *)

    # ###################################################################
    # 6.1 Object Protocol
    # ###################################################################
    fn i32 PyObject_Print(object o, FILE *fp, i32 flags) except -1
    # Print an object o, on file fp. Returns -1 on error. The flags
    # argument is used to enable certain printing options. The only
    # option currently supported is Py_PRINT_RAW; if given, the str()
    # of the object is written instead of the repr().

    fn u2 PyObject_HasAttrString(object o, r&i8 attr_name)
    # Returns 1 if o has the attribute attr_name, and 0
    # otherwise. This is equivalent to the Python expression
    # "hasattr(o, attr_name)". This function always succeeds.

    fn object PyObject_GetAttrString(object o, r&i8 attr_name)
    # Return value: New reference.  Retrieve an attribute named
    # attr_name from object o. Returns the attribute value on success,
    # or NULL on failure. This is the equivalent of the Python
    # expression "o.attr_name".

    fn u2 PyObject_HasAttr(object o, object attr_name)
    # Returns 1 if o has the attribute attr_name, and 0
    # otherwise. This is equivalent to the Python expression
    # "hasattr(o, attr_name)". This function always succeeds.

    fn object PyObject_GetAttr(object o, object attr_name)
    # Return value: New reference.  Retrieve an attribute named
    # attr_name from object o. Returns the attribute value on success,
    # or NULL on failure. This is the equivalent of the Python
    # expression "o.attr_name".

    fn object PyObject_GenericGetAttr(object o, object attr_name)

    fn i32 PyObject_SetAttrString(object o, r&i8 attr_name, object v) except -1
    # Set the value of the attribute named attr_name, for object o, to
    # the value v. Returns -1 on failure. This is the equivalent of
    # the Python statement "o.attr_name = v".

    fn i32 PyObject_SetAttr(object o, object attr_name, object v) except -1
    # Set the value of the attribute named attr_name, for object o, to
    # the value v. Returns -1 on failure. This is the equivalent of
    # the Python statement "o.attr_name = v".

    fn i32 PyObject_GenericSetAttr(object o, object attr_name, object v) except -1

    fn i32 PyObject_DelAttrString(object o, r&i8 attr_name) except -1
    # Delete attribute named attr_name, for object o. Returns -1 on
    # failure. This is the equivalent of the Python statement: "del
    # o.attr_name".

    fn i32 PyObject_DelAttr(object o, object attr_name) except -1
    # Delete attribute named attr_name, for object o. Returns -1 on
    # failure. This is the equivalent of the Python statement "del
    # o.attr_name".

    fn object PyObject_GenericGetDict(object o, void* context)
    # Return value: New reference.
    # A generic implementation for the getter of a __dict__ descriptor. It
    # creates the dictionary if necessary.
    # New in version 3.3.

    fn i32 PyObject_GenericSetDict(object o, object value, void* context) except -1
    # A generic implementation for the setter of a __dict__ descriptor. This
    # implementation does not allow the dictionary to be deleted.
    # New in version 3.3.

    static i32 Py_LT, Py_LE, Py_EQ, Py_NE, Py_GT, Py_GE

    fn object PyObject_RichCompare(object o1, object o2, i32 opid)
    # Return value: New reference.
    # Compare the values of o1 and o2 using the operation specified by
    # opid, which must be one of Py_LT, Py_LE, Py_EQ, Py_NE, Py_GT, or
    # Py_GE, corresponding to <, <=, ==, !=, >, or >=
    # respectively. This is the equivalent of the Python expression
    # "o1 op o2", where op is the operator corresponding to
    # opid. Returns the value of the comparison on success, or NULL on
    # failure.

    fn u2 PyObject_RichCompareBool(object o1, object o2, i32 opid) except -1
    # Compare the values of o1 and o2 using the operation specified by
    # opid, which must be one of Py_LT, Py_LE, Py_EQ, Py_NE, Py_GT, or
    # Py_GE, corresponding to <, <=, ==, !=, >, or >=
    # respectively. Returns -1 on error, 0 if the result is false, 1
    # otherwise. This is the equivalent of the Python expression "o1
    # op o2", where op is the operator corresponding to opid.

    fn i32 PyObject_Cmp(object o1, object o2, i32* result) except -1
    # Compare the values of o1 and o2 using a routine provided by o1,
    # if one exists, otherwise with a routine provided by o2. The
    # result of the comparison is returned in result. Returns -1 on
    # failure. This is the equivalent of the Python statement "result
    # = cmp(o1, o2)".

    fn i32 PyObject_Compare(object o1, object o2) except *
    # Compare the values of o1 and o2 using a routine provided by o1,
    # if one exists, otherwise with a routine provided by o2. Returns
    # the result of the comparison on success. On error, the value
    # returned is undefined; use PyErr_Occurred() to detect an
    # error. This is equivalent to the Python expression "cmp(o1,
    # o2)".

    fn object PyObject_Repr(object o)
    # Return value: New reference.
    # Compute a string representation of object o. Returns the string
    # representation on success, NULL on failure. This is the
    # equivalent of the Python expression "repr(o)". Called by the
    # repr() built-in function and by reverse quotes.

    fn object PyObject_Str(object o)
    # Return value: New reference.
    # Compute a string representation of object o. Returns the string
    # representation on success, NULL on failure. This is the
    # equivalent of the Python expression "str(o)". Called by the
    # str() built-in function and by the print statement.

    fn object PyObject_Bytes(object o)
    # Return value: New reference.
    # Compute a bytes representation of object o. Return NULL on
    # failure and a bytes object on success. This is equivalent to
    # the Python expression bytes(o), when o is not an integer.
    # Unlike bytes(o), a TypeError is raised when o is an integer
    # instead of a zero-initialized bytes object.

    fn object PyObject_Unicode(object o)
    # Return value: New reference.
    # Compute a Unicode string representation of object o. Returns the
    # Unicode string representation on success, NULL on failure. This
    # is the equivalent of the Python expression "unicode(o)". Called
    # by the unicode() built-in function.

    fn u2 PyObject_IsInstance(object inst, object cls) except -1
    # Returns 1 if inst is an instance of the class cls or a subclass
    # of cls, or 0 if not. On error, returns -1 and sets an
    # exception. If cls is a type object rather than a class object,
    # PyObject_IsInstance() returns 1 if inst is of type cls. If cls
    # is a tuple, the check will be done against every entry in
    # cls. The result will be 1 when at least one of the checks
    # returns 1, otherwise it will be 0. If inst is not a class
    # instance and cls is neither a type object, nor a class object,
    # nor a tuple, inst must have a __class__ attribute -- the class
    # relationship of the value of that attribute with cls will be
    # used to determine the result of this function.

    # Subclass determination is done in a fairly straightforward way,
    # but includes a wrinkle that implementors of extensions to the
    # class system may want to be aware of. If A and B are class
    # objects, B is a subclass of A if it inherits from A either
    # directly or indirectly. If either is not a class object, a more
    # general mechanism is used to determine the class relationship of
    # the two objects. When testing if B is a subclass of A, if A is
    # B, PyObject_IsSubclass() returns true. If A and B are different
    # objects, B's __bases__ attribute is searched in a depth-first
    # fashion for A -- the presence of the __bases__ attribute is
    # considered sufficient for this determination.

    fn u2 PyObject_IsSubclass(object derived, object cls) except -1
    # Returns 1 if the class derived is identical to or derived from
    # the class cls, otherwise returns 0. In case of an error, returns
    # -1. If cls is a tuple, the check will be done against every
    # entry in cls. The result will be 1 when at least one of the
    # checks returns 1, otherwise it will be 0. If either derived or
    # cls is not an actual class object (or tuple), this function uses
    # the generic algorithm described above. New in version
    # 2.1. Changed in version 2.3: Older versions of Python did not
    # support a tuple as the second argument.

    fn u2 PyCallable_Check(object o)
    # Determine if the object o is callable. Return 1 if the object is
    # callable and 0 otherwise. This function always succeeds.

    fn object PyObject_Call(object callable_object, object args, object kw)
    # Return value: New reference.
    # Call a callable Python object callable_object, with arguments
    # given by the tuple args, and named arguments given by the
    # dictionary kw. If no named arguments are needed, kw may be
    # NULL. args must not be NULL, use an empty tuple if no arguments
    # are needed. Returns the result of the call on success, or NULL
    # on failure. This is the equivalent of the Python expression
    # "apply(callable_object, args, kw)" or "callable_object(*args,
    # **kw)".

    fn object PyObject_CallObject(object callable_object, object args)
    # Return value: New reference.
    # Call a callable Python object callable_object, with arguments
    # given by the tuple args. If no arguments are needed, then args
    # may be NULL. Returns the result of the call on success, or NULL
    # on failure. This is the equivalent of the Python expression
    # "apply(callable_object, args)" or "callable_object(*args)".

    fn object PyObject_CallFunction(object callable, r&i8 format, ...)
    # Return value: New reference.
    # Call a callable Python object callable, with a variable number
    # of C arguments. The C arguments are described using a
    # Py_BuildValue() style format string. The format may be NULL,
    # indicating that no arguments are provided. Returns the result of
    # the call on success, or NULL on failure. This is the equivalent
    # of the Python expression "apply(callable, args)" or
    # "callable(*args)". Note that if you only pass object  args,
    # PyObject_CallFunctionObjArgs is a faster alternative.

    fn object PyObject_CallMethod(object o, r&i8 method, r&i8 format, ...)
    # Return value: New reference.
    # Call the method named method of object o with a variable number
    # of C arguments. The C arguments are described by a
    # Py_BuildValue() format string that should produce a tuple. The
    # format may be NULL, indicating that no arguments are
    # provided. Returns the result of the call on success, or NULL on
    # failure. This is the equivalent of the Python expression
    # "o.method(args)". Note that if you only pass object  args,
    # PyObject_CallMethodObjArgs is a faster alternative.

    # fn object PyObject_CallFunctionObjArgs(object callable, ..., NULL)
    fn object PyObject_CallFunctionObjArgs(object callable, ...)
    # Return value: New reference.
    # Call a callable Python object callable, with a variable number
    # of PyObject* arguments. The arguments are provided as a variable
    # number of parameters followed by NULL. Returns the result of the
    # call on success, or NULL on failure.

    # fn PyObject* PyObject_CallMethodObjArgs(object o, object name, ..., NULL)
    fn object PyObject_CallMethodObjArgs(object o, object name, ...)
    # Return value: New reference.
    # Calls a method of the object o, where the name of the method is
    # given as a Python string object in name. It is called with a
    # variable number of PyObject* arguments. The arguments are
    # provided as a variable number of parameters followed by
    # NULL. Returns the result of the call on success, or NULL on
    # failure.

    fn i64 PyObject_Hash(object o) except? -1
    # Compute and return the hash value of an object o. On failure,
    # return -1. This is the equivalent of the Python expression
    # "hash(o)".

    fn u2 PyObject_IsTrue(object o) except -1
    # Returns 1 if the object o is considered to be true, and 0
    # otherwise. This is equivalent to the Python expression "not not
    # o". On failure, return -1.

    fn u2 PyObject_Not(object o) except -1
    # Returns 0 if the object o is considered to be true, and 1
    # otherwise. This is equivalent to the Python expression "not
    # o". On failure, return -1.

    fn object PyObject_Type(object o)
    # Return value: New reference.
    # When o is non-NULL, returns a type object corresponding to the
    # object type of object o. On failure, raises SystemError and
    # returns NULL. This is equivalent to the Python expression
    # type(o). This function increments the reference count of the
    # return value. There's really no reason to use this function
    # instead of the common expression o->ob_type, which returns a
    # pointer of type PyTypeObject*, except when the incremented
    # reference count is needed.

    fn u2 PyObject_TypeCheck(object o, PyTypeObject *type)
    # Return true if the object o is of type type or a subtype of
    # type. Both parameters must be non-NULL.

    fn isize PyObject_Length(object o) except -1
    fn isize PyObject_Size(object o) except -1
    # Return the length of object o. If the object o provides either
    # the sequence and mapping protocols, the sequence length is
    # returned. On error, -1 is returned. This is the equivalent to
    # the Python expression "len(o)".

    fn isize PyObject_LengthHint(object o, isize default) except -1
    # Return an estimated length for the object o. First try to return its
    # actual length, then an estimate using __length_hint__(), and finally
    # return the default value. On error, return -1. This is the equivalent to
    # the Python expression "operator.length_hint(o, default)".
    # New in version 3.4.

    fn object PyObject_GetItem(object o, object key)
    # Return value: New reference.
    # Return element of o corresponding to the object key or NULL on
    # failure. This is the equivalent of the Python expression
    # "o[key]".

    fn i32 PyObject_SetItem(object o, object key, object v) except -1
    # Map the object key to the value v. Returns -1 on failure. This
    # is the equivalent of the Python statement "o[key] = v".

    fn i32 PyObject_DelItem(object o, object key) except -1
    # Delete the mapping for key from o. Returns -1 on failure. This
    # is the equivalent of the Python statement "del o[key]".

    fn i32 PyObject_AsFileDescriptor(object o) except -1
    # Derives a file-descriptor from a Python object. If the object is
    # an integer or long integer, its value is returned. If not, the
    # object's fileno() method is called if it exists; the method must
    # return an integer or long integer, which is returned as the file
    # descriptor value. Returns -1 on failure.

    fn object PyObject_Dir(object o)
    # Return value: New reference.
    # This is equivalent to the Python expression "dir(o)", returning
    # a (possibly empty) list of strings appropriate for the object
    # argument, or NULL if there was an error. If the argument is
    # NULL, this is like the Python "dir()", returning the names of
    # the current locals; in this case, if no execution frame is
    # active then NULL is returned but PyErr_Occurred() will return
    # false.

    fn object PyObject_GetIter(object o)
    # Return value: New reference.
    # This is equivalent to the Python expression "iter(o)". It
    # returns a new iterator for the object argument, or the object
    # itself if the object is already an iterator. Raises TypeError
    # and returns NULL if the object cannot be iterated.

    fn isize Py_SIZE(object o)

    fn object PyObject_Format(object obj, object format_spec)
    # Takes an arbitrary object and returns the result of calling
    # obj.__format__(format_spec).
    # Added in Py2.6

    # Type flags (tp_flags of PyTypeObject)
    static i64 Py_TPFLAGS_HAVE_GETCHARBUFFER
    static i64 Py_TPFLAGS_HAVE_SEQUENCE_IN
    static i64 Py_TPFLAGS_HAVE_INPLACEOPS
    static i64 Py_TPFLAGS_CHECKTYPES
    static i64 Py_TPFLAGS_HAVE_RICHCOMPARE
    static i64 Py_TPFLAGS_HAVE_WEAKREFS
    static i64 Py_TPFLAGS_HAVE_ITER
    static i64 Py_TPFLAGS_HAVE_CLASS
    static i64 Py_TPFLAGS_HEAPTYPE
    static i64 Py_TPFLAGS_BASETYPE
    static i64 Py_TPFLAGS_READY
    static i64 Py_TPFLAGS_READYING
    static i64 Py_TPFLAGS_HAVE_GC
    static i64 Py_TPFLAGS_HAVE_STACKLESS_EXTENSION
    static i64 Py_TPFLAGS_HAVE_INDEX
    static i64 Py_TPFLAGS_HAVE_VERSION_TAG
    static i64 Py_TPFLAGS_VALID_VERSION_TAG
    static i64 Py_TPFLAGS_IS_ABSTRACT
    static i64 Py_TPFLAGS_HAVE_NEWBUFFER
    static i64 Py_TPFLAGS_INT_SUBCLASS
    static i64 Py_TPFLAGS_LONG_SUBCLASS
    static i64 Py_TPFLAGS_LIST_SUBCLASS
    static i64 Py_TPFLAGS_TUPLE_SUBCLASS
    static i64 Py_TPFLAGS_STRING_SUBCLASS
    static i64 Py_TPFLAGS_UNICODE_SUBCLASS
    static i64 Py_TPFLAGS_DICT_SUBCLASS
    static i64 Py_TPFLAGS_BASE_EXC_SUBCLASS
    static i64 Py_TPFLAGS_TYPE_SUBCLASS
    static i64 Py_TPFLAGS_DEFAULT_EXTERNAL
    static i64 Py_TPFLAGS_DEFAULT_CORE
    static i64 Py_TPFLAGS_DEFAULT
    static i64 Py_TPFLAGS_HAVE_FINALIZE
