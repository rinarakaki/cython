# NumPy static imports for Cython
#
# NOTE: Do not make incompatible local changes to this file without contacting the NumPy project.
# This file is maintained by the NumPy project at
# https://github.com/numpy/numpy/tree/master/numpy
#
# If any of the PyArray_* functions are called, import_array must be
# called first.  This is done automatically by Cython 3.0+ if a call
# is not detected inside of the module.
#
# Author: Dag Sverre Seljebotn
#

from cpython.ref cimport Py_INCREF
from cpython.object cimport PyObject, PyTypeObject, PyObject_TypeCheck
cimport libc.stdio as stdio

extern from *:
    # Leave a marker that the NumPy declarations came from Cython and not from NumPy itself.
    # See https://github.com/cython/cython/issues/3573
    """
    /* Using NumPy API declarations from "Cython/Includes/numpy/" */
    """

extern from "Python.h":
    ctypedef isize Py_intptr_t

extern from "numpy/arrayobject.h":
    ctypedef Py_intptr_t npy_intp
    ctypedef usize npy_uintp

    enum NPY_TYPES:
        NPY_BOOL
        NPY_BYTE
        NPY_UBYTE
        NPY_SHORT
        NPY_USHORT
        NPY_INT
        NPY_UINT
        NPY_LONG
        NPY_ULONG
        NPY_LONGLONG
        NPY_ULONGLONG
        NPY_FLOAT
        NPY_DOUBLE
        NPY_LONGDOUBLE
        NPY_CFLOAT
        NPY_CDOUBLE
        NPY_CLONGDOUBLE
        NPY_OBJECT
        NPY_STRING
        NPY_UNICODE
        NPY_VOID
        NPY_DATETIME
        NPY_TIMEDELTA
        NPY_NTYPES
        NPY_NOTYPE

        NPY_INT8
        NPY_INT16
        NPY_INT32
        NPY_INT64
        NPY_INT128
        NPY_INT256
        NPY_UINT8
        NPY_UINT16
        NPY_UINT32
        NPY_UINT64
        NPY_UINT128
        NPY_UINT256
        NPY_FLOAT16
        NPY_FLOAT32
        NPY_FLOAT64
        NPY_FLOAT80
        NPY_FLOAT96
        NPY_FLOAT128
        NPY_FLOAT256
        NPY_COMPLEX32
        NPY_COMPLEX64
        NPY_COMPLEX128
        NPY_COMPLEX160
        NPY_COMPLEX192
        NPY_COMPLEX256
        NPY_COMPLEX512

        NPY_INTP

    ctypedef enum NPY_ORDER:
        NPY_ANYORDER
        NPY_CORDER
        NPY_FORTRANORDER
        NPY_KEEPORDER

    ctypedef enum NPY_CASTING:
        NPY_NO_CASTING
        NPY_EQUIV_CASTING
        NPY_SAFE_CASTING
        NPY_SAME_KIND_CASTING
        NPY_UNSAFE_CASTING

    ctypedef enum NPY_CLIPMODE:
        NPY_CLIP
        NPY_WRAP
        NPY_RAISE

    ctypedef enum NPY_SCALARKIND:
        NPY_NOSCALAR,
        NPY_BOOL_SCALAR,
        NPY_INTPOS_SCALAR,
        NPY_INTNEG_SCALAR,
        NPY_FLOAT_SCALAR,
        NPY_COMPLEX_SCALAR,
        NPY_OBJECT_SCALAR

    ctypedef enum NPY_SORTKIND:
        NPY_QUICKSORT
        NPY_HEAPSORT
        NPY_MERGESORT

    ctypedef enum NPY_SEARCHSIDE:
        NPY_SEARCHLEFT
        NPY_SEARCHRIGHT

    enum:
        # DEPRECATED since NumPy 1.7 ! Do not use in new code!
        NPY_C_CONTIGUOUS
        NPY_F_CONTIGUOUS
        NPY_CONTIGUOUS
        NPY_FORTRAN
        NPY_OWNDATA
        NPY_FORCECAST
        NPY_ENSURECOPY
        NPY_ENSUREARRAY
        NPY_ELEMENTSTRIDES
        NPY_ALIGNED
        NPY_NOTSWAPPED
        NPY_WRITEABLE
        NPY_UPDATEIFCOPY
        NPY_ARR_HAS_DESCR

        NPY_BEHAVED
        NPY_BEHAVED_NS
        NPY_CARRAY
        NPY_CARRAY_RO
        NPY_FARRAY
        NPY_FARRAY_RO
        NPY_DEFAULT

        NPY_IN_ARRAY
        NPY_OUT_ARRAY
        NPY_INOUT_ARRAY
        NPY_IN_FARRAY
        NPY_OUT_FARRAY
        NPY_INOUT_FARRAY

        NPY_UPDATE_ALL

    enum:
        # Added in NumPy 1.7 to replace the deprecated enums above.
        NPY_ARRAY_C_CONTIGUOUS
        NPY_ARRAY_F_CONTIGUOUS
        NPY_ARRAY_OWNDATA
        NPY_ARRAY_FORCECAST
        NPY_ARRAY_ENSURECOPY
        NPY_ARRAY_ENSUREARRAY
        NPY_ARRAY_ELEMENTSTRIDES
        NPY_ARRAY_ALIGNED
        NPY_ARRAY_NOTSWAPPED
        NPY_ARRAY_WRITEABLE
        NPY_ARRAY_UPDATEIFCOPY

        NPY_ARRAY_BEHAVED
        NPY_ARRAY_BEHAVED_NS
        NPY_ARRAY_CARRAY
        NPY_ARRAY_CARRAY_RO
        NPY_ARRAY_FARRAY
        NPY_ARRAY_FARRAY_RO
        NPY_ARRAY_DEFAULT

        NPY_ARRAY_IN_ARRAY
        NPY_ARRAY_OUT_ARRAY
        NPY_ARRAY_INOUT_ARRAY
        NPY_ARRAY_IN_FARRAY
        NPY_ARRAY_OUT_FARRAY
        NPY_ARRAY_INOUT_FARRAY

        NPY_ARRAY_UPDATE_ALL

    cdef enum:
        NPY_MAXDIMS

    npy_intp NPY_MAX_ELSIZE

    ctypedef void (*PyArray_VectorUnaryFunc)(void *, void *, npy_intp, void *,  void *)

    ctypedef struct PyArray_ArrayDescr:
        # shape is a tuple, but Cython doesn't support "tuple shape"
        # inside a non-PyObject declaration, so we have to declare it
        # as just a PyObject*.
        PyObject* shape

    ctypedef struct PyArray_Descr:
        pass

    ctypedef class numpy.dtype [object PyArray_Descr, check_size ignore]:
        # Use PyDataType_* macros when possible, however there are no macros
        # for accessing some of the fields, so some are defined.
        cdef PyTypeObject* typeobj
        cdef char kind
        cdef char type
        # Numpy sometimes mutates this without warning (e.g. it'll
        # sometimes change "|" to "<" in shared dtype objects on
        # little-endian machines). If this matters to you, use
        # PyArray_IsNativeByteOrder(dtype.byteorder) instead of
        # directly accessing this field.
        cdef char byteorder
        cdef char flags
        cdef i32 type_num
        cdef i32 itemsize "elsize"
        cdef i32 alignment
        cdef object fields
        cdef tuple names
        # Use PyDataType_HASSUBARRAY to test whether this field is
        # valid (the pointer can be NULL). Most users should access
        # this field via the inline helper method PyDataType_SHAPE.
        cdef PyArray_ArrayDescr* subarray

    ctypedef class numpy.flatiter [object PyArrayIterObject, check_size ignore]:
        # Use through macros
        pass

    ctypedef class numpy.broadcast [object PyArrayMultiIterObject, check_size ignore]:
        # Use through macros
        pass

    ctypedef struct PyArrayObject:
        # For use in situations where ndarray can't replace PyArrayObject*,
        # like PyArrayObject**.
        pass

    ctypedef class numpy.ndarray [object PyArrayObject, check_size ignore]:
        cdef __cythonbufferdefaults__ = {"mode": "strided"}

        # NOTE: no field declarations since direct access is deprecated since NumPy 1.7
        # Instead, we use properties that map to the corresponding C-API functions.

        @property
        fn inline PyObject* base(self) nogil:
            """Returns a borrowed reference to the object owning the data/memory.
            """
            return PyArray_BASE(self)

        @property
        fn inline dtype descr(self):
            """Returns an owned reference to the dtype of the array.
            """
            return <dtype>PyArray_DESCR(self)

        @property
        fn inline i32 ndim(self) nogil:
            """Returns the number of dimensions in the array.
            """
            return PyArray_NDIM(self)

        @property
        fn inline npy_intp *shape(self) nogil:
            """Returns a pointer to the dimensions/shape of the array.
            The number of elements matches the number of dimensions of the array (ndim).
            Can return NULL for 0-dimensional arrays.
            """
            return PyArray_DIMS(self)

        @property
        fn inline npy_intp *strides(self) nogil:
            """Returns a pointer to the strides of the array.
            The number of elements matches the number of dimensions of the array (ndim).
            """
            return PyArray_STRIDES(self)

        @property
        fn inline npy_intp size(self) nogil:
            """Returns the total size (in number of elements) of the array.
            """
            return PyArray_SIZE(self)

        @property
        fn inline char* data(self) nogil:
            """The pointer to the data buffer as a char*.
            This is provided for legacy reasons to avoid direct struct field access.
            For new code that needs this access, you probably want to cast the result
            of `PyArray_DATA()` instead, which returns a 'void*'.
            """
            return PyArray_BYTES(self)

    ctypedef u8 npy_bool

    ctypedef i8   npy_byte
    ctypedef i16  npy_short
    ctypedef i32  npy_int
    ctypedef i64  npy_long
    ctypedef i128 npy_longlong

    ctypedef u8   npy_ubyte
    ctypedef u16  npy_ushort
    ctypedef u32  npy_uint
    ctypedef u64  npy_ulong
    ctypedef u128 npy_ulonglong

    ctypedef f32         npy_float
    ctypedef f64         npy_double
    ctypedef long double npy_longdouble

    ctypedef i8   npy_int8
    ctypedef i16  npy_int16
    ctypedef i32  npy_int32
    ctypedef i128 npy_int64
    ctypedef i128 npy_int96
    ctypedef i128 npy_int128

    ctypedef u8   npy_uint8
    ctypedef u16  npy_uint16
    ctypedef u32  npy_uint32
    ctypedef u128 npy_uint64
    ctypedef u128 npy_uint96
    ctypedef u128 npy_uint128

    ctypedef f32         npy_float32
    ctypedef f64         npy_float64
    ctypedef long double npy_float80
    ctypedef long double npy_float96
    ctypedef long double npy_float128

    ctypedef struct npy_cfloat:
        f64 real
        f64 imag

    ctypedef struct npy_cdouble:
        f64 real
        f64 imag

    ctypedef struct npy_clongdouble:
        long double real
        long double imag

    ctypedef struct npy_complex64:
        f32 real
        f32 imag

    ctypedef struct npy_complex128:
        f64 real
        f64 imag

    ctypedef struct npy_complex160:
        long double real
        long double imag

    ctypedef struct npy_complex192:
        long double real
        long double imag

    ctypedef struct npy_complex256:
        long double real
        long double imag

    ctypedef struct PyArray_Dims:
        npy_intp *ptr
        i32 len

    fn i32 _import_array() except -1
    # A second definition so _import_array isn't marked as used when we use it here.
    # Do not use - subject to change any time.
    fn i32 __pyx_import_array "_import_array"() except -1

    #
    # Macros from ndarrayobject.h
    #
    fn bint PyArray_CHKFLAGS(ndarray m, i32 flags) nogil
    fn bint PyArray_IS_C_CONTIGUOUS(ndarray arr) nogil
    fn bint PyArray_IS_F_CONTIGUOUS(ndarray arr) nogil
    fn bint PyArray_ISCONTIGUOUS(ndarray m) nogil
    fn bint PyArray_ISWRITEABLE(ndarray m) nogil
    fn bint PyArray_ISALIGNED(ndarray m) nogil

    fn i32 PyArray_NDIM(ndarray) nogil
    fn bint PyArray_ISONESEGMENT(ndarray) nogil
    fn bint PyArray_ISFORTRAN(ndarray) nogil
    fn i32 PyArray_FORTRANIF(ndarray) nogil

    fn void* PyArray_DATA(ndarray) nogil
    fn char* PyArray_BYTES(ndarray) nogil

    npy_intp* PyArray_DIMS(ndarray) nogil
    npy_intp* PyArray_STRIDES(ndarray) nogil
    npy_intp PyArray_DIM(ndarray, usize) nogil
    npy_intp PyArray_STRIDE(ndarray, usize) nogil

    fn PyObject *PyArray_BASE(ndarray) nogil  # returns borrowed reference!
    PyArray_Descr *PyArray_DESCR(ndarray) nogil  # returns borrowed reference to dtype!
    PyArray_Descr *PyArray_DTYPE(ndarray) nogil  # returns borrowed reference to dtype! NP 1.7+ alias for descr.
    fn i32 PyArray_FLAGS(ndarray) nogil
    fn void PyArray_CLEARFLAGS(ndarray, i32 flags) nogil  # Added in NumPy 1.7
    fn void PyArray_ENABLEFLAGS(ndarray, i32 flags) nogil  # Added in NumPy 1.7
    npy_intp PyArray_ITEMSIZE(ndarray) nogil
    fn i32 PyArray_TYPE(ndarray arr) nogil

    fn object PyArray_GETITEM(ndarray arr, void *itemptr)
    fn i32 PyArray_SETITEM(ndarray arr, void *itemptr, object obj)

    fn bint PyTypeNum_ISBOOL(i32) nogil
    fn bint PyTypeNum_ISUNSIGNED(i32) nogil
    fn bint PyTypeNum_ISSIGNED(i32) nogil
    fn bint PyTypeNum_ISINTEGER(i32) nogil
    fn bint PyTypeNum_ISFLOAT(i32) nogil
    fn bint PyTypeNum_ISNUMBER(i32) nogil
    fn bint PyTypeNum_ISSTRING(i32) nogil
    fn bint PyTypeNum_ISCOMPLEX(i32) nogil
    fn bint PyTypeNum_ISPYTHON(i32) nogil
    fn bint PyTypeNum_ISFLEXIBLE(i32) nogil
    fn bint PyTypeNum_ISUSERDEF(i32) nogil
    fn bint PyTypeNum_ISEXTENDED(i32) nogil
    fn bint PyTypeNum_ISOBJECT(i32) nogil

    fn bint PyDataType_ISBOOL(dtype) nogil
    fn bint PyDataType_ISUNSIGNED(dtype) nogil
    fn bint PyDataType_ISSIGNED(dtype) nogil
    fn bint PyDataType_ISINTEGER(dtype) nogil
    fn bint PyDataType_ISFLOAT(dtype) nogil
    fn bint PyDataType_ISNUMBER(dtype) nogil
    fn bint PyDataType_ISSTRING(dtype) nogil
    fn bint PyDataType_ISCOMPLEX(dtype) nogil
    fn bint PyDataType_ISPYTHON(dtype) nogil
    fn bint PyDataType_ISFLEXIBLE(dtype) nogil
    fn bint PyDataType_ISUSERDEF(dtype) nogil
    fn bint PyDataType_ISEXTENDED(dtype) nogil
    fn bint PyDataType_ISOBJECT(dtype) nogil
    fn bint PyDataType_HASFIELDS(dtype) nogil
    fn bint PyDataType_HASSUBARRAY(dtype) nogil

    fn bint PyArray_ISBOOL(ndarray) nogil
    fn bint PyArray_ISUNSIGNED(ndarray) nogil
    fn bint PyArray_ISSIGNED(ndarray) nogil
    fn bint PyArray_ISINTEGER(ndarray) nogil
    fn bint PyArray_ISFLOAT(ndarray) nogil
    fn bint PyArray_ISNUMBER(ndarray) nogil
    fn bint PyArray_ISSTRING(ndarray) nogil
    fn bint PyArray_ISCOMPLEX(ndarray) nogil
    fn bint PyArray_ISPYTHON(ndarray) nogil
    fn bint PyArray_ISFLEXIBLE(ndarray) nogil
    fn bint PyArray_ISUSERDEF(ndarray) nogil
    fn bint PyArray_ISEXTENDED(ndarray) nogil
    fn bint PyArray_ISOBJECT(ndarray) nogil
    fn bint PyArray_HASFIELDS(ndarray) nogil

    fn bint PyArray_ISVARIABLE(ndarray) nogil

    fn bint PyArray_SAFEALIGNEDCOPY(ndarray) nogil
    fn bint PyArray_ISNBO(char) nogil              # works on ndarray.byteorder
    fn bint PyArray_IsNativeByteOrder(char) nogil  # works on ndarray.byteorder
    fn bint PyArray_ISNOTSWAPPED(ndarray) nogil
    fn bint PyArray_ISBYTESWAPPED(ndarray) nogil

    fn bint PyArray_FLAGSWAP(ndarray, i32) nogil

    fn bint PyArray_ISCARRAY(ndarray) nogil
    fn bint PyArray_ISCARRAY_RO(ndarray) nogil
    fn bint PyArray_ISFARRAY(ndarray) nogil
    fn bint PyArray_ISFARRAY_RO(ndarray) nogil
    fn bint PyArray_ISBEHAVED(ndarray) nogil
    fn bint PyArray_ISBEHAVED_RO(ndarray) nogil


    fn bint PyDataType_ISNOTSWAPPED(dtype) nogil
    fn bint PyDataType_ISBYTESWAPPED(dtype) nogil

    fn bint PyArray_DescrCheck(object)

    fn bint PyArray_Check(object)
    fn bint PyArray_CheckExact(object)

    # Cannot be supported due to out arg:
    # bint PyArray_HasArrayInterfaceType(object, dtype, object, object&)
    # bint PyArray_HasArrayInterface(op, out)


    fn bint PyArray_IsZeroDim(object)
    # Cannot be supported due to ## ## in macro:
    # bint PyArray_IsScalar(object, verbatim work)
    fn bint PyArray_CheckScalar(object)
    fn bint PyArray_IsPythonNumber(object)
    fn bint PyArray_IsPythonScalar(object)
    fn bint PyArray_IsAnyScalar(object)
    fn bint PyArray_CheckAnyScalar(object)

    ndarray PyArray_GETCONTIGUOUS(ndarray)
    fn bint PyArray_SAMESHAPE(ndarray, ndarray) nogil
    npy_intp PyArray_SIZE(ndarray) nogil
    npy_intp PyArray_NBYTES(ndarray) nogil

    fn object PyArray_FROM_O(object)
    fn object PyArray_FROM_OF(object m, i32 flags)
    fn object PyArray_FROM_OT(object m, i32 type)
    fn object PyArray_FROM_OTF(object m, i32 type, i32 flags)
    fn object PyArray_FROMANY(object m, i32 type, i32 min, i32 max, i32 flags)
    fn object PyArray_ZEROS(i32 nd, npy_intp* dims, i32 nd, i32 nd)
    fn object PyArray_EMPTY(i32 nd, npy_intp* dims, i32 nd, i32 nd)
    fn void PyArray_FILLWBYTE(object, i32 val)
    npy_intp PyArray_REFCOUNT(object)
    fn object PyArray_ContiguousFromAny(op, int, int min_depth, int max_depth)
    u8 PyArray_EquivArrTypes(ndarray a1, ndarray a2)
    fn bint PyArray_EquivByteorders(i32 b1, int b2) nogil
    fn object PyArray_SimpleNew(i32 nd, npy_intp* dims, i32 nd)
    fn object PyArray_SimpleNewFromData(i32 nd, npy_intp* dims, i32 nd, void* data)
    # fn object PyArray_SimpleNewFromDescr(i32 nd, npy_intp* dims, dtype descr)
    fn object PyArray_ToScalar(void* data, ndarray arr)

    fn void* PyArray_GETPTR1(ndarray m, npy_intp i) nogil
    fn void* PyArray_GETPTR2(ndarray m, npy_intp i, npy_intp j) nogil
    fn void* PyArray_GETPTR3(ndarray m, npy_intp i, npy_intp j, npy_intp k) nogil
    fn void* PyArray_GETPTR4(ndarray m, npy_intp i, npy_intp j, npy_intp k, npy_intp l) nogil

    fn void PyArray_XDECREF_ERR(ndarray)
    # Cannot be supported due to out arg
    # void PyArray_DESCR_REPLACE(descr)


    fn object PyArray_Copy(ndarray)
    fn object PyArray_FromObject(object op, i32 type, int min_depth, int max_depth)
    fn object PyArray_ContiguousFromObject(object op, i32 type, int min_depth, int max_depth)
    fn object PyArray_CopyFromObject(object op, i32 type, int min_depth, int max_depth)

    fn object PyArray_Cast(ndarray mp, int type_num)
    fn object PyArray_Take(ndarray ap, object items, i32 axis)
    fn object PyArray_Put(ndarray ap, object items, object values)

    fn void PyArray_ITER_RESET(flatiter it) nogil
    fn void PyArray_ITER_NEXT(flatiter it) nogil
    fn void PyArray_ITER_GOTO(flatiter it, npy_intp* destination) nogil
    fn void PyArray_ITER_GOTO1D(flatiter it, npy_intp ind) nogil
    fn void* PyArray_ITER_DATA(flatiter it) nogil
    fn bint PyArray_ITER_NOTDONE(flatiter it) nogil

    fn void PyArray_MultiIter_RESET(broadcast multi) nogil
    fn void PyArray_MultiIter_NEXT(broadcast multi) nogil
    fn void PyArray_MultiIter_GOTO(broadcast multi, npy_intp dest) nogil
    fn void PyArray_MultiIter_GOTO1D(broadcast multi, npy_intp ind) nogil
    fn void* PyArray_MultiIter_DATA(broadcast multi, npy_intp i) nogil
    fn void PyArray_MultiIter_NEXTi(broadcast multi, npy_intp i) nogil
    fn bint PyArray_MultiIter_NOTDONE(broadcast multi) nogil

    # Functions from __multiarray_api.h

    # Functions taking dtype and returning object/ndarray are disabled
    # for now as they steal dtype references. I'm conservative and disable
    # more than is probably needed until it can be checked further.
    fn i32 PyArray_SetNumericOps        (object)
    fn object PyArray_GetNumericOps ()
    fn i32 PyArray_INCREF (ndarray)
    fn i32 PyArray_XDECREF (ndarray)
    fn void PyArray_SetStringFunction (object, i32)
    dtype PyArray_DescrFromType (i32)
    fn object PyArray_TypeObjectFromType (i32)
    fn char * PyArray_Zero (ndarray)
    fn char * PyArray_One (ndarray)
    # fn object PyArray_CastToType (ndarray, dtype, i32)
    fn i32 PyArray_CastTo (ndarray, ndarray)
    fn i32 PyArray_CastAnyTo (ndarray, ndarray)
    fn i32 PyArray_CanCastSafely (i32, i32)
    npy_bool PyArray_CanCastTo (dtype, dtype)
    fn i32 PyArray_ObjectType (object, i32)
    dtype PyArray_DescrFromObject (object, dtype)
    #ndarray* PyArray_ConvertToCommonType (object, i32 *)
    dtype PyArray_DescrFromScalar (object)
    dtype PyArray_DescrFromTypeObject (object)
    npy_intp PyArray_Size (object)
    # fn object PyArray_Scalar (void *, dtype, object)
    # fn object PyArray_FromScalar (object, dtype)
    fn void PyArray_ScalarAsCtype (object, void *)
    # fn i32 PyArray_CastScalarToCtype (object, void *, dtype)
    # fn i32 PyArray_CastScalarDirect (object, dtype, void *, i32)
    fn object PyArray_ScalarFromObject (object)
    #PyArray_VectorUnaryFunc * PyArray_GetCastFunc (dtype, i32)
    fn object PyArray_FromDims (i32, i32 *, i32)
    # fn object PyArray_FromDimsAndDataAndDescr (i32, i32 *, dtype, char *)
    # fn object PyArray_FromAny (object, dtype, int, int, int, object)
    fn object PyArray_EnsureArray (object)
    fn object PyArray_EnsureAnyArray (object)
    # fn object PyArray_FromFile (stdio.FILE *, dtype, npy_intp, char *)
    # fn object PyArray_FromString (char *, npy_intp, dtype, npy_intp, char *)
    # fn object PyArray_FromBuffer (object, dtype, npy_intp, npy_intp)
    # fn object PyArray_FromIter (object, dtype, npy_intp)
    fn object PyArray_Return (ndarray)
    # fn object PyArray_GetField (ndarray, dtype, i32)
    # fn i32 PyArray_SetField (ndarray, dtype, int, object)
    fn object PyArray_Byteswap (ndarray, npy_bool)
    fn object PyArray_Resize (ndarray, PyArray_Dims *, int, NPY_ORDER)
    fn i32 PyArray_MoveInto (ndarray, ndarray)
    fn i32 PyArray_CopyInto (ndarray, ndarray)
    fn i32 PyArray_CopyAnyInto (ndarray, ndarray)
    fn i32 PyArray_CopyObject (ndarray, object)
    fn object PyArray_NewCopy (ndarray, NPY_ORDER)
    fn object PyArray_ToList (ndarray)
    fn object PyArray_ToString (ndarray, NPY_ORDER)
    fn i32 PyArray_ToFile (ndarray, stdio.FILE *, char *, char *)
    fn i32 PyArray_Dump (object, object, i32)
    fn object PyArray_Dumps (object, i32)
    fn i32 PyArray_ValidType (i32)
    fn void PyArray_UpdateFlags (ndarray, i32)
    fn object PyArray_New (type, int, npy_intp *, int, npy_intp *, void *, int, int, object)
    # fn object PyArray_NewFromDescr (type, dtype, int, npy_intp *, npy_intp *, void *, int, object)
    #dtype PyArray_DescrNew (dtype)
    dtype PyArray_DescrNewFromType (i32)
    fn double PyArray_GetPriority (object, double)
    fn object PyArray_IterNew (object)
    fn object PyArray_MultiIterNew (i32, ...)

    fn i32 PyArray_PyIntAsInt (object)
    npy_intp PyArray_PyIntAsIntp (object)
    fn i32 PyArray_Broadcast (broadcast)
    fn void PyArray_FillObjectArray (ndarray, object)
    fn i32 PyArray_FillWithScalar (ndarray, object)
    npy_bool PyArray_CheckStrides (i32, int, npy_intp, npy_intp, npy_intp *, npy_intp *)
    dtype PyArray_DescrNewByteorder (dtype, char)
    fn object PyArray_IterAllButAxis (object, i32 *)
    # fn object PyArray_CheckFromAny (object, dtype, int, int, int, object)
    # fn object PyArray_FromArray (ndarray, dtype, i32)
    fn object PyArray_FromInterface (object)
    fn object PyArray_FromStructInterface (object)
    # fn object PyArray_FromArrayAttr (object, dtype, object)
    #NPY_SCALARKIND PyArray_ScalarKind (i32, ndarray*)
    fn i32 PyArray_CanCoerceScalar (i32, int, NPY_SCALARKIND)
    fn object PyArray_NewFlagsObject (object)
    npy_bool PyArray_CanCastScalar (type, type)
    # fn i32 PyArray_CompareUCS4 (npy_ucs4 *, npy_ucs4 *, register usize)
    fn i32 PyArray_RemoveSmallest (broadcast)
    fn i32 PyArray_ElementStrides (object)
    fn void PyArray_Item_INCREF (char *, dtype)
    fn void PyArray_Item_XDECREF (char *, dtype)
    fn object PyArray_FieldNames (object)
    fn object PyArray_Transpose (ndarray, PyArray_Dims *)
    fn object PyArray_TakeFrom (ndarray, object, int, ndarray, NPY_CLIPMODE)
    fn object PyArray_PutTo (ndarray, object, object, NPY_CLIPMODE)
    fn object PyArray_PutMask (ndarray, object, object)
    fn object PyArray_Repeat (ndarray, object, i32)
    fn object PyArray_Choose (ndarray, object, ndarray, NPY_CLIPMODE)
    fn i32 PyArray_Sort (ndarray, int, NPY_SORTKIND)
    fn object PyArray_ArgSort (ndarray, int, NPY_SORTKIND)
    fn object PyArray_SearchSorted (ndarray, object, NPY_SEARCHSIDE, PyObject *)
    fn object PyArray_ArgMax (ndarray, int, ndarray)
    fn object PyArray_ArgMin (ndarray, int, ndarray)
    fn object PyArray_Reshape (ndarray, object)
    fn object PyArray_Newshape (ndarray, PyArray_Dims *, NPY_ORDER)
    fn object PyArray_Squeeze (ndarray)
    # fn object PyArray_View (ndarray, dtype, type)
    fn object PyArray_SwapAxes (ndarray, int, i32)
    fn object PyArray_Max (ndarray, int, ndarray)
    fn object PyArray_Min (ndarray, int, ndarray)
    fn object PyArray_Ptp (ndarray, int, ndarray)
    fn object PyArray_Mean (ndarray, int, int, ndarray)
    fn object PyArray_Trace (ndarray, int, int, int, int, ndarray)
    fn object PyArray_Diagonal (ndarray, int, int, i32)
    fn object PyArray_Clip (ndarray, object, object, ndarray)
    fn object PyArray_Conjugate (ndarray, ndarray)
    fn object PyArray_Nonzero (ndarray)
    fn object PyArray_Std (ndarray, int, int, ndarray, i32)
    fn object PyArray_Sum (ndarray, int, int, ndarray)
    fn object PyArray_CumSum (ndarray, int, int, ndarray)
    fn object PyArray_Prod (ndarray, int, int, ndarray)
    fn object PyArray_CumProd (ndarray, int, int, ndarray)
    fn object PyArray_All (ndarray, int, ndarray)
    fn object PyArray_Any (ndarray, int, ndarray)
    fn object PyArray_Compress (ndarray, object, int, ndarray)
    fn object PyArray_Flatten (ndarray, NPY_ORDER)
    fn object PyArray_Ravel (ndarray, NPY_ORDER)
    npy_intp PyArray_MultiplyList (npy_intp *, i32)
    fn i32 PyArray_MultiplyIntList (i32 *, i32)
    fn void * PyArray_GetPtr (ndarray, npy_intp*)
    fn i32 PyArray_CompareLists (npy_intp *, npy_intp *, i32)
    # fn i32 PyArray_AsCArray (object*, void *, npy_intp *, int, dtype)
    # fn i32 PyArray_As1D (object*, char **, i32 *, i32)
    # fn i32 PyArray_As2D (object*, char ***, i32 *, i32 *, i32)
    fn i32 PyArray_Free (object, void *)
    # fn i32 PyArray_Converter (object, object*)
    fn i32 PyArray_IntpFromSequence (object, npy_intp *, i32)
    fn object PyArray_Concatenate (object, i32)
    fn object PyArray_InnerProduct (object, object)
    fn object PyArray_MatrixProduct (object, object)
    fn object PyArray_CopyAndTranspose (object)
    fn object PyArray_Correlate (object, object, i32)
    fn i32 PyArray_TypestrConvert (i32, i32)
    # fn i32 PyArray_DescrConverter (object, dtype*)
    # fn i32 PyArray_DescrConverter2 (object, dtype*)
    fn i32 PyArray_IntpConverter (object, PyArray_Dims *)
    # fn i32 PyArray_BufferConverter (object, chunk)
    fn i32 PyArray_AxisConverter (object, i32 *)
    fn i32 PyArray_BoolConverter (object, npy_bool *)
    fn i32 PyArray_ByteorderConverter (object, char *)
    fn i32 PyArray_OrderConverter (object, NPY_ORDER *)
    u8 PyArray_EquivTypes (dtype, dtype)
    # fn object PyArray_Zeros (i32, npy_intp *, dtype, i32)
    # fn object PyArray_Empty (i32, npy_intp *, dtype, i32)
    fn object PyArray_Where (object, object, object)
    fn object PyArray_Arange (double, double, double, i32)
    # fn object PyArray_ArangeObj (object, object, object, dtype)
    fn i32 PyArray_SortkindConverter (object, NPY_SORTKIND *)
    fn object PyArray_LexSort (object, i32)
    fn object PyArray_Round (ndarray, int, ndarray)
    u8 PyArray_EquivTypenums (i32, i32)
    fn i32 PyArray_RegisterDataType (dtype)
    fn i32 PyArray_RegisterCastFunc (dtype, int, PyArray_VectorUnaryFunc *)
    fn i32 PyArray_RegisterCanCast (dtype, int, NPY_SCALARKIND)
    #void PyArray_InitArrFuncs (PyArray_ArrFuncs *)
    fn object PyArray_IntTupleFromIntp (i32, npy_intp *)
    fn i32 PyArray_TypeNumFromName (char *)
    fn i32 PyArray_ClipmodeConverter (object, NPY_CLIPMODE *)
    # fn i32 PyArray_OutputConverter (object, ndarray*)
    fn object PyArray_BroadcastToShape (object, npy_intp *, i32)
    fn void _PyArray_SigintHandler (i32)
    fn void* _PyArray_GetSigintBuf ()
    # fn i32 PyArray_DescrAlignConverter (object, dtype*)
    # fn i32 PyArray_DescrAlignConverter2 (object, dtype*)
    fn i32 PyArray_SearchsideConverter (object, void *)
    fn object PyArray_CheckAxis (ndarray, i32 *, i32)
    npy_intp PyArray_OverflowMultiplyList (npy_intp *, i32)
    fn i32 PyArray_CompareString (char *, char *, usize)
    fn i32 PyArray_SetBaseObject(ndarray, base)  # NOTE: steals a reference to base! Use "set_array_base()" instead.


# Typedefs that matches the runtime dtype objects in
# the numpy module.

# The ones that are commented out needs an IFDEF function
# in Cython to enable them only on the right systems.

ctypedef npy_int8       int8_t
ctypedef npy_int16      int16_t
ctypedef npy_int32      int32_t
ctypedef npy_int64      int64_t
#ctypedef npy_int96      int96_t
#ctypedef npy_int128     int128_t

ctypedef npy_uint8      uint8_t
ctypedef npy_uint16     uint16_t
ctypedef npy_uint32     uint32_t
ctypedef npy_uint64     uint64_t
#ctypedef npy_uint96     uint96_t
#ctypedef npy_uint128    uint128_t

ctypedef npy_float32    float32_t
ctypedef npy_float64    float64_t
#ctypedef npy_float80    float80_t
#ctypedef npy_float128   float128_t

ctypedef float complex  complex64_t
ctypedef double complex complex128_t

# The int types are mapped a bit surprising --
# numpy.int corresponds to 'l' and numpy.long to 'q'
ctypedef npy_long       int_t
ctypedef npy_longlong   longlong_t

ctypedef npy_ulong      uint_t
ctypedef npy_ulonglong  ulonglong_t

ctypedef npy_intp       intp_t
ctypedef npy_uintp      uintp_t

ctypedef npy_double     float_t
ctypedef npy_double     double_t
ctypedef npy_longdouble longdouble_t

ctypedef npy_cfloat      cfloat_t
ctypedef npy_cdouble     cdouble_t
ctypedef npy_clongdouble clongdouble_t

ctypedef npy_cdouble     complex_t

fn inline object PyArray_MultiIterNew1(a):
    return PyArray_MultiIterNew(1, <void*>a)

fn inline object PyArray_MultiIterNew2(a, b):
    return PyArray_MultiIterNew(2, <void*>a, <void*>b)

fn inline object PyArray_MultiIterNew3(a, b, c):
    return PyArray_MultiIterNew(3, <void*>a, <void*>b, <void*> c)

fn inline object PyArray_MultiIterNew4(a, b, c, d):
    return PyArray_MultiIterNew(4, <void*>a, <void*>b, <void*>c, <void*> d)

fn inline object PyArray_MultiIterNew5(a, b, c, d, e):
    return PyArray_MultiIterNew(5, <void*>a, <void*>b, <void*>c, <void*> d, <void*> e)

fn inline tuple PyDataType_SHAPE(dtype d):
    if PyDataType_HASSUBARRAY(d):
        return <tuple>d.subarray.shape
    else:
        return ()

extern from "numpy/ndarrayobject.h":
    PyTypeObject PyTimedeltaArrType_Type
    PyTypeObject PyDatetimeArrType_Type
    ctypedef int64_t npy_timedelta
    ctypedef int64_t npy_datetime

extern from "numpy/ndarraytypes.h":
    ctypedef struct PyArray_DatetimeMetaData:
        NPY_DATETIMEUNIT base
        int64_t num

extern from "numpy/arrayscalars.h":

    # abstract types
    ctypedef class numpy.generic [object PyObject]:
        pass
    ctypedef class numpy.number [object PyObject]:
        pass
    ctypedef class numpy.integer [object PyObject]:
        pass
    ctypedef class numpy.signedinteger [object PyObject]:
        pass
    ctypedef class numpy.unsignedinteger [object PyObject]:
        pass
    ctypedef class numpy.inexact [object PyObject]:
        pass
    ctypedef class numpy.floating [object PyObject]:
        pass
    ctypedef class numpy.complexfloating [object PyObject]:
        pass
    ctypedef class numpy.flexible [object PyObject]:
        pass
    ctypedef class numpy.character [object PyObject]:
        pass

    ctypedef struct PyDatetimeScalarObject:
        # PyObject_HEAD
        npy_datetime obval
        PyArray_DatetimeMetaData obmeta

    ctypedef struct PyTimedeltaScalarObject:
        # PyObject_HEAD
        npy_timedelta obval
        PyArray_DatetimeMetaData obmeta

    ctypedef enum NPY_DATETIMEUNIT:
        NPY_FR_Y
        NPY_FR_M
        NPY_FR_W
        NPY_FR_D
        NPY_FR_B
        NPY_FR_h
        NPY_FR_m
        NPY_FR_s
        NPY_FR_ms
        NPY_FR_us
        NPY_FR_ns
        NPY_FR_ps
        NPY_FR_fs
        NPY_FR_as


#
# ufunc API
#

extern from "numpy/ufuncobject.h":

    ctypedef void (*PyUFuncGenericFunction) (char **, npy_intp *, npy_intp *, void *)

    ctypedef class numpy.ufunc [object PyUFuncObject, check_size ignore]:
        cdef:
            i32 nin, nout, nargs
            i32 identity
            PyUFuncGenericFunction *functions
            void **data
            i32 ntypes
            i32 check_return
            char *name
            char *types
            char *doc
            void *ptr
            PyObject *obj
            PyObject *userloops

    cdef enum:
        PyUFunc_Zero
        PyUFunc_One
        PyUFunc_None
        UFUNC_ERR_IGNORE
        UFUNC_ERR_WARN
        UFUNC_ERR_RAISE
        UFUNC_ERR_CALL
        UFUNC_ERR_PRINT
        UFUNC_ERR_LOG
        UFUNC_MASK_DIVIDEBYZERO
        UFUNC_MASK_OVERFLOW
        UFUNC_MASK_UNDERFLOW
        UFUNC_MASK_INVALID
        UFUNC_SHIFT_DIVIDEBYZERO
        UFUNC_SHIFT_OVERFLOW
        UFUNC_SHIFT_UNDERFLOW
        UFUNC_SHIFT_INVALID
        UFUNC_FPE_DIVIDEBYZERO
        UFUNC_FPE_OVERFLOW
        UFUNC_FPE_UNDERFLOW
        UFUNC_FPE_INVALID
        UFUNC_ERR_DEFAULT
        UFUNC_ERR_DEFAULT2

    fn object PyUFunc_FromFuncAndData(PyUFuncGenericFunction *,
          void **, char *, int, int, int, int, char *, char *, i32)
    fn i32 PyUFunc_RegisterLoopForType(ufunc, int,
                                    PyUFuncGenericFunction, i32 *, void *)
    fn i32 PyUFunc_GenericFunction \
        (ufunc, PyObject *, PyObject *, PyArrayObject **)
    fn void PyUFunc_f_f_As_d_d \
         (char **, npy_intp *, npy_intp *, void *)
    fn void PyUFunc_d_d \
         (char **, npy_intp *, npy_intp *, void *)
    fn void PyUFunc_f_f \
         (char **, npy_intp *, npy_intp *, void *)
    fn void PyUFunc_g_g \
         (char **, npy_intp *, npy_intp *, void *)
    fn void PyUFunc_F_F_As_D_D \
         (char **, npy_intp *, npy_intp *, void *)
    fn void PyUFunc_F_F \
         (char **, npy_intp *, npy_intp *, void *)
    fn void PyUFunc_D_D \
         (char **, npy_intp *, npy_intp *, void *)
    fn void PyUFunc_G_G \
         (char **, npy_intp *, npy_intp *, void *)
    fn void PyUFunc_O_O \
         (char **, npy_intp *, npy_intp *, void *)
    fn void PyUFunc_ff_f_As_dd_d \
         (char **, npy_intp *, npy_intp *, void *)
    fn void PyUFunc_ff_f \
         (char **, npy_intp *, npy_intp *, void *)
    fn void PyUFunc_dd_d \
         (char **, npy_intp *, npy_intp *, void *)
    fn void PyUFunc_gg_g \
         (char **, npy_intp *, npy_intp *, void *)
    fn void PyUFunc_FF_F_As_DD_D \
         (char **, npy_intp *, npy_intp *, void *)
    fn void PyUFunc_DD_D \
         (char **, npy_intp *, npy_intp *, void *)
    fn void PyUFunc_FF_F \
         (char **, npy_intp *, npy_intp *, void *)
    fn void PyUFunc_GG_G \
         (char **, npy_intp *, npy_intp *, void *)
    fn void PyUFunc_OO_O \
         (char **, npy_intp *, npy_intp *, void *)
    fn void PyUFunc_O_O_method \
         (char **, npy_intp *, npy_intp *, void *)
    fn void PyUFunc_OO_O_method \
         (char **, npy_intp *, npy_intp *, void *)
    fn void PyUFunc_On_Om \
         (char **, npy_intp *, npy_intp *, void *)
    fn i32 PyUFunc_GetPyValues \
        (char *, i32 *, i32 *, PyObject **)
    fn i32 PyUFunc_checkfperr \
           (i32, PyObject *, i32 *)
    fn void PyUFunc_clearfperr()
    fn i32 PyUFunc_getfperr()
    fn i32 PyUFunc_handlefperr \
        (i32, PyObject *, int, i32 *)
    fn i32 PyUFunc_ReplaceLoopBySignature \
        (ufunc, PyUFuncGenericFunction, i32 *, PyUFuncGenericFunction *)
    fn object PyUFunc_FromFuncAndDataAndSignature \
             (PyUFuncGenericFunction *, void **, char *, int, int, int,
              i32, char *, char *, int, char *)

    fn i32 _import_umath() except -1

fn inline void set_array_base(ndarray arr, object base):
    Py_INCREF(base) # important to do this before stealing the reference below!
    PyArray_SetBaseObject(arr, base)

fn inline object get_array_base(ndarray arr):
    base = PyArray_BASE(arr)
    if base is NULL:
        return None
    return <object>base

# Versions of the import_* functions which are more suitable for
# Cython code.
fn inline i32 import_array() except -1:
    try:
        __pyx_import_array()
    except Exception:
        raise ImportError("numpy.core.multiarray failed to import")

fn inline i32 import_umath() except -1:
    try:
        _import_umath()
    except Exception:
        raise ImportError("numpy.core.umath failed to import")

fn inline i32 import_ufunc() except -1:
    try:
        _import_umath()
    except Exception:
        raise ImportError("numpy.core.umath failed to import")


fn inline bint is_timedelta64_object(object obj):
    """
    Cython equivalent of `isinstance(obj, np.timedelta64)`

    Parameters
    ----------
    obj : object

    Returns
    -------
    fn bool
    """
    return PyObject_TypeCheck(obj, &PyTimedeltaArrType_Type)

fn inline bint is_datetime64_object(object obj):
    """
    Cython equivalent of `isinstance(obj, np.datetime64)`

    Parameters
    ----------
    obj : object

    Returns
    -------
    fn bool
    """
    return PyObject_TypeCheck(obj, &PyDatetimeArrType_Type)

fn inline npy_datetime get_datetime64_value(object obj) nogil:
    """
    returns the int64 value underlying scalar numpy datetime64 object

    Note that to interpret this as a datetime, the corresponding unit is
    also needed.  That can be found using `get_datetime64_unit`.
    """
    return (<PyDatetimeScalarObject*>obj).obval

fn inline npy_timedelta get_timedelta64_value(object obj) nogil:
    """
    returns the int64 value underlying scalar numpy timedelta64 object
    """
    return (<PyTimedeltaScalarObject*>obj).obval

fn inline NPY_DATETIMEUNIT get_datetime64_unit(object obj) nogil:
    """
    returns the unit part of the dtype for a numpy datetime64 object.
    """
    return <NPY_DATETIMEUNIT>(<PyDatetimeScalarObject*>obj).obmeta.base
