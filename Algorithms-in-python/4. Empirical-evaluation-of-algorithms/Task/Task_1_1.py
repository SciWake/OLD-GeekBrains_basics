# В массиве найти максимальный отрицательный элемент. Вывести на экран его значение и позицию в массиве.
import random as rd

SIZE = 100
array = [rd.randint(-100, 100) for _ in range(SIZE)]


def max_negative(array, size):
    i = 0
    index = -1

    while i < size:
        if array[i] < 0 and index == -1:
            index = i
        elif 0 > array[i] > array[index]:
            index = i

        i += 1
    return array[index], index


# python -m timeit -n 1000 "import Task_1_1" "Task_1_1.max_negative(Task_1_1.array, Task_1_1.SIZE)" 100
# 1000 loops, best of 5: 13.4 usec per loop


# python -m timeit -n 1000 "import Task_1_1" "Task_1_1.max_negative(Task_1_1.array, Task_1_1.SIZE)" 1000
# 1000 loops, best of 5: 150 usec per loop

# python -m timeit -n 1000 "import Task_1_1" "Task_1_1.max_negative(Task_1_1.array, Task_1_1.SIZE)" 2000
# 1000 loops, best of 5: 298 usec per loop


