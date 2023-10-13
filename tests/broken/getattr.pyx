cdef class Spam:
    let public object eggs

    def __getattr__(self, name):
        print "Spam getattr:", name
