# Вариант 1
array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

number = int(input('Введите число для вставки: '))
position = int(input('На какую позицию вставить число: '))

array.append(None)
i = len(array) - 1

while i > position:
    array[i], array[i - 1] = array[i - 1], array[i]
    i -= 1

array[position] = number
print(array)

# Вариант 2
array_new = array[:position] + [number] + array[position:]
print(array_new)
