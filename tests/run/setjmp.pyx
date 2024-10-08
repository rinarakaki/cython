use libc::setjmp::*

fn void check_nonzero(jmp_buf ctx, i32 x) nogil:
    if x == 0:
        longjmp(ctx, 1)

def nonzero(i32 x):
    """
    >>> nonzero(-1)
    True
    >>> nonzero(0)
    False
    >>> nonzero(1)
    True
    >>> nonzero(2)
    True

    """
    let jmp_buf ctx
    if setjmp(ctx) == 0:
        check_nonzero(ctx, x)
        return true
    else:
        return false

use libc::string::strcpy
cdef i8[256] error_msg
cdef jmp_buf error_ctx
fn void error(i8 msg[]) nogil:
    strcpy(error_msg,msg)
    longjmp(error_ctx, 1)

fn void c_call(i32 x) nogil:
    if x<=0:
        error(b"expected a positive value")

def execute_c_call(i32 x):
    """
    >>> execute_c_call(+2)
    >>> execute_c_call(+1)
    >>> execute_c_call(+0)
    Traceback (most recent call last):
      ...
    RuntimeError: expected a positive value
    >>> execute_c_call(-1)
    Traceback (most recent call last):
      ...
    RuntimeError: expected a positive value
    """
    if not setjmp(error_ctx):
        c_call(x)
    else:
        raise RuntimeError(error_msg.decode())
