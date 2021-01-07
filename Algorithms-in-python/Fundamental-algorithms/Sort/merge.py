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


# РЕАЛИЗАЦИЯ 2

def merge(left_list, right_list):
    sorted_list = []
    left_index = right_index = 0

    left_length, right_length = len(left_list), len(right_list)

    for _ in range(left_length + right_length):
        if left_index < left_length and right_index < right_length:

            if left_list[left_index] <= right_list[right_index]:
                sorted_list.append(left_list[left_index])
                left_index += 1
            else:
                sorted_list.append(right_list[right_index])
                right_index += 1

        # Если достигнут конец левого списка, элементы правого списка
        # добавляем в конец результирующего списка
        elif left_index == left_length:
            sorted_list.append(right_list[right_index])
            right_index += 1
        # Если достигнут конец правого списка, элементы левого списка
        # добавляем в отсортированный массив
        elif right_index == right_length:
            sorted_list.append(left_list[left_index])
            left_index += 1

    return sorted_list


def merge_sort_2(array):
    # Возвращаем список, если он состоит из одного элемента
    if len(array) <= 1:
        return array

    mid = len(array) // 2

    # Сортируем и объединяем подсписки
    left_list = merge_sort_2(array[:mid])
    right_list = merge_sort_2(array[mid:])

    # Объединяем отсортированные списки в результирующий
    return merge(left_list, right_list)


# python -m timeit -n 1000 "import merge" "merge.merge_sort_2(merge.mass)"
# 1000 loops, best of 5: 59.3 usec per loop


# РЕАЛИЗАЦИЯ 3

def merge_3(left_array, right_array):
    sorted_list = []
    left_index = 0
    right_index = 0
    while left_index < len(left_array) and right_index < len(right_array):
        if left_array[left_index] <= right_array[right_index]:
            sorted_list.append(left_array[left_index])
            left_index += 1
        else:
            sorted_list.append(right_array[right_index])
            right_index += 1
    sorted_list += left_array[left_index:] + right_array[right_index:]
    return sorted_list


def merge_sort_3(array):
    if len(array) <= 1:
        return array
    else:
        left_list = array[:len(array) // 2]
        right_list = array[len(array) // 2:]
    return merge_3(merge_sort_3(left_list), merge_sort_3(right_list))

# python -m timeit -n 1000 "import merge" "merge.merge_sort_3(merge.mass)"
# 1000 loops, best of 5: 56.8 usec per loop
