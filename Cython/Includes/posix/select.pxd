# https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/sys_select.h.html

from .types cimport sigset_t
from .time cimport timeval, timespec

extern from "<sys/select.h>" nogil:
    struct fd_set:
        pass

    fn i32 FD_SETSIZE
    fn void FD_SET(i32, fd_set*)
    fn void FD_CLR(i32, fd_set*)
    fn bint FD_ISSET(i32, fd_set*)
    fn void FD_ZERO(fd_set*)

    fn i32 select(i32 nfds, fd_set *readfds, fd_set *writefds,
        fd_set *exceptfds, timeval *timeout)

    fn i32 pselect(i32 nfds, fd_set *readfds, fd_set *writefds,
        fd_set *exceptfds, const timespec *timeout,
        const sigset_t *sigmask)
