# 9. Найти максимальный элемент среди минимальных элементов столбцов матрицы.

import random as rd

size = 100

matrix = [[rd.randint(-10, 10) for _ in range(size)] for _ in range(size)]


def maximum(matrix):
    max = None
    lists = []
    for mass in range(size):
        m = matrix[mass][0]

        for index in range(1, size):
            if matrix[mass][index] < m:
                m = matrix[mass][index]

        if max is None or max < m:
            max = m
    return max

# python -m timeit -n 1000 "import Task_2_1" "Task_2_1.maximum(Task_2_1.matrix)" 5
# 1000 loops, best of 5: 3.49 usec per loop

# python -m timeit -n 1000 "import Task_2_1" "Task_2_1.maximum(Task_2_1.matrix)" 10
# 1000 loops, best of 5: 9.34 usec per loop

# python -m timeit -n 1000 "import Task_2_1" "Task_2_1.maximum(Task_2_1.matrix)" 50
# 1000 loops, best of 5: 162 usec per loop

# python -m timeit -n 1000 "import Task_2_1" "Task_2_1.maximum(Task_2_1.matrix)" 100
# 1000 loops, best of 5: 599 usec per loop


