# 4. Определить, какое число в массиве встречается чаще всего.
import sys

mass = [1, 1, 1, 2, 2, 2, 2, 3, 4, 5, 5, 6]

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

print(f'Число {number} встречается {count} раз(a)')

'''
Проведя анализ получаем такие рещультаты:
3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:20:19) [MSC v.1925 32 bit (Intel)] win32
 type = <class 'tuple'>, size = 36, object = ([1, 1, 1, 2, 2, 2, 2, 3, 4, 5, 5, 6], {1: 3, 2: 4, 3: 1, 4: 1, 5: 2, 6: 1}, 2, 4)
	 type = <class 'list'>, size = 76, object = [1, 1, 1, 2, 2, 2, 2, 3, 4, 5, 5, 6]
		 type = <class 'int'>, size = 14, object = 1
		 type = <class 'int'>, size = 14, object = 1
		 type = <class 'int'>, size = 14, object = 1
		 type = <class 'int'>, size = 14, object = 2
		 type = <class 'int'>, size = 14, object = 2
		 type = <class 'int'>, size = 14, object = 2
		 type = <class 'int'>, size = 14, object = 2
		 type = <class 'int'>, size = 14, object = 3
		 type = <class 'int'>, size = 14, object = 4
		 type = <class 'int'>, size = 14, object = 5
		 type = <class 'int'>, size = 14, object = 5
		 type = <class 'int'>, size = 14, object = 6
	 type = <class 'dict'>, size = 196, object = {1: 3, 2: 4, 3: 1, 4: 1, 5: 2, 6: 1}
		 type = <class 'tuple'>, size = 28, object = (1, 3)
			 type = <class 'int'>, size = 14, object = 1
			 type = <class 'int'>, size = 14, object = 3
		 type = <class 'tuple'>, size = 28, object = (2, 4)
			 type = <class 'int'>, size = 14, object = 2
			 type = <class 'int'>, size = 14, object = 4
		 type = <class 'tuple'>, size = 28, object = (3, 1)
			 type = <class 'int'>, size = 14, object = 3
			 type = <class 'int'>, size = 14, object = 1
		 type = <class 'tuple'>, size = 28, object = (4, 1)
			 type = <class 'int'>, size = 14, object = 4
			 type = <class 'int'>, size = 14, object = 1
		 type = <class 'tuple'>, size = 28, object = (5, 2)
			 type = <class 'int'>, size = 14, object = 5
			 type = <class 'int'>, size = 14, object = 2
		 type = <class 'tuple'>, size = 28, object = (6, 1)
			 type = <class 'int'>, size = 14, object = 6
			 type = <class 'int'>, size = 14, object = 1
	 type = <class 'int'>, size = 14, object = 2
	 type = <class 'int'>, size = 14, object = 4
300 - количество памяти

В текущей реализации много памяти для подсчёта требует словарь. Исправим это в следующей реализации
'''
