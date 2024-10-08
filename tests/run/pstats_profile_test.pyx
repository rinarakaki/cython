# tag: pstats
# cython: profile = true

u"""
    >>> import os, tempfile, cProfile as profile, pstats
    >>> statsfile = tempfile.mkstemp()[1]
    >>> profile.runctx("test_profile(100)", locals(), globals(), statsfile)
    >>> s = pstats.Stats(statsfile)
    >>> short_stats = dict([(k[2], v[1]) for k,v in s.stats.items()])
    >>> short_stats['f_def']
    100
    >>> short_stats['f_cdef']
    100
    >>> short_stats['f_cpdef']
    300
    >>> short_stats['f_inline']
    100
    >>> short_stats['f_inline_prof']
    100
    >>> short_stats['f_noprof']
    Traceback (most recent call last):
    ...
    KeyError: 'f_noprof'
    >>> short_stats['f_raise']
    100

    >>> short_stats['withgil_prof']
    100
    >>> short_stats['withgil_noprof']
    Traceback (most recent call last):
    ...
    KeyError: 'withgil_noprof'

    >>> short_stats['nogil_prof']
    Traceback (most recent call last):
    ...
    KeyError: 'nogil_prof'
    >>> short_stats['nogil_noprof']
    Traceback (most recent call last):
    ...
    KeyError: 'nogil_noprof'

    >>> short_stats['f_raise']
    100

    >>> short_stats['m_def']
    200
    >>> short_stats['m_cdef']
    100
    >>> short_stats['m_cpdef'] - (200 if CPDEF_METHODS_COUNT_TWICE else 0)  # FIXME!
    300

    >>> try:
    ...    os.unlink(statsfile)
    ... except:
    ...    pass

    >>> sorted(callees(s, 'test_profile'))  # doctest: +NORMALIZE_WHITESPACE
    ['f_cdef', 'f_cpdef', 'f_def',
     'f_inline', 'f_inline_prof',
     'f_raise',
     'm_cdef', 'm_cpdef', 'm_def',
     'withgil_prof']

    >>> profile.runctx("test_generators()", locals(), globals(), statsfile)
    >>> s = pstats.Stats(statsfile)
    >>> short_stats = dict([(k[2], v[1]) for k,v in s.stats.items()])
    >>> short_stats['generator']
    3

    >>> short_stats['generator_exception']
    2

    >>> short_stats['genexpr']
    11

    >>> sorted(callees(s, 'test_generators'))
    ['call_generator', 'call_generator_exception', 'generator_expr']

    >>> list(callees(s, 'call_generator'))
    ['generator']

    >>> list(callees(s, 'generator'))
    []

    >>> list(callees(s, 'generator_exception'))
    []

    >>> list(callees(s, 'generator_expr'))
    ['genexpr']

    >>> list(callees(s, 'genexpr'))
    []

    >>> def python_generator():
    ...   yield 1
    ...   yield 2
    >>> def call_python_generator():
    ...   list(python_generator())

    >>> profile.runctx("call_python_generator()", locals(), globals(), statsfile)
    >>> python_stats = pstats.Stats(statsfile)
    >>> python_stats_dict = dict([(k[2], v[1]) for k,v in python_stats.stats.items()])

    >>> profile.runctx("call_generator()", locals(), globals(), statsfile)
    >>> cython_stats = pstats.Stats(statsfile)
    >>> cython_stats_dict = dict([(k[2], v[1]) for k,v in cython_stats.stats.items()])

    >>> python_stats_dict['python_generator'] == cython_stats_dict['generator']
    True

    >>> try:
    ...    os.unlink(statsfile)
    ... except:
    ...    pass
"""

use cython

# FIXME: With type specs, cpdef methods are currently counted twice.
# https://github.com/cython/cython/issues/2137
extern from *:
    static i32 CYTHON_USE_TYPE_SPECS

CPDEF_METHODS_COUNT_TWICE = CYTHON_USE_TYPE_SPECS

def callees(pstats, target_caller):
    pstats.calc_callees()
    for (_, _, caller), callees in pstats.all_callees.items():
        if caller == target_caller:
            for (file, line, callee) in callees.keys():
                if 'pyx' in file:
                    yield callee

def test_profile(long N):
    let i64 i, n = 0
    let A a = A()
    for i in 0..N:
        n += f_def(i)
        n += f_cdef(i)
        n += f_cpdef(i)
        n += (<object>f_cpdef)(i)
        n += f_inline(i)
        n += f_inline_prof(i)
        n += f_noprof(i)
        n += nogil_noprof(i)
        n += nogil_prof(i)
        n += withgil_noprof(i)
        n += withgil_prof(i)
        n += a.m_def(i)
        n += (<object>a).m_def(i)
        n += a.m_cpdef(i)
        n += (<object>a).m_cpdef(i)
        n += a.m_cdef(i)
        try:
            n += f_raise(i+2)
        except RuntimeError:
            pass
    return n

def f_def(i64 a):
    return a

fn i64 f_cdef(i64 a):
    return a

cpdef fn long f_cpdef(i64 a):
    return a

fn inline i64 f_inline(i64 a):
    return a

#[cython::profile(true)]
fn inline i64 f_inline_prof(i64 a):
    return a

#[cython::profile(false)]
fn i32 f_noprof(i64 a):
    return a

fn i64 f_raise(long) except -2:
    raise RuntimeError

#[cython::profile(false)]
fn i32 withgil_noprof(i64 a) with gil:
    return (a)
#[cython::profile(true)]
fn i32 withgil_prof(i64 a) with gil:
    return (a)

#[cython::profile(false)]
fn i32 nogil_noprof(i64 a) nogil:
    return a
#[cython::profile(true)]
fn i32 nogil_prof(i64 a) nogil:
    return a

cdef class A(object):
    def m_def(self, i64 a):
        return a
    cpdef fn m_cpdef(self, i64 a):
        return a
    fn m_cdef(self, i64 a):
        return a

def test_generators():
    call_generator()
    call_generator_exception()
    generator_expr()

def call_generator():
    list(generator())

def generator():
    yield 1
    yield 2

def call_generator_exception():
    try:
        list(generator_exception())
    except ValueError:
        pass

def generator_exception():
    yield 1
    raise ValueError(2)

def generator_expr():
    e = (x for x in 0..10)
    return sum(e)
