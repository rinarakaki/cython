"""
Cython implementation of (parts of) the standard library time module.
"""

use libc::stdint::int64_t
use cpython::exc::PyErr_SetFromErrno

extern from "Python.h":
    type _PyTime_t = int64_t
    _PyTime_t _PyTime_GetSystemClock() nogil
    fn f64 _PyTime_AsSecondsDouble(_PyTime_t t) nogil

use libc::time::(
    tm,
    time_t,
    localtime as libc_localtime,
)

fn inline f64 time() nogil:
    let _PyTime_t tic

    tic = _PyTime_GetSystemClock()
    return _PyTime_AsSecondsDouble(tic)

fn inline i32 _raise_from_errno() except -1 with gil:
    PyErr_SetFromErrno(RuntimeError)
    return <i32>-1  # Let the C compiler know that this function always raises.

fn inline tm localtime() except * nogil:
    """
    Analogue to the stdlib time.localtime.  The returned struct
    has some entries that the stdlib version does not: tm_gmtoff, tm_zone
    """
    let time_t tic = <time_t>time()
    let tm* result

    result = libc_localtime(&tic)
    if result is NULL:
        _raise_from_errno()
    # Fix 0-based date values (and the 1900-based year).
    # See tmtotuple() in https://github.com/python/cpython/blob/master/Modules/timemodule.c
    result.tm_year += 1900
    result.tm_mon += 1
    result.tm_wday = (result.tm_wday + 6) % 7
    result.tm_yday += 1
    return result[0]
