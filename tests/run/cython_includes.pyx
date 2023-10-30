
from libc.stdio cimport sprintf
from cpython cimport PyType_Check
from cpython cimport PyType_Check as PyType_Check2
from cpython.type cimport PyType_Check as PyType_Check3

# Make sure we can cimport all .pxd files.
use cpython.array
use cpython.bool
use cpython.buffer
use cpython.bytearray
use cpython.bytes
use cpython.cellobject
use cpython.ceval
use cpython.cobject
use cpython.codecs
use cpython.complex
use cpython.contextvars
use cpython.conversion
use cpython.datetime
use cpython.dict
use cpython.exc
use cpython.fileobject
use cpython.float
use cpython.function
use cpython.genobject
use cpython.getargs
use cpython.instance
use cpython.int
use cpython.iterator
use cpython.iterobject
use cpython.list
use cpython.long
use cpython.longintrepr
use cpython.mapping
use cpython.marshal
use cpython.mem
use cpython.memoryview
use cpython.method
use cpython.module
use cpython.number
use cpython.object
use cpython.oldbuffer
use cpython.pycapsule
use cpython.pylifecycle
use cpython.pystate
use cpython.pythread
use cpython.ref
use cpython.sequence
use cpython.set
use cpython.slice
use cpython.string
use cpython.tuple
use cpython.type
use cpython.unicode
use cpython.version
use cpython.weakref


def libc_cimports():
    """
    >>> libc_cimports()
    hello
    """
    let char[10] buf
    sprintf(buf, "%s", b'hello')
    print (<object>buf).decode('ASCII')


def cpython_cimports():
    """
    >>> cpython_cimports()
    True
    False
    True
    False
    True
    False
    """
    print PyType_Check(list)
    print PyType_Check([])
    print PyType_Check2(list)
    print PyType_Check2([])
    print PyType_Check3(list)
    print PyType_Check3([])

