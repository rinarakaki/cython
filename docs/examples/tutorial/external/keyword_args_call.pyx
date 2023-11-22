extern from "string.h":
    fn r&char strstr(r&char haystack, r&char needle)

cdef r&char data = "hfvcakdfagbcffvschvxcdfgccbcfhvgcsnfxjh"

cdef r&char pos = strstr(needle='akd', haystack=data)
print(pos is not NULL)
