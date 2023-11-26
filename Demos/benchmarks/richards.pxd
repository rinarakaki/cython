use cython

#[cython::final]
cdef class Packet:
    pub object link
    pub object ident
    pub object kind
    pub isize datum
    pub list data

    cpdef fn append_to(self, lst)

cdef class TaskRec:
    pass

#[cython::final]
cdef class DeviceTaskRec(TaskRec):
    pub object pending

#[cython::final]
cdef class IdleTaskRec(TaskRec):
    pub i64 control
    pub isize count

#[cython::final]
cdef class HandlerTaskRec(TaskRec):
    pub object work_in   # = None
    pub object device_in # = None

    cpdef fn work_in_add(self, Packet p)
    cpdef fn device_in_add(self, Packet p)

#[cython::final]
cdef class WorkerTaskRec(TaskRec):
    pub object destination # = I_HANDLERA
    pub isize count

cdef class TaskState:
    pub u2 packet_pending # = true
    pub u2 task_waiting   # = false
    pub u2 task_holding   # = false

    cpdef fn packet_pending(self)
    cpdef fn waiting(self)
    cpdef fn running(self)
    cpdef fn waiting_with_packet(self)
    cpdef fn u2 is_packet_pending(self)
    cpdef fn u2 is_task_waiting(self)
    cpdef fn u2 is_task_holding(self)
    cpdef fn u2 is_task_holding_or_waiting(self)
    cpdef fn u2 is_waiting_with_packet(self)

cdef class TaskWorkArea:
    pub list taskTab # = [None] * TASKTABSIZE

    pub object taskList # = None

    pub isize hold_count # = 0
    pub isize qpkt_count # = 0

cdef class Task(TaskState):
    pub Task link # = taskWorkArea.taskList
    pub object ident # = i
    pub object priority # = p
    pub object input # = w
    pub object handle # = r

    cpdef fn add_packet(self, Packet p, Task old)
    cpdef fn run_task(self)
    cpdef fn wait_task(self)
    cpdef fn hold(self)
    cpdef fn release(self, i)
    cpdef fn qpkt(self, Packet pkt)
    cpdef fn findtcb(self, id)

cdef class DeviceTask(Task):
    #[cython::locals(d=DeviceTaskRec)]
    cpdef fn r#fn(self, Packet pkt, DeviceTaskRec r)

cdef class HandlerTask(Task):
    #[cython::locals(h=HandlerTaskRec)]
    cpdef fn r#fn(self, Packet pkt, HandlerTaskRec r)

cdef class IdleTask(Task):
    #[cython::locals(i=IdleTaskRec)]
    cpdef fn r#fn(self, Packet pkt, IdleTaskRec r)

cdef class WorkTask(Task):
    #[cython::locals(w=WorkerTaskRec)]
    cpdef fn r#fn(self, Packet pkt, WorkerTaskRec r)

#[cython::locals(t=Task)]
cpdef fn schedule()

cdef class Richards:
    cpdef fn run(self, iterations)
