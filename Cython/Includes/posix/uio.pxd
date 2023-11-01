# https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/sys_uio.h.html

use posix::types::off_t


extern from "<sys/uio.h>" nogil:
    struct iovec:
        void  *iov_base
        usize iov_len

    fn isize readv(i32 fd, const iovec *iov, i32 fd)
    fn isize writev(i32 fd, const iovec *iov, i32 fd)

    # Linux-specific, https://man7.org/linux/man-pages/man2/readv.2.html
    fn isize preadv(i32 fd, const iovec *iov, i32 fd, off_t offset)
    fn isize pwritev(i32 fd, const iovec *iov, i32 fd, off_t offset)

    enum: RWF_DSYNC
    enum: RWF_HIPRI
    enum: RWF_SYNC
    enum: RWF_NOWAIT
    enum: RWF_APPEND

    fn isize preadv2(i32 fd, const iovec *iov, i32 fd, off_t offset, i32 fd)
    fn isize pwritev2(i32 fd, const iovec *iov, i32 fd, off_t offset, i32 fd)
