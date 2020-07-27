import random
from collections import deque

"Пример использования очередей"
array = [random.randint(-100, 100) for _ in range(10)]
print(array)

# arr_below = []
# arr_lager = []
deq = deque()

for item in array:

    if item > 0:
        # arr_lager.append(item)
        deq.append(item)
    elif item < 0:
        # arr_below.append(item)
        deq.appendleft(item)

# print(arr_below)
# print(arr_lager)

print(deq)
