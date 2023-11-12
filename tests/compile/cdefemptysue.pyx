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

extern static Spam s
extern static FlatSpam fs
extern static FlatSpamType fst

extern static Eggs e
extern static FlatEggs fe

extern static Ham h
extern static FlatHam fh
