extern from "string.h":
    fn &char strstr(&char haystack, &char needle)

cdef &char data = "hfvcakdfagbcffvschvxcdfgccbcfhvgcsnfxjh"

cdef &char pos = strstr(needle='akd', haystack=data)
print(pos is not NULL)
