# https://en.wikipedia.org/wiki/C_date_and_time_functions

use libc::stddef::wchar_t

extern from "<time.h>" nogil:
    type clock_t = i64
    type time_t = i64

    enum: CLOCKS_PER_SEC
    fn clock_t clock()             # CPU time
    fn time_t time(time_t*)      # wall clock time since Unix epoch

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
        # char* tm_zone
        # long tm_gmtoff

    static i32 daylight            # global state
    static i64 timezone
    static char* tzname[2]
    fn void tzset()

    fn char* asctime(const tm*)
    fn char* asctime_r(const tm*, char*)
    fn char* ctime(const time_t*)
    fn char* ctime_r(const time_t*, char*)
    fn f64 difftime(time_t, time_t)
    fn tm* getdate(const char*)
    fn tm* gmtime(const time_t*)
    fn tm* gmtime_r(const time_t*, tm*)
    fn tm* localtime(const time_t*)
    fn tm* localtime_r(const time_t*, tm*)
    fn time_t mktime(tm*)
    fn usize strftime(char*, usize, const char*, const tm*)
    fn usize wcsftime(wchar_t* str, usize cnt, const wchar_t* fmt, tm* time)

    # POSIX not stdC
    fn char* strptime(const char*, const char*, tm*)
