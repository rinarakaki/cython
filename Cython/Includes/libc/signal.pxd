# 7.14 Signal handling <signal.h>

ctypedef void (*sighandler_t)(i32 SIGNUM) noexcept nogil

extern from "<signal.h>" nogil:
    type sig_atomic_t = i32

    static sighandler_t SIG_DFL
    static sighandler_t SIG_IGN
    static sighandler_t SIG_ERR

    fn sighandler_t signal         (i32 signum, sighandler_t action)
    fn i32          raise_ "raise" (i32 signum)

    # Signals
    enum:
        # Program Error
        SIGFPE
        SIGILL
        SIGSEGV
        SIGBUS
        SIGABRT
        SIGIOT
        SIGTRAP
        SIGEMT
        SIGSYS
        SIGSTKFLT
        # Termination
        SIGTERM
        SIGINT
        SIGQUIT
        SIGKILL
        SIGHUP
        # Alarm
        SIGALRM
        SIGVTALRM
        SIGPROF
        # Asynchronous I/O
        SIGIO
        SIGURG
        SIGPOLL
        # Job Control
        SIGCHLD
        SIGCLD
        SIGCONT
        SIGSTOP
        SIGTSTP
        SIGTTIN
        SIGTTOU
        # Operation Error
        SIGPIPE
        SIGLOST
        SIGXCPU
        SIGXFSZ
        SIGPWR
        # Miscellaneous
        SIGUSR1
        SIGUSR2
        SIGWINCH
        SIGINFO
        # Real-time signals
        SIGRTMIN
        SIGRTMAX
