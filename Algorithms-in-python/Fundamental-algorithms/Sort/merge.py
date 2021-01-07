'''
Исходный массив делится на две примерно равные части. Если массив имеет нечетное количество элементов,
одна из этих «половин» на один элемент больше, чем другая.

Подмассивы делятся снова и снова на две половины, пока вы не получите массивы, которые имеют только один элемент.

Затем вы объединяете пары одноэлементных массивов в двухэлементные массивы, сохраняя их в процессе.
Затем эти отсортированные пары объединяются в четырехэлементные массивы и так далее до тех пор,
пока не будет получен исходный отсортированный массив.
'''

# Генерация массива
import random

size = 20
mass = [i for i in range(size)]
random.shuffle(mass)


# РЕАЛИЗАЦИЯ 1

def merge_sort(array):
    if len(array) > 1:
        middle = len(array) // 2
        right = array[middle:]
        left = array[:middle]

        merge_sort(right)
        merge_sort(left)

        i, j, k = 0, 0, 0
        while i < len(right) and j < len(left):
            if left[j] <= right[i]:
                array[k] = left[j]
                j += 1
            else:
                array[k] = right[i]
                i += 1
            k += 1

        while i < len(right):
            array[k] = right[i]
            i += 1
            k += 1
        while j < len(left):
            array[k] = left[j]
            j += 1
            k += 1

# python -m timeit -n 1000 "import merge" "merge.merge_sort(merge.mass)"
# 1000 loops, best of 5: 52.2 usec per loop
