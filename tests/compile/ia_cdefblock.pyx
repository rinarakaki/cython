# mode: compile

cdef:
    struct PrivFoo:
        i32 i

    i32 priv_i

    fn void priv_f():
        global priv_i
        priv_i = 42

pub:
    struct PubFoo:
        i32 i

    i32 pub_v

    fn void pub_f():
        pass

    class PubBlarg [object PubBlargObj, type PubBlargType]:
        pass

cdef api:
    fn void api_f():
        pass

pub api:
    fn void pub_api_f():
        pass

priv_f()
