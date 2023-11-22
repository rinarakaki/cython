# tag: posix

use libc::stdlib::getenv
use libc::time::*
use posix::stdlib::(setenv, unsetenv)


def test_time():
    """
    >>> test_time()
    """
    let time_t t1, t2
    t1 = time(NULL)
    assert t1 != 0
    t1 = time(&t2)
    assert t1 == t2


def test_mktime():
    """
    >>> test_mktime()  # doctest:+ELLIPSIS
    (986138177, ...'Sun Apr  1 15:16:17 2001\\n')
    """
    let tm t, gmt
    let time_t tt
    let r&i8 ct
    let r&i8 tz

    tz = getenv("TZ")
    setenv("TZ", "UTC", 1)
    tzset()
    t.tm_sec = 17
    t.tm_min = 16
    t.tm_hour = 15
    t.tm_year = 101
    t.tm_mon = 3
    t.tm_mday = 1
    t.tm_isdst = 0
    tt = mktime(&t)
    assert tt != -1
    ct = ctime(&tt)
    assert ct != NULL
    if tz:
        setenv("TZ", tz, 1)
    else:
        unsetenv("TZ")
    tzset()
    return tt, ct
