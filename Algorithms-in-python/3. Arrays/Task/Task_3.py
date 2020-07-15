# 3. В массиве случайных целых чисел поменять местами минимальный и максимальный элементы.

mass = [9000, 34, 21, 1000, -2000, 4, -10, -80]

index_min = 0
index_max = 0

for i in range(len(mass)):
    if mass[i] < mass[index_min]:
        index_min = i
    if mass[i] > mass[index_max]:
        index_max = i

mass[index_min], mass[index_max] = mass[index_max], mass[index_min]
print(mass)
