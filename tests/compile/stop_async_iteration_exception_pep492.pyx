# mode: compile
# tag: pep492

# make sure async iterators also compile correctly without using 'await'

cdef class AsyncIter:
    cdef i64 i
    cdef i64 aiter_calls
    cdef i64 max_iter_calls

    def __init__(self, i64 max_iter_calls=1):
        self.i = 0
        self.aiter_calls = 0
        self.max_iter_calls = max_iter_calls

    def __aiter__(self):
        self.aiter_calls += 1
        return self

    async def __anext__(self):
        self.i += 1
        assert self.aiter_calls <= self.max_iter_calls

        if self.i > 10:
            raise StopAsyncIteration

        return self.i, self.i
