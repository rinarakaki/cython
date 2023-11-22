# POSIX dynamic linking/loading interface.
# https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/dlfcn.h.html

extern from "<dlfcn.h>" nogil:
    fn void* dlopen(r&char, i32)
    fn r&char dlerror()
    fn void* dlsym(void*, r&char)
    fn i32 dlclose(void*)

    enum:
        RTLD_LAZY
        RTLD_NOW
        RTLD_GLOBAL
        RTLD_LOCAL
