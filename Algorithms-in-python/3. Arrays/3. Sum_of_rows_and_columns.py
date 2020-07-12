import random

matrix = [[random.randint(1, 10) for _ in range(5)] for _ in range(7)]

sum_column = [0] * len(matrix[0])

for line in matrix:
    sum_line = 0

    for i, item in enumerate(line):
        sum_line += item
        sum_column[i] += item

        print(f'{item:>5}', end='')

    print(f'    | {sum_line}')

print('-' * (len(matrix) * 5))

for s in sum_column:
    print(f'{s:>5}', end='')