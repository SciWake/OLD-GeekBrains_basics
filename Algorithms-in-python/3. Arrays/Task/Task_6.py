# 6. В одномерном массиве найти сумму элементов, находящихся между минимальным и максимальным элементами.
# Сами минимальный и максимальный элементы в сумму не включать.

array = [1, 2, 3, 40, 2, -5, 1, 10]

index_min = index_max = 0

for i, num in enumerate(array):
    if array[index_max] >= num:
        index_max = i
    if array[index_min] <= num:
        index_min = i

sum = 0

if len(array_1 := array[index_min + 1: index_max]):
    for i in array_1:
        sum += i
elif len(array := array[index_max + 1: index_min]):
    for i in array:
        sum += i


print(f'Сумма между {array[index_min]} и {array[index_max]} = {sum}')
