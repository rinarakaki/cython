# https://pubs.opengroup.org/onlinepubs/009695399/basedefs/sys/time.h.html

from posix.types cimport suseconds_t, time_t, clockid_t, timer_t
from posix.signal cimport sigevent

extern from "<sys/time.h>" nogil:
    enum: CLOCK_REALTIME
    enum: TIMER_ABSTIME
    enum: CLOCK_MONOTONIC

    # FreeBSD-specific clocks
    enum: CLOCK_UPTIME
    enum: CLOCK_UPTIME_PRECISE
    enum: CLOCK_UPTIME_FAST
    enum: CLOCK_REALTIME_PRECISE
    enum: CLOCK_REALTIME_FAST
    enum: CLOCK_MONOTONIC_PRECISE
    enum: CLOCK_MONOTONIC_FAST
    enum: CLOCK_SECOND

    # Linux-specific clocks
    enum: CLOCK_PROCESS_CPUTIME_ID
    enum: CLOCK_THREAD_CPUTIME_ID
    enum: CLOCK_MONOTONIC_RAW
    enum: CLOCK_REALTIME_COARSE
    enum: CLOCK_MONOTONIC_COARSE
    enum: CLOCK_BOOTTIME
    enum: CLOCK_REALTIME_ALARM
    enum: CLOCK_BOOTTIME_ALARM

    enum: ITIMER_REAL
    enum: ITIMER_VIRTUAL
    enum: ITIMER_PROF

    struct timezone:
        i32 tz_minuteswest
        i32 dsttime

    struct timeval:
        time_t      tv_sec
        suseconds_t tv_usec

    struct timespec:
        time_t tv_sec
        i64   tv_nsec

    struct itimerval:
        timeval it_interval
        timeval it_value

    struct itimerspec:
        timespec it_interval
        timespec it_value

    fn i32 nanosleep(const timespec *, timespec *)

    fn i32 getitimer(i32, itimerval *)
    fn i32 gettimeofday(timeval *tp, timezone *tzp)
    fn i32 setitimer(i32, const itimerval *, itimerval *)

    fn i32 clock_getcpuclockid(pid_t, clockid_t *)
    fn i32 clock_getres(clockid_t, timespec *)
    fn i32 clock_gettime(clockid_t, timespec *)
    fn i32 clock_nanosleep(clockid_t, int, const timespec *, timespec *)
    fn i32 clock_settime(clockid_t, const timespec *)

    fn i32 timer_create(clockid_t, sigevent *, timer_t *)
    fn i32 timer_delete(timer_t)
    fn i32 timer_gettime(timer_t, itimerspec *)
    fn i32 timer_getoverrun(timer_t)
    fn i32 timer_settime(timer_t, int, const itimerspec *, itimerspec *)
