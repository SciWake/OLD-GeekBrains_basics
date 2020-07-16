# 7. В одномерном массиве целых чисел определить два наименьших элемента.
# Они могут быть как равны между собой (оба минимальны), так и различаться.

array = [-10, -20, 4, 5, -10, -20, 1]

min_one = min_two = 0

for i, num in enumerate(array):
    if num < array[min_one]:
        min_one = i
    if (num >= array[min_one]) and num < array[min_two] and min_one != i:
        min_two = i

print(f'Наименьшее число {array[min_one]}, второе {array[min_two]}')
