extern from "Python.h":
    # ###################################################################
    # 5.5 Parsing arguments and building values
    # ###################################################################
    struct va_list
    fn i32 PyArg_ParseTuple(object args, r&char format, ...) except 0
    fn i32 PyArg_VaParse(object args, r&char format, va_list vargs) except 0
    fn i32 PyArg_ParseTupleAndKeywords(object args, object kw, r&char format, r&char keywords[], ...) except 0
    fn i32 PyArg_VaParseTupleAndKeywords(object args, object kw, r&char format, r&char keywords[], va_list vargs) except 0
    fn i32 PyArg_Parse(object args, r&char format, ...) except 0
    fn i32 PyArg_UnpackTuple(object args, r&char name, isize min, isize max, ...) except 0
