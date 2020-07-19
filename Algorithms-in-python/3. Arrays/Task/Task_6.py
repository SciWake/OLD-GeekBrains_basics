# 6. В одномерном массиве найти сумму элементов, находящихся между минимальным и максимальным элементами.
# Сами минимальный и максимальный элементы в сумму не включать.
import random as rd

array = [rd.randint(-10, 10) for _ in range(10)]
print(array)

index_min = index_max = 0

for i, num in enumerate(array):
    if array[index_min] > num:
        index_min = i
    if array[index_max] < num:
        index_max = i

sum = 0

if len(array_1 := array[index_min + 1: index_max]):
    for i in array_1:
        sum += i
elif len(array_2 := array[index_max: index_min]):
    for i in array_2:
        sum += i

print(f'Сумма между {array[index_min]} и {array[index_max]} = {sum}')
