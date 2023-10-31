# https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/sys_wait.h.html

from posix.types cimport pid_t, id_t
from posix.signal cimport siginfo_t
from posix.resource cimport rusage

extern from "<sys/wait.h>" nogil:
    enum: WNOHANG
    enum: WUNTRACED
    enum: WCONTINUED
    enum: WEXITED
    enum: WSTOPPED
    enum: WNOWAIT

    fn i32 WEXITSTATUS(i32 status)
    fn i32 WIFCONTINUED(i32 status)
    fn i32 WIFEXITED(i32 status)
    fn i32 WIFSIGNALED(i32 status)
    fn i32 WIFSTOPPED(i32 status)
    fn i32 WSTOPSIG(i32 status)
    fn i32 WTERMSIG(i32 status)

    ctypedef i32 idtype_t
    enum: P_ALL             # idtype_t values
    enum: P_PID
    enum: P_PGID

    fn pid_t wait(i32 *stat_loc)
    fn pid_t waitpid(pid_t pid, i32 *status, i32 options)
    fn i32 waitid(idtype_t idtype, id_t id, siginfo_t *infop, i32 options)

# wait3 was in POSIX until 2008 while wait4 was never standardized.
# Even so, these calls are in almost every Unix, always in sys/wait.h.
# Hence, posix.wait is the least surprising place to declare them for Cython.
# libc may require _XXX_SOURCE to be defined at C-compile time to provide them.

    fn pid_t wait3(i32 *status, i32 options, rusage *rusage)
    fn pid_t wait4(pid_t pid, i32 *status, i32 options, rusage *rusage)
