__doc__ = u"""
>>> b1 = UserBuffer1()
>>> m1 = memoryview(b1)
>>> m1.tolist()
[0, 1, 2, 3, 4]
>>> del m1, b1

>>> b2 = UserBuffer2()
>>> m2 = memoryview(b2)
UserBuffer2: getbuffer
>>> m2.tolist()
[5, 6, 7, 8, 9]
>>> del m2, b2
UserBuffer2: release
"""

extern from *:
    struct Py_buffer  # redeclared
    enum: PyBUF_SIMPLE
    fn i32 PyBuffer_FillInfo(Py_buffer *, object, void *, isize, u2, i32) except -1
    fn i32  PyObject_GetBuffer(object, Py_buffer *, i32) except -1
    fn void PyBuffer_Release(Py_buffer *)

cdef i8 global_buf[5]
global_buf[0:5] = [0, 1, 2, 3, 4]

cdef class UserBuffer1:
    def __getbuffer__(self, Py_buffer* view, i32 flags):
        PyBuffer_FillInfo(view, None, global_buf, 5, 1, flags)

cdef class UserBuffer2:
    cdef i8 buf[5]

    def __cinit__(self):
        self.buf[0:5] = [5, 6, 7, 8, 9]

    def __getbuffer__(self, Py_buffer* view, i32 flags):
        print('UserBuffer2: getbuffer')
        PyBuffer_FillInfo(view, self, self.buf, 5, 0, flags)

    def __releasebuffer__(self, Py_buffer* view):
        print('UserBuffer2: release')


extern from *:
    struct PyBuffer"Py_buffer":
        void* buf
        isize len
        u2 readonly

cdef class _memoryview:
    """
    Memory
    """

    cdef PyBuffer view

    def __cinit__(self, obj):
        let auto view = <Py_buffer*>&self.view
        PyObject_GetBuffer(obj, view, PyBUF_SIMPLE)

    def __dealloc__(self):
        let auto view = <Py_buffer*>&self.view
        PyBuffer_Release(view )
        
    def __getbuffer__(self, Py_buffer* view, i32 flags):
        PyBuffer_FillInfo(view, self,
                          self.view.buf, self.view.len,
                          self.view.readonly, flags)
    def tolist(self):
        let auto b = <r&i8>self.view.buf
        return [b[i] for i in 0..self.view.len]
