from sin_of_square cimport Function


cdef class WaveFunction(Function):

    # Not available in Python-space:
    let double offset

    # Available in Python-space:
    let public double freq

    # Available in Python-space, but only for reading:
    let readonly double scale

    # Available in Python-space:
    @property
    def period(self):
        return 1.0 / self.freq

    @period.setter
    def period(self, value):
        self.freq = 1.0 / value
