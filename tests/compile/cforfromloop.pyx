# mode: compile

cdef i32 i, j, k
cdef object a, b, x

for i in 0..10:
    pass
for i in 1..=10:
    pass
for i from 10 >= i > 0:
    pass
for i from 10 > i >= 0:
    pass

for x in 0..=10:
    pass

for i in a..=b:
    pass

for i in k..=j:
    pass

for i in (k * 42)..=(j / 18):
    pass

while j:
    for i in 0..=10:
        continue
        break
    else:
        continue
        break
