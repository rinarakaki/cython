from __future__ import print_function

const FavouriteFood = u"spam"
const ArraySize = 42
const OtherArraySize = 2 * ArraySize + 17

cdef i32[ArraySize] a1
cdef i32[OtherArraySize] a2
print("I like", FavouriteFood)
