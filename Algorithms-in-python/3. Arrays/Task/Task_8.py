# 8. Матрица 5x4 заполняется вводом с клавиатуры, кроме последних элементов строк. Программа должна вычислять сумму
# введенных элементов каждой строки и записывать ее в последнюю ячейку строки.
# В конце следует вывести полученную матрицу.

import random as rd

m = 5
n = 4
matrix = []

for i in range(n):
    row = []
    summ = 0

    for j in range(m - 1):
        if i != 3:
            number = rd.randint(1, 10)
        else:
            number = int(input(f'Строка {i + 1}, элемент {j}: '))

        summ += number
        row.append(number)

    row.append(summ)
    matrix.append(row)

for item in matrix:
    for i in item:
        print(f'{i:>5}', end='')
    print()
