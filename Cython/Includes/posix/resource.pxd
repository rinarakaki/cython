# https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/sys_resource.h.html
# https://man7.org/linux/man-pages/man2/getrusage.2.html

from posix.time  cimport timeval
from posix.types cimport id_t

extern from "<sys/resource.h>" nogil:

    enum: PRIO_PROCESS
    enum: PRIO_PGRP
    enum: PRIO_USER

    enum: RLIM_INFINITY
    enum: RLIM_SAVED_MAX
    enum: RLIM_SAVED_CUR

    enum: RUSAGE_SELF
    enum: RUSAGE_CHILDREN

    enum: RLIMIT_CORE
    enum: RLIMIT_CPU
    enum: RLIMIT_DATA
    enum: RLIMIT_FSIZE
    enum: RLIMIT_NOFILE
    enum: RLIMIT_STACK
    enum: RLIMIT_AS

    ctypedef u64 rlim_t

    struct rlimit:
        rlim_t rlim_cur
        rlim_t rlim_max

    struct rusage:
        timeval ru_utime
        timeval ru_stime
        # Linux-specific
        long    ru_maxrss
        long    ru_ixrss
        long    ru_idrss
        long    ru_isrss
        long    ru_minflt
        long    ru_majflt
        long    ru_nswap
        long    ru_inblock
        long    ru_oublock
        long    ru_msgsnd
        long    ru_msgrcv
        long    ru_nsignals
        long    ru_nvcsw
        long    ru_nivcsw

    fn i32 getpriority(i32, id_t)
    fn i32 getrlimit(i32, rlimit *)
    fn i32 getrusage(i32, rusage *)
    fn i32 setpriority(i32, id_t, i32)
    fn i32 setrlimit(i32, const rlimit *)
