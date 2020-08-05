# Генерация массива
import random

size = 100
array = [i for i in range(-size, size)]
random.shuffle(array)
print(array)


def bubble_sort(array):
    for i in range(len(array)):
        for j in range(len(array) - i - 1):
            if array[j] > array[j + 1]:
                array[j], array[j + 1] = array[j + 1], array[j]


bubble_sort(array)
print(array)
