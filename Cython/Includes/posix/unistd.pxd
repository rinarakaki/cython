# http://www.opengroup.org/onlinepubs/009695399/basedefs/unistd.h.html

use posix::types::(gid_t, pid_t, off_t, uid_t)

extern from "<unistd.h>" nogil:
    # NULL

    enum: R_OK
    enum: W_OK
    enum: X_OK
    enum: F_OK

    enum: _CS_PATH
    enum: _CS_POSIX_V6_ILP32_OFF32_CFLAGS
    enum: _CS_POSIX_V6_ILP32_OFF32_LDFLAGS
    enum: _CS_POSIX_V6_ILP32_OFF32_LIBS
    enum: _CS_POSIX_V6_ILP32_OFFBIG_CFLAGS
    enum: _CS_POSIX_V6_ILP32_OFFBIG_LDFLAGS
    enum: _CS_POSIX_V6_ILP32_OFFBIG_LIBS
    enum: _CS_POSIX_V6_LP64_OFF64_CFLAGS
    enum: _CS_POSIX_V6_LP64_OFF64_LDFLAGS
    enum: _CS_POSIX_V6_LP64_OFF64_LIBS
    enum: _CS_POSIX_V6_LPBIG_OFFBIG_CFLAGS
    enum: _CS_POSIX_V6_LPBIG_OFFBIG_LDFLAGS
    enum: _CS_POSIX_V6_LPBIG_OFFBIG_LIBS
    enum: _CS_POSIX_V6_WIDTH_RESTRICTED_ENVS

    enum: SEEK_SET
    enum: SEEK_CUR
    enum: SEEK_END

    enum: F_LOCK
    enum: F_TEST
    enum: F_TLOCK
    enum: F_ULOCK

    enum: _PC_2_SYMLINKS
    enum: _PC_ALLOC_SIZE_MIN
    enum: _PC_ASYNC_IO
    enum: _PC_CHOWN_RESTRICTED
    enum: _PC_FILESIZEBITS
    enum: _PC_LINK_MAX
    enum: _PC_MAX_CANON
    enum: _PC_MAX_INPUT
    enum: _PC_NAME_MAX
    enum: _PC_NO_TRUNC
    enum: _PC_PATH_MAX
    enum: _PC_PIPE_BUF
    enum: _PC_PRIO_IO
    enum: _PC_REC_INCR_XFER_SIZE
    enum: _PC_REC_MIN_XFER_SIZE
    enum: _PC_REC_XFER_ALIGN
    enum: _PC_SYMLINK_MAX
    enum: _PC_SYNC_IO
    enum: _PC_VDISABLE

    enum: _SC_2_C_BIND
    enum: _SC_2_C_DEV
    enum: _SC_2_CHAR_TERM
    enum: _SC_2_FORT_DEV
    enum: _SC_2_FORT_RUN
    enum: _SC_2_LOCALEDEF
    enum: _SC_2_PBS
    enum: _SC_2_PBS_ACCOUNTING
    enum: _SC_2_PBS_CHECKPOINT
    enum: _SC_2_PBS_LOCATE
    enum: _SC_2_PBS_MESSAGE
    enum: _SC_2_PBS_TRACK
    enum: _SC_2_SW_DEV
    enum: _SC_2_UPE
    enum: _SC_2_VERSION
    enum: _SC_ADVISORY_INFO
    enum: _SC_AIO_LISTIO_MAX
    enum: _SC_AIO_MAX
    enum: _SC_AIO_PRIO_DELTA_MAX
    enum: _SC_ARG_MAX
    enum: _SC_ASYNCHRONOUS_IO
    enum: _SC_ATEXIT_MAX
    enum: _SC_BARRIERS
    enum: _SC_BC_BASE_MAX
    enum: _SC_BC_DIM_MAX
    enum: _SC_BC_SCALE_MAX
    enum: _SC_BC_STRING_MAX
    enum: _SC_CHILD_MAX
    enum: _SC_CLK_TCK
    enum: _SC_CLOCK_SELECTION
    enum: _SC_COLL_WEIGHTS_MAX
    enum: _SC_CPUTIME
    enum: _SC_DELAYTIMER_MAX
    enum: _SC_EXPR_NEST_MAX
    enum: _SC_FSYNC
    enum: _SC_GETGR_R_SIZE_MAX
    enum: _SC_GETPW_R_SIZE_MAX
    enum: _SC_HOST_NAME_MAX
    enum: _SC_IOV_MAX
    enum: _SC_IPV6
    enum: _SC_JOB_CONTROL
    enum: _SC_LINE_MAX
    enum: _SC_LOGIN_NAME_MAX
    enum: _SC_MAPPED_FILES
    enum: _SC_MEMLOCK
    enum: _SC_MEMLOCK_RANGE
    enum: _SC_MEMORY_PROTECTION
    enum: _SC_MESSAGE_PASSING
    enum: _SC_MONOTONIC_CLOCK
    enum: _SC_MQ_OPEN_MAX
    enum: _SC_MQ_PRIO_MAX
    enum: _SC_NGROUPS_MAX
    enum: _SC_OPEN_MAX
    enum: _SC_PAGE_SIZE
    enum: _SC_PAGESIZE
    enum: _SC_PRIORITIZED_IO
    enum: _SC_PRIORITY_SCHEDULING
    enum: _SC_RAW_SOCKETS
    enum: _SC_RE_DUP_MAX
    enum: _SC_READER_WRITER_LOCKS
    enum: _SC_REALTIME_SIGNALS
    enum: _SC_REGEXP
    enum: _SC_RTSIG_MAX
    enum: _SC_SAVED_IDS
    enum: _SC_SEM_NSEMS_MAX
    enum: _SC_SEM_VALUE_MAX
    enum: _SC_SEMAPHORES
    enum: _SC_SHARED_MEMORY_OBJECTS
    enum: _SC_SHELL
    enum: _SC_SIGQUEUE_MAX
    enum: _SC_SPAWN
    enum: _SC_SPIN_LOCKS
    enum: _SC_SPORADIC_SERVER
    enum: _SC_SS_REPL_MAX
    enum: _SC_STREAM_MAX
    enum: _SC_SYMLOOP_MAX
    enum: _SC_SYNCHRONIZED_IO
    enum: _SC_THREAD_ATTR_STACKADDR
    enum: _SC_THREAD_ATTR_STACKSIZE
    enum: _SC_THREAD_CPUTIME
    enum: _SC_THREAD_DESTRUCTOR_ITERATIONS
    enum: _SC_THREAD_KEYS_MAX
    enum: _SC_THREAD_PRIO_INHERIT
    enum: _SC_THREAD_PRIO_PROTECT
    enum: _SC_THREAD_PRIORITY_SCHEDULING
    enum: _SC_THREAD_PROCESS_SHARED
    enum: _SC_THREAD_SAFE_FUNCTIONS
    enum: _SC_THREAD_SPORADIC_SERVER
    enum: _SC_THREAD_STACK_MIN
    enum: _SC_THREAD_THREADS_MAX
    enum: _SC_THREADS
    enum: _SC_TIMEOUTS
    enum: _SC_TIMER_MAX
    enum: _SC_TIMERS
    enum: _SC_TRACE
    enum: _SC_TRACE_EVENT_FILTER
    enum: _SC_TRACE_EVENT_NAME_MAX
    enum: _SC_TRACE_INHERIT
    enum: _SC_TRACE_LOG
    enum: _SC_TRACE_NAME_MAX
    enum: _SC_TRACE_SYS_MAX
    enum: _SC_TRACE_USER_EVENT_MAX
    enum: _SC_TTY_NAME_MAX
    enum: _SC_TYPED_MEMORY_OBJECTS
    enum: _SC_TZNAME_MAX
    enum: _SC_V6_ILP32_OFF32
    enum: _SC_V6_ILP32_OFFBIG
    enum: _SC_V6_LP64_OFF64
    enum: _SC_V6_LPBIG_OFFBIG
    enum: _SC_VERSION
    enum: _SC_XBS5_ILP32_OFF32
    enum: _SC_XBS5_ILP32_OFFBIG
    enum: _SC_XBS5_LP64_OFF64
    enum: _SC_XBS5_LPBIG_OFFBIG
    enum: _SC_XOPEN_CRYPT
    enum: _SC_XOPEN_ENH_I18N
    enum: _SC_XOPEN_LEGACY
    enum: _SC_XOPEN_REALTIME
    enum: _SC_XOPEN_REALTIME_THREADS
    enum: _SC_XOPEN_SHM
    enum: _SC_XOPEN_STREAMS
    enum: _SC_XOPEN_UNIX
    enum: _SC_XOPEN_VERSION

    enum: STDIN_FILENO 	 # 0
    enum: STDOUT_FILENO	 # 1
    enum: STDERR_FILENO	 # 2

    type useconds_t = u32

    fn i32         access(const char *, i32)
    fn u32         alarm(u32)
    fn i32         chdir(const char *)
    fn i32         chown(const char *, uid_t, gid_t)
    fn i32         close(i32)
    fn usize       confstr(i32, char *, usize)
    fn char       *crypt(const char *, const char *)
    fn char       *ctermid(char *)
    fn i32         dup(i32)
    fn i32         dup2(i32, i32)
    fn void        encrypt(char[64], i32)
    fn i32         execl(const char *, const char *, ...)
    fn i32         execle(const char *, const char *, ...)
    fn i32         execlp(const char *, const char *, ...)
    fn i32         execv(const char *, char *[])
    fn i32         execve(const char *, char *[], char *[])
    fn i32         execvp(const char *, char *[])
    fn void        _exit(i32)
    fn i32         fchown(i32, uid_t, gid_t)
    fn i32         fchdir(i32)
    fn i32         fdatasync(i32)
    fn pid_t       fork()
    fn i64         fpathconf(i32, i32)
    fn i32         fsync(i32)
    fn i32         ftruncate(i32, off_t)
    fn char       *getcwd(char *, usize)
    fn gid_t       getegid()
    fn uid_t       geteuid()
    fn gid_t       getgid()
    fn i32         getgroups(i32, gid_t [])
    fn i64         gethostid()
    fn i32         gethostname(char *, usize)
    fn char       *getlogin()
    fn i32         getlogin_r(char *, usize)
    fn i32         getopt(i32, char * [], const char *)
    fn pid_t       getpgid(pid_t)
    fn pid_t       getpgrp()
    fn pid_t       getpid()
    fn pid_t       getppid()
    fn pid_t       getsid(pid_t)
    fn uid_t       getuid()
    fn char       *getwd(char *)
    fn i32         isatty(i32)
    fn i32         lchown(const char *, uid_t, gid_t)
    fn i32         link(const char *, const char *)
    fn i32         lockf(i32, int, off_t)
    fn off_t       lseek(i32, off_t, i32)
    fn i32         nice(i32)
    fn i64         pathconf(char *, i32)
    fn i32         pause()
    fn i32         pipe(i32 [2])
    fn isize       pread(i32, void *, usize, off_t)
    fn isize       pwrite(i32, const void *, usize, off_t)
    fn isize       read(i32, void *, usize)
    fn isize       readlink(const char *, char *, usize)
    fn i32         rmdir(const char *)
    fn i32         setegid(gid_t)
    fn i32         seteuid(uid_t)
    fn i32         setgid(gid_t)
    fn i32         setpgid(pid_t, pid_t)
    fn pid_t       setpgrp()
    fn i32         setregid(gid_t, gid_t)
    fn i32         setreuid(uid_t, uid_t)
    fn pid_t       setsid()
    fn i32         setuid(uid_t)
    fn u32         sleep(u32)
    fn void        swab(const void *, void *, ssize_t)
    fn i32         symlink(const char *, const char *)
    fn void        sync()
    fn i64         sysconf(i32)
    fn pid_t       tcgetpgrp(i32)
    fn i32         tcsetpgrp(i32, pid_t)
    fn i32         truncate(const char *, off_t)
    fn char        *ttyname(i32)
    fn i32         ttyname_r(i32, char *, usize)
    fn useconds_t  ualarm(useconds_t, useconds_t)
    fn i32         unlink(const char *)
    fn i32         usleep(useconds_t)
    fn pid_t       vfork()
    fn isize       write(i32, const void *, usize)
    fn char       *optarg
    fn i32         optind
    fn i32         opterr
    fn i32         optopt
