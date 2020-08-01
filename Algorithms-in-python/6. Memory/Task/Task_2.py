import sys

mass = [1, 1, 1, 2, 2, 2, 2, 3, 4, 5, 5, 6]

N = len(mass)
num = mass[0]
max_frq = 1

for i in range(N - 1):
    frq = 1
    for k in range(i + 1, N):
        if mass[i] == mass[k]:
            frq += 1
    if frq > max_frq:
        max_frq = frq
        num = mass[i]

if max_frq > 1:
    print(max_frq, 'раз(а) встречается число', num)
else:
    print('Все элементы уникальны')

'''
Проведя анализ получаем такие рещультаты:
3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:20:19) [MSC v.1925 32 bit (Intel)] win32
 type = <class 'tuple'>, size = 36, object = ([1, 1, 1, 2, 2, 2, 2, 3, 4, 5, 5, 6], 12, 2, 4)
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
	 type = <class 'int'>, size = 14, object = 12
	 type = <class 'int'>, size = 14, object = 2
	 type = <class 'int'>, size = 14, object = 4
118 - количество памяти

В этой реализации мы избавились от словаря, что позволило уменьшить потребление памяти. Если массив будет больше, 
то потребление памяти увеличится  у переменной mass. Первая задача будет требовать ещё больше места под словарь, 
так как массив стал больше и чилсо элементов, которые требуется обработать станет больше.
'''
