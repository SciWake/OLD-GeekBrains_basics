# 5. В массиве найти максимальный отрицательный элемент. Вывести на экран его значение и позицию в массиве.

array = [-1, -2, 4, 5, 6, 7, 10, 2, 11]
index = None

for i, num in enumerate(array):
    if num < 0 and (True if index is None else array[i] > array[index]):
        index = i

print(index) if index is None else print(f'Минимальный элемент в массиве {array[index]} с позицией {index}')
