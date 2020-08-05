# Генерация массива
import random

size = 10
array = [i for i in range(size)]
random.shuffle(array)
print(array)

'''
Напишем реализацию без использования памяти.
start - откуда сортируем массив  
end - где закончить сортировку

В данном случае, элементы будут перемещаться внутри самого массива, для этого нам нужны указатели для организации
рекурсивной сортировки
'''


def quick_sort_no_memory(array, start, end):
    if start >= end:
        return

    pivot = array[random.randint(start, end)]

    # Переменные i, j нужны для остлеживания индексов, они позволят менять элементы больше и меньше опорного местами
    i, j = start, end

    while i <= j:

        while array[i] < pivot:
            i += 1

        while array[j] > pivot:
            j -= 1

        if i <= j:
            array[i], array[j] = array[j], array[i]
            i, j = i + 1, j - 1
    # После завершения внешнего цикла While мы получим меньше опорного в левой части и больше опорного в правой
    quick_sort_no_memory(array, start, j)  # Сортируем левую часть, которая меньше
    quick_sort_no_memory(array, i, end)  # Сортируем правую часть


quick_sort_no_memory(array, 0, len(array) - 1)
print(array)
