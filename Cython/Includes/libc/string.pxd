# 7.21 String handling <string.h>

extern from *:
    # deprecated backwards compatibility declarations
    type const_char "const char" = const char
    type const_schar "const signed char" = const signed char
    type const_uchar "const unsigned char" = const u8
    type const_void "const void" = const void

extern from "<string.h>" nogil:
    fn void* memcpy(void* pto, const void* pfrom, usize size)
    fn void* memmove(void* pto, const void* pfrom, usize size)
    fn void* memset(void* block, i32 c, usize size)
    fn i32  memcmp(const void* a1, const void* a2, usize size)
    fn void* memchr(const void* block, i32 c, usize size)

    fn void* memchr(const void* block, i32 c, usize size)
    fn void* memrchr(const void* block, i32 c, usize size)

    fn usize strlen(r&char s)
    fn r&char strcpy(r&char pto, r&char pfrom)
    fn r&char strncpy(r&char pto, r&char pfrom, usize size)
    fn r&char strdup(r&char s)
    fn r&char strndup(r&char s, usize size)
    fn r&char strcat(r&char pto, r&char pfrom)
    fn r&char strncat(r&char pto, r&char pfrom, usize size)

    fn i32 strcmp(r&char s1, r&char s2)
    fn i32 strcasecmp(r&char s1, r&char s2)
    fn i32 strncmp(r&char s1, r&char s2, usize size)
    fn i32 strncasecmp(r&char s1, r&char s2, usize n)

    fn i32 strcoll(r&char s1, r&char s2)
    fn usize strxfrm(r&char pto, r&char pfrom, usize size)

    fn r&char strerror(i32 errnum)

    fn r&char strchr(r&char string, i32 c)
    fn r&char strrchr(r&char string, i32 c)

    fn r&char strstr(r&char haystack, r&char needle)
    fn r&char strcasestr(r&char haystack, r&char needle)

    fn usize strcspn(r&char string, r&char stopset)
    fn usize strspn(r&char string, r&char set)
    fn char * strpbrk(r&char string, r&char stopset)

    fn r&char strtok(r&char newstring, r&char delimiters)
    fn r&char strsep(r&char* string_ptr, r&char delimiter)
