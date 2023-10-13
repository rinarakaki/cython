# mode: compile
# tag: struct, union, enum, cdefextern

extern from *:
    """
    struct spam { int a; };
    struct flat_spam { int a; };
    typedef struct { int a; } flat_spam_type;

    typedef union { int a; long b; } eggs;
    typedef union { int a; long b; } flat_eggs;

    enum ham { TOAST };
    enum flat_ham { FLAT_TOAST };
    """

    struct Spam:
        pass

    struct FlatSpam: pass

    struct FlatSpamType: pass

    union Eggs:
        pass

    union FlatEggs: pass

    enum Ham:
        pass

    enum FlatHam: pass


extern Spam s
extern FlatSpam fs
extern FlatSpamType fst

extern Eggs e
extern FlatEggs fe

extern Ham h
extern FlatHam fh
