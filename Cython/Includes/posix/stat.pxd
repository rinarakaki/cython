# https://pubs.opengroup.org/onlinepubs/009695399/basedefs/sys/stat.h.html
# https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/sys_stat.h.html

use posix::time::timespec
use posix::types::(blkcnt_t, blksize_t, dev_t, gid_t, ino_t, mode_t,
                   nlink_t, off_t, time_t, uid_t)

extern from "<sys/stat.h>" nogil:
    struct struct_stat "stat":
        dev_t   st_dev
        ino_t   st_ino
        mode_t  st_mode
        nlink_t st_nlink
        uid_t   st_uid
        gid_t   st_gid
        dev_t   st_rdev
        off_t   st_size
        blksize_t st_blksize
        blkcnt_t st_blocks
        # POSIX.1-2001
        time_t  st_atime
        time_t  st_mtime
        time_t  st_ctime
        # POSIX.1-2008
        timespec st_atim
        timespec st_mtim
        timespec st_ctim

        # st_birthtime exists on *BSD and OS X.
        # Under Linux, defining it here does not hurt. Compilation under Linux
        # will only (and rightfully) fail when attempting to use the field.
        time_t  st_birthtime

# POSIX prescribes including both <sys/stat.h> and <unistd.h> for these
extern from "<unistd.h>" nogil:
    fn i32 chmod(r&i8, mode_t)
    fn i32 fchmod(i32, mode_t)
    fn i32 fchmodat(i32, r&i8, mode_t, i32 flags)

    fn i32 stat(r&i8, struct_stat *)
    fn i32 lstat(r&i8, struct_stat *)
    fn i32 fstat(i32, struct_stat *)
    fn i32 fstatat(i32, r&i8, struct_stat *, i32 flags)

    fn i32 mkdir(r&i8, mode_t)
    fn i32 mkdirat(i32, r&i8, mode_t)
    fn i32 mkfifo(r&i8, mode_t)
    fn i32 mkfifoat(i32, r&i8, mode_t)
    fn i32 mknod(r&i8, mode_t, dev_t)
    fn i32 mknodat(i32, r&i8, mode_t, dev_t)

    fn i32 futimens(i32, const timespec *)
    fn i32 utimensat(i32, r&i8, const timespec *, i32 flags)

    # Macros for st_mode
    fn mode_t S_ISREG(mode_t)
    fn mode_t S_ISDIR(mode_t)
    fn mode_t S_ISCHR(mode_t)
    fn mode_t S_ISBLK(mode_t)
    fn mode_t S_ISFIFO(mode_t)
    fn mode_t S_ISLNK(mode_t)
    fn mode_t S_ISSOCK(mode_t)

    static mode_t S_IFMT
    static mode_t S_IFREG
    static mode_t S_IFDIR
    static mode_t S_IFCHR
    static mode_t S_IFBLK
    static mode_t S_IFIFO
    static mode_t S_IFLNK
    static mode_t S_IFSOCK

    # Permissions
    static mode_t S_ISUID
    static mode_t S_ISGID
    static mode_t S_ISVTX

    static mode_t S_IRWXU
    static mode_t S_IRUSR
    static mode_t S_IWUSR
    static mode_t S_IXUSR

    static mode_t S_IRWXG
    static mode_t S_IRGRP
    static mode_t S_IWGRP
    static mode_t S_IXGRP

    static mode_t S_IRWXO
    static mode_t S_IROTH
    static mode_t S_IWOTH
    static mode_t S_IXOTH

    # test file types
    fn u2 S_TYPEISMQ(struct_stat *buf)
    fn u2 S_TYPEISSEM(struct_stat *buf)
    fn u2 S_TYPEISSHM(struct_stat *buf)
    fn u2 S_TYPEISTMO(struct_stat *buf)
