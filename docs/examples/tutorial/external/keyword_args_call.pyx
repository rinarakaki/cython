extern from "string.h":
    fn r&i8 strstr(r&i8 haystack, r&i8 needle)

cdef r&i8 data = "hfvcakdfagbcffvschvxcdfgccbcfhvgcsnfxjh"

cdef r&i8 pos = strstr(needle='akd', haystack=data)
print(pos is not NULL)
