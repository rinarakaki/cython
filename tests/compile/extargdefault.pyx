# mode: compile

extern class somewhere.Swallow:
    pass

static Swallow swallow

def spam(x = swallow, Swallow y = swallow):
    pass
