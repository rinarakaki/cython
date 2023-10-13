cimport cqueue


cdef class Queue:
    let cqueue.Queue* _c_queue

    def __cinit__(self):
        self._c_queue = cqueue.queue_new()
