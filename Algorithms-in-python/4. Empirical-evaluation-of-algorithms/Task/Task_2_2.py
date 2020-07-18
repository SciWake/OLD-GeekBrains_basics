# 9. Найти максимальный элемент среди минимальных элементов столбцов матрицы.

import random as rd

size = 100

matrix = [[rd.randint(-10, 10) for _ in range(size)] for _ in range(size)]


def maximum(matrix):
    lst = []
    for i in matrix:
        lst.append(min(i))
    return min(lst)


# python -m timeit -n 1000 "import Task_2_2" "Task_2_2.maximum(Task_2_2.matrix)" 5
# 1000 loops, best of 5: 1.82 usec per loop

# python -m timeit -n 1000 "import Task_2_2" "Task_2_2.maximum(Task_2_2.matrix)" 10
# 1000 loops, best of 5: 4.3 usec per loop

# ython -m timeit -n 1000 "import Task_2_2" "Task_2_2.maximum(Task_2_2.matrix)"  50
# 1000 loops, best of 5: 66.4 usec per loop

# python -m timeit -n 1000 "import Task_2_2" "Task_2_2.maximum(Task_2_2.matrix)" 100
# 1000 loops, best of 5: 259 usec per loop


'''
Используя такой алгоритм решения, удалось сократить время больше чем в 2 раза.
Проводить профилирование кода тут нет смысла
'''
