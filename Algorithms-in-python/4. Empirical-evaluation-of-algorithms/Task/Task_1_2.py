# В массиве найти максимальный отрицательный элемент. Вывести на экран его значение и позицию в массиве.
import random as rd

SIZE = 100
array = [rd.randint(-100, 100) for _ in range(SIZE)]


def max_negative(array):
    num = float('-inf')
    index = -1
    for i, item in enumerate(array):
        if 0 > item > num:
            num = item
            index = i
    return num, index


# python -m timeit -n 1000 "import Task_1_2" "Task_1_2.max_negative(Task_1_2.array)" 100
# 1000 loops, best of 5: 6.17 usec per loop

# python -m timeit -n 1000 "import Task_1_2" "Task_1_2.max_negative(Task_1_2.array)" 1000
# 1000 loops, best of 5: 64.5 usec per loop

# python -m timeit -n 1000 "import Task_1_2" "Task_1_2.max_negative(Task_1_2.array)" 2000
# 1000 loops, best of 5: 134 usec per loop

'''
Используя такой алгоритм решения, удалось сократить время больше чем в 2 раза.
Проводить профилирование кода тут нет смысла
'''
