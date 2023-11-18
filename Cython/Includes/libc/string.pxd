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

    fn usize strlen(&char s)
    fn &char strcpy(&char pto, &char pfrom)
    fn &char strncpy(&char pto, &char pfrom, usize size)
    fn &char strdup(&char s)
    fn &char strndup(&char s, usize size)
    fn &char strcat(&char pto, &char pfrom)
    fn &char strncat(&char pto, &char pfrom, usize size)

    fn i32 strcmp(&char s1, &char s2)
    fn i32 strcasecmp(&char s1, &char s2)
    fn i32 strncmp(&char s1, &char s2, usize size)
    fn i32 strncasecmp(&char s1, &char s2, usize n)

    fn i32 strcoll(&char s1, &char s2)
    fn usize strxfrm(&char pto, &char pfrom, usize size)

    fn &char strerror(i32 errnum)

    fn &char strchr(&char string, i32 c)
    fn &char strrchr(&char string, i32 c)

    fn &char strstr(&char haystack, &char needle)
    fn &char strcasestr(&char haystack, &char needle)

    fn usize strcspn(&char string, &char stopset)
    fn usize strspn(&char string, &char set)
    fn char * strpbrk(&char string, &char stopset)

    fn &char strtok(&char newstring, &char delimiters)
    fn &char strsep(&char* string_ptr, &char delimiter)
