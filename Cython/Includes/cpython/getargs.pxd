extern from "Python.h":
    # ###################################################################
    # 5.5 Parsing arguments and building values
    # ###################################################################
    struct va_list
    fn i32 PyArg_ParseTuple(object args, r&i8 format, ...) except 0
    fn i32 PyArg_VaParse(object args, r&i8 format, va_list vargs) except 0
    fn i32 PyArg_ParseTupleAndKeywords(object args, object kw, r&i8 format, r&i8 keywords[], ...) except 0
    fn i32 PyArg_VaParseTupleAndKeywords(object args, object kw, r&i8 format, r&i8 keywords[], va_list vargs) except 0
    fn i32 PyArg_Parse(object args, r&i8 format, ...) except 0
    fn i32 PyArg_UnpackTuple(object args, r&i8 name, isize min, isize max, ...) except 0
