# mode: compile

use libc

use libc.stdio
use libc.errno
use libc.float
use libc.limits
use libc.locale
use libc.signal
use libc.stddef
# use libc.stdint  # XXX MSVC
use libc.stdio
use libc.stdlib
use libc.string

from libc cimport errno
from libc cimport float
from libc cimport limits
from libc cimport locale
from libc cimport signal
from libc cimport stddef
#from libc cimport stdint # XXX MSVC
from libc cimport stdio
from libc cimport stdlib
from libc cimport string

from libc.errno  cimport *
from libc.float  cimport *
from libc.limits cimport *
from libc.locale cimport *
from libc.signal cimport *
from libc.stddef cimport *
#from libc.stdint cimport * # XXX MSVC
from libc.stdio  cimport *
from libc.stdlib cimport *
from libc.string cimport *

