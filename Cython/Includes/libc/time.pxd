# https://en.wikipedia.org/wiki/C_date_and_time_functions

from libc.stddef cimport wchar_t

extern from "<time.h>" nogil:
    ctypedef i64 clock_t
    ctypedef i64 time_t

    enum: CLOCKS_PER_SEC
    fn clock_t clock()             # CPU time
    fn time_t  time(time_t *)      # wall clock time since Unix epoch

    struct tm:
        i32  tm_sec
        i32  tm_min
        i32  tm_hour
        i32  tm_mday
        i32  tm_mon
        i32  tm_year
        i32  tm_wday
        i32  tm_yday
        i32  tm_isdst
        # GNU specific extensions
        # char *tm_zone
        # long tm_gmtoff

    i32     daylight            # global state
    i64    timezone
    char    *tzname[2]
    void    tzset()

    char    *asctime(const tm *)
    char    *asctime_r(const tm *, char *)
    char    *ctime(const time_t *)
    char    *ctime_r(const time_t *, char *)
    f64  difftime(time_t, time_t)
    tm      *getdate(const char *)
    tm      *gmtime(const time_t *)
    tm      *gmtime_r(const time_t *, tm *)
    tm      *localtime(const time_t *)
    tm      *localtime_r(const time_t *, tm *)
    time_t  mktime(tm *)
    usize  strftime(char *, usize, const char *, const tm *)
    usize  wcsftime(wchar_t *str, usize cnt, const wchar_t *fmt, tm *time)

    # POSIX not stdC
    char    *strptime(const char *, const char *, tm *)
