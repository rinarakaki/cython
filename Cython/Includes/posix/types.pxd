# Note that the actual size of these types is system-dependent, and
# can't be detected at C compile time.  However, the generated C code
# will correctly use the actual size of these types *except* for
# determining promotion in binary arithmetic expressions involving
# mixed types.  In this case, operands are promoted to the declared
# larger type, with a bias towards typedef types.  Thus, with the
# declarations below, long + time_t will result in a time_t whereas
# long long + time_t will result in a long long which should be
# acceptable for either 32-bit or 64-bit signed time_t (though admittedly
# the POSIX standard doesn't even specify that time_t must be an integral
# type).

extern from "<sys/types.h>":
    ctypedef i64 blkcnt_t
    ctypedef i64 blksize_t
    ctypedef i64 clockid_t
    ctypedef i64 dev_t
    ctypedef i64 gid_t
    ctypedef i64 id_t
    ctypedef u64 ino_t
    ctypedef i64 mode_t
    ctypedef i64 nlink_t
    ctypedef i64 off_t
    ctypedef i64 pid_t
    struct sigset_t:
        pass
    ctypedef i64 suseconds_t
    ctypedef i64 time_t
    ctypedef i64 timer_t
    ctypedef i64 uid_t
