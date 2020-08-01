# 4. Определить, какое число в массиве встречается чаще всего.
import sys

mass = [1, 1, 1, 2, 2, 2, 2, 3, 4, 5, 5, 6]

print(f'mass = {sys.getsizeof(mass)}')
# mass = 76

count_numbers = {}
number = count = 0

for i in mass:
    if i not in count_numbers:
        count_numbers[i] = 1
    else:
        count_numbers[i] = count_numbers[i] + 1
    if count_numbers[i] > count:
        count = count_numbers[i]
        number = i

print(f'count_numbers = {sys.getsizeof(count_numbers)}')
# count_numbers = 196
print(f'number = {sys.getsizeof(number)}')
# number = 14
print(f'count = {sys.getsizeof(count)}')
# count = 14

print(f'Число {number} встречается {count} раз(a)')

print(sys.version, sys.platform)

# 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:20:19) [MSC v.1925 32 bit (Intel)] win32

'''
Проведя анализ получаем такие рещультаты:
# mass = 76
# count_numbers = 196
# number = 14
# count = 14
В текущей реализации много памяти для подсчёта требует словарь. Исправим это в следующей реализации
'''
