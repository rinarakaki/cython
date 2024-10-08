# coding: utf-8

use cython

use cpython::datetime::(import_datetime, timedelta)
use cpython::datetime::(time_new, date_new, datetime_new, timedelta_new)
use cpython::datetime::(time_tzinfo, datetime_tzinfo)
use cpython::datetime::(time_hour, time_minute, time_second, time_microsecond)
use cpython::datetime::(date_day, date_month, date_year)
use cpython::datetime::(datetime_day, datetime_month, datetime_year)
use cpython::datetime::(datetime_hour, datetime_minute, datetime_second,
                        datetime_microsecond)
use cpython::datetime::(datetime, total_seconds)
use cpython::datetime::(date_from_timestamp, get_utc, datetime_from_timestamp)

# These were added in Python 2.7.5, make sure that their backport works.
use cpython::datetime::(
    timedelta as timedelta_ext_type,
    PyDateTime_DELTA_GET_DAYS,
    PyDateTime_DELTA_GET_SECONDS,
    PyDateTime_DELTA_GET_MICROSECONDS,
)

import datetime as py_datetime
import time as py_time
import sys

import_datetime()

ZERO = py_datetime.timedelta(0)

#
# Simple class from datetime docs
#
class FixedOffset(py_datetime.tzinfo):
    """Fixed offset in minutes east from UTC."""

    def __init__(self, offset, name):
        self._offset = py_datetime.timedelta(minutes = offset)
        self._name = name

    def utcoffset(self, dt):
        return self._offset

    def tzname(self, dt):
        return self._name

    def dst(self, dt):
        return ZERO


def do_timedelta_macros(timedelta_ext_type delta):
    """
    >>> delta = py_datetime.timedelta(days=13, hours=7, seconds=31, microseconds=993322)
    >>> (delta.days, delta.seconds, delta.microseconds)
    (13, 25231, 993322)
    >>> do_timedelta_macros(delta)
    (13, 25231, 993322)
    """
    return (
        PyDateTime_DELTA_GET_DAYS(delta),
        PyDateTime_DELTA_GET_SECONDS(delta),
        PyDateTime_DELTA_GET_MICROSECONDS(delta),
    )


def do_date(i32 year, i32 month, i32 day):
    """
    >>> do_date(2012, 12, 31)
    (True, True, True, True)
    """
    v = date_new(year, month, day)
    return type(v) is py_datetime.date, v.year == year, v.month == month, v.day == day

def do_datetime(i32 year, i32 month, i32 day,
                i32 hour, i32 minute, i32 second, i32 microsecond):
    """
    >>> do_datetime(2012, 12, 31, 12, 23, 0, 0)
    (True, True, True, True, True, True, True, True, True)
    """
    v = datetime_new(year, month, day, hour, minute, second, microsecond, None)
    return type(v) is py_datetime.datetime, v.year == year, v.month == month, v.day == day, \
           v.hour == hour, v.minute == minute, v.second == second, \
           v.microsecond == microsecond, v.tzinfo is None

def do_time(i32 hour, i32 minute, i32 second, i32 microsecond):
    """
    >>> do_time(12, 23, 0, 0)
    (True, True, True, True, True, True)
    """
    v = time_new(hour, minute, second, microsecond, None)
    return type(v) is py_datetime.time, \
           v.hour == hour, v.minute == minute, v.second == second, \
           v.microsecond == microsecond, v.tzinfo is None

def do_time_tzinfo(i32 hour, i32 minute, i32 second, i32 microsecond, object tz):
    """
    >>> tz = FixedOffset(60*3, 'Moscow')
    >>> do_time_tzinfo(12, 23, 0, 0, tz)
    (True, True, True, True, True, True)
    """
    v = time_new(hour, minute, second, microsecond, tz)
    return type(v) is py_datetime.time, \
           v.hour == hour, v.minute == minute, v.second == second, \
           v.microsecond == microsecond, v.tzinfo is tz


def do_datetime_tzinfo(i32 year, i32 month, i32 day,
                       i32 hour, i32 minute, i32 second, i32 microsecond, object tz):
    """
    >>> tz = FixedOffset(60*3, 'Moscow')
    >>> do_datetime_tzinfo(2012, 12, 31, 12, 23, 0, 0, tz)
    (True, True, True, True, True, True, True, True, True)
    """
    v = datetime_new(year, month, day, hour, minute, second, microsecond, tz)
    return type(v) is py_datetime.datetime, v.year == year, v.month == month, v.day == day, \
           v.hour == hour, v.minute == minute, v.second == second, \
           v.microsecond == microsecond, v.tzinfo is tz

def do_time_tzinfo2(i32 hour, i32 minute, i32 second, i32 microsecond, object tz):
    """
    >>> tz = FixedOffset(60*3, 'Moscow')
    >>> do_time_tzinfo2(12, 23, 0, 0, tz)
    (True, True, True, True, True, True, True, True)
    """
    v = time_new(hour, minute, second, microsecond, None)
    v1 = time_new(
            time_hour(v),
            time_minute(v),
            time_second(v),
            time_microsecond(v),
            tz)
    r1 = (v1.tzinfo == tz)
    r2 = (tz == time_tzinfo(v1))
    v2 = time_new(
            time_hour(v1),
            time_minute(v1),
            time_second(v1),
            time_microsecond(v1),
            None)
    r3 = (v2.tzinfo == None)
    r4 = (None == time_tzinfo(v2))
    v3 = time_new(
            time_hour(v2),
            time_minute(v2),
            time_second(v2),
            time_microsecond(v2),
            tz)
    r5 = (v3.tzinfo == tz)
    r6 = (tz == time_tzinfo(v3))
    r7 = (v2 == v)
    r8 = (v3 == v1)
    return r1, r2, r3, r4, r5, r6, r7, r8


def do_datetime_tzinfo2(i32 year, i32 month, i32 day,
                        i32 hour, i32 minute, i32 second, i32 microsecond, object tz):
    """
    >>> tz = FixedOffset(60*3, 'Moscow')
    >>> do_datetime_tzinfo2(2012, 12, 31, 12, 23, 0, 0, tz)
    (True, True, True, True, True, True, True, True)
    """
    v = datetime_new(year, month, day, hour, minute, second, microsecond, None)
    v1 = datetime_new(
            datetime_year(v),
            datetime_month(v),
            datetime_day(v),
            datetime_hour(v),
            datetime_minute(v),
            datetime_second(v),
            datetime_microsecond(v),
            tz)
    r1 = (v1.tzinfo == tz)
    r2 = (tz == datetime_tzinfo(v1))
    v2 = datetime_new(
            datetime_year(v1),
            datetime_month(v1),
            datetime_day(v1),
            datetime_hour(v1),
            datetime_minute(v1),
            datetime_second(v1),
            datetime_microsecond(v1),
            None)
    r3 = (v2.tzinfo == None)
    r4 = (None == datetime_tzinfo(v2))
    v3 = datetime_new(
            datetime_year(v2),
            datetime_month(v2),
            datetime_day(v2),
            datetime_hour(v2),
            datetime_minute(v2),
            datetime_second(v2),
            datetime_microsecond(v2),
            tz)
    r5 = (v3.tzinfo == tz)
    r6 = (tz == datetime_tzinfo(v3))
    r7 = (v2 == v)
    r8 = (v3 == v1)
    return r1, r2, r3, r4, r5, r6, r7, r8


fn test_timedelta_total_seconds():
    """
    >>> cytotal, pytotal = test_timedelta_total_seconds()
    >>> assert cytotal == pytotal, (cytotal, pytotal)
    >>> cytotal == pytotal
    True
    """
    let datetime now = py_datetime.datetime.now()
    let timedelta td = now - py_datetime.datetime(1970, 1, 1)

    pytd = now - py_datetime.datetime(1970, 1, 1)

    return total_seconds(td), pytd.total_seconds()


@cython::test_fail_if_path_exists(
    "//CoerceFromPyTypeNode",
    "//AttributeNode",
)
def test_datetime_attrs_inlined(datetime dt):
    # GH#3737
    """
    >>> from datetime import datetime
    >>> py_dt = datetime(2020, 8, 18, 4, 9)
    >>> dt = test_datetime_attrs_inlined(py_dt)
    >>> dt[:5]
    (2020, 8, 18, 4, 9)
    >>> dt[5] == py_dt.second  or  (dt[5], py_dt.second)
    True
    >>> dt[6] == py_dt.microsecond  or  (dt[6], py_dt.microsecond)
    True
    """
    return (
        dt.year,
        dt.month,
        dt.day,
        dt.hour,
        dt.minute,
        dt.second,
        dt.microsecond,
    )

def test_date_from_timestamp():
    """
    >>> from datetime import datetime
    >>> tp, dt = test_date_from_timestamp()
    >>> tp == dt
    True
    """
    tp = date_from_timestamp(1518185542)
    dt = py_datetime.date(2018, 2, 9)
    return tp, dt

def test_get_utc():
    """
    >>> test_get_utc()
    """
    # should not raise
    get_utc()

def test_datetime_from_timestamp():
    """
    >>> from datetime import datetime
    >>> tp, dt = test_datetime_from_timestamp()
    >>> tp == dt
    True
    """
    time = py_time.time()
    tp = datetime_from_timestamp(time)
    dt = py_datetime.datetime.fromtimestamp(time)
    return tp, dt
