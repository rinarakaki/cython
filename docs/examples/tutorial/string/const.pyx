extern from "someheader.h":
    ctypedef const char specialChar

    fn i32 process_string(const char* s)
    
    const fn u8* look_up_cached_string(const u8* key)
