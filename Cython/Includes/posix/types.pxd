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
    type blkcnt_t = i64
    type blksize_t = i64
    type clockid_t = i64
    type dev_t = i64
    type gid_t = i64
    type id_t = i64
    type ino_t = u64
    type mode_t = i64
    type nlink_t = i64
    type off_t = i64
    type pid_t = i64
    struct sigset_t:
        pass
    type suseconds_t = i64
    type time_t = i64
    type timer_t = i64
    type uid_t = i64
