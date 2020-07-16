# 9. Найти максимальный элемент среди минимальных элементов столбцов матрицы.

import random as rd

size = 5

matrix = [[rd.randint(-10, 10) for _ in range(size)] for _ in range(size)]

for line in matrix:
    for item in line:
        print(f'{item:>4}', end='')
    print()

max = None
lists = []
for mass in range(size):
    m = matrix[mass][0]

    for index in range(1, size):
        if matrix[mass][index] < m:
            m = matrix[mass][index]

    if max is None or max < m:
        max = m


print(f'Максимальным числом среди минимальных столбцов является {max}')
