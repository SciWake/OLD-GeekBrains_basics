import random

# Генерация массива
size = 10
array = [i for i in range(size)]
random.shuffle(array)
print(array)


def revers(array):
    for i in range(len(array) // 2):
        array[i], array[len(array) - i - 1] = array[len(array) - i - 1], array[i]


revers(array)
print(array)
