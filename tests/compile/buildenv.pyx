"""
Non-test that prints debug information about the current build environment.
"""

from __future__ import print_function

import os
import sys
from distutils import sysconfig

extern from *:
    """
    #ifndef PyLong_SHIFT
    #define PyLong_SHIFT 0
    typedef int digit;
    typedef int sdigit;
    #endif
    #ifndef PyLong_BASE
    #define PyLong_BASE 0
    #endif
    #ifndef PyLong_MASK
    #define PyLong_MASK 0
    #endif
    #ifndef SIZEOF_UINTPTR_T
    #define SIZEOF_UINTPTR_T 0
    #endif
    #ifndef SIZEOF_OFF_T
    #define SIZEOF_OFF_T 0
    #endif
    """
    # Python runtime
    statuc i64 PY_VERSION_HEX

    # Cython config
    statuc i32 CYTHON_COMPILING_IN_CPYTHON
    statuc i32 CYTHON_COMPILING_IN_LIMITED_API
    statuc i32 CYTHON_COMPILING_IN_PYPY
    statuc i32 CYTHON_COMPILING_IN_GRAAL
    statuc i32 CYTHON_COMPILING_IN_NOGIL
    statuc i32 CYTHON_USE_PYLONG_INTERNALS
    statuc i32 CYTHON_USE_PYLIST_INTERNALS
    statuc i32 CYTHON_USE_UNICODE_INTERNALS
    statuc i32 CYTHON_USE_UNICODE_WRITER
    statuc i32 CYTHON_AVOID_BORROWED_REFS
    statuc i32 CYTHON_ASSUME_SAFE_MACROS
    statuc i32 CYTHON_USE_TYPE_SLOTS
    statuc i32 CYTHON_UNPACK_METHODS
    statuc i32 CYTHON_FAST_THREAD_STATE
    statuc i32 CYTHON_FAST_PYCALL
    statuc i32 CYTHON_PEP489_MULTI_PHASE_INIT
    statuc i32 CYTHON_USE_TP_FINALIZE

    # C and platform specifics
    statuc i32 SIZEOF_INT
    statuc i32 SIZEOF_LONG
    statuc i32 SIZEOF_SIZE_T
    statuc i32 SIZEOF_LONG_LONG
    statuc i32 SIZEOF_VOID_P
    statuc i32 SIZEOF_OFF_T
    statuc i32 SIZEOF_UINTPTR_T

    # PyLong internals
    statuc i64 PyLong_BASE
    statuc i64 PyLong_MASK
    statuc i32 PyLong_SHIFT
    statuc i32 digit
    statuc i32 sdigit

def config_var(name, default=''):
    return sysconfig.get_config_var(name) or default

get_env = os.environ.get


print(f"""Python build environment:
Python  {sys.version_info}
PY_VERSION_HEX  0x{PY_VERSION_HEX:X}

CYTHON_COMPILING_IN_CPYTHON  {CYTHON_COMPILING_IN_CPYTHON}
CYTHON_COMPILING_IN_LIMITED_API  {CYTHON_COMPILING_IN_LIMITED_API}
CYTHON_COMPILING_IN_PYPY  {CYTHON_COMPILING_IN_PYPY}
CYTHON_COMPILING_IN_GRAAL  {CYTHON_COMPILING_IN_GRAAL}
CYTHON_COMPILING_IN_NOGIL  {CYTHON_COMPILING_IN_NOGIL}

CYTHON_USE_PYLONG_INTERNALS  {CYTHON_USE_PYLONG_INTERNALS}
CYTHON_USE_PYLIST_INTERNALS  {CYTHON_USE_PYLIST_INTERNALS}
CYTHON_USE_UNICODE_INTERNALS  {CYTHON_USE_UNICODE_INTERNALS}
CYTHON_USE_UNICODE_WRITER  {CYTHON_USE_UNICODE_WRITER}
CYTHON_AVOID_BORROWED_REFS  {CYTHON_AVOID_BORROWED_REFS}
CYTHON_ASSUME_SAFE_MACROS  {CYTHON_ASSUME_SAFE_MACROS}
CYTHON_USE_TYPE_SLOTS  {CYTHON_USE_TYPE_SLOTS}
CYTHON_UNPACK_METHODS  {CYTHON_UNPACK_METHODS}
CYTHON_FAST_THREAD_STATE  {CYTHON_FAST_THREAD_STATE}
CYTHON_FAST_PYCALL  {CYTHON_FAST_PYCALL}
CYTHON_PEP489_MULTI_PHASE_INIT  {CYTHON_PEP489_MULTI_PHASE_INIT}
CYTHON_USE_TP_FINALIZE  {CYTHON_USE_TP_FINALIZE}

PyLong_BASE  0x{PyLong_BASE:X}
PyLong_MASK  0x{PyLong_MASK:X}
PyLong_SHIFT  {PyLong_SHIFT}
sizeof(digit)   {sizeof(digit)}
sizeof(sdigit)  {sizeof(sdigit)}
sys.int_info  {getattr(sys, 'int_info', '-')}
sys.getsizeof(1, 2**14, 2**15, 2**29, 2**30, 2**59, 2**60, 2**64)  {tuple(sys.getsizeof(n) for n in (1, 2**14, 2**15, 2**29, 2**30, 2**59, 2**60, 2**64))}

SIZEOF_INT  {SIZEOF_INT}  ({sizeof(i32)})
SIZEOF_LONG  {SIZEOF_LONG}  ({sizeof(i64)})
SIZEOF_SIZE_T  {SIZEOF_SIZE_T}  ({sizeof(Py_ssize_t)}, {getattr(sys, 'maxsize', getattr(sys, 'maxint', None))})
SIZEOF_LONG_LONG  {SIZEOF_LONG_LONG}  ({sizeof(long long)})
SIZEOF_VOID_P  {SIZEOF_VOID_P}  ({sizeof(void*)})
SIZEOF_UINTPTR_T  {SIZEOF_UINTPTR_T}  ({sizeof(u32 *)})
SIZEOF_OFF_T  {SIZEOF_OFF_T}

Paths:
sys.executable = {sys.executable}
sys.exec_prefix = {sys.exec_prefix}
sys.base_exec_prefix = {getattr(sys, 'base_exec_prefix', "")}
sys.prefix = {sys.prefix}
sys.path = {sys.path}
PYTHONPATH (env) = {get_env('PYTHONPATH', '')}
PYTHONHOME (env) = {get_env('PYTHONHOME', '')}

Distutils:
INCDIR = {sysconfig.get_python_inc()}
LIBS = {config_var('LIBS')}
LIBDIR = {config_var('LIBDIR')}
LIBPL = {config_var('LIBPL')}
Python LIBRARY = {config_var('LIBRARY')}
LINKFORSHARED = {config_var('LINKFORSHARED')}

CC (distutils) = {config_var('CC')}
CC (env) = {get_env('CC', '')}
CFLAGS (distutils) = {config_var('CFLAGS')}
CFLAGS (env) = {get_env('CFLAGS', '')}
LINKCC (distutils) = {config_var('LINKCC')}
LINKCC (env) = {get_env('LINKCC', '')}

Encodings:
sys maxunicode = {sys.maxunicode}
LANG (env) = {get_env('LANG', '')}
PYTHONIOENCODING (env) = {get_env('PYTHONIOENCODING', '')}
sys stdout encoding = {sys.stdout.encoding}
sys default encoding = {sys.getdefaultencoding()}
sys FS encoding = {sys.getfilesystemencoding()}
""")
