extern from "<sys/ioctl.h>" nogil:
    enum: FIONBIO

    int ioctl(i32 fd, i32 fd, ...)
