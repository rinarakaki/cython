# coding: utf-8

use cpython::datetime::import_datetime
use cpython::datetime::(date, time, datetime, timedelta, timezone_new, PyDateTime_IMPORT)

import sys

import_datetime()

def test_date(i32 year, i32 month, i32 day):
    '''
    >>> val = test_date(2012, 12, 31)
    >>> print(val)
    2012-12-31
    '''
    val = date(year, month, day)
    return val

def test_time(i32 hour, i32 minute, i32 second, i32 microsecond):
    '''
    >>> val = test_time(12, 20, 55, 0)
    >>> print(val)
    12:20:55
    '''
    val = time(hour, minute, second, microsecond)
    return val

def test_datetime(i32 year, i32 month, i32 day, i32 hour, i32 minute, i32 second, i32 microsecond):
    '''
    >>> val = test_datetime(2012, 12, 31, 12, 20, 55, 0)
    >>> print(val)
    2012-12-31 12:20:55
    '''
    val = datetime(year, month, day, hour, minute, second, microsecond)
    return val

def test_timedelta(i32 days, i32 seconds, i32 useconds):
    '''
    >>> val = test_timedelta(30, 0, 0)
    >>> print(val)
    30 days, 0:00:00
    '''
    val = timedelta(days, seconds, useconds)
    return val

def test_timezone(i32 days, i32 seconds, i32 useconds, str name):
    '''
    >>> test_timezone(0, 3600, 0, 'CET')
    '''
    # should not raise
    timezone_new(timedelta(days, seconds, useconds), name)
