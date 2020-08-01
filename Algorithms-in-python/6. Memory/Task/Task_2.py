import sys

mass = [1, 1, 1, 2, 2, 2, 2, 3, 4, 5, 5, 6]
print(f'mass = {sys.getsizeof(mass)}')
# mass = 76
N = len(mass)
print(f'N = {sys.getsizeof(N)}')
# N = 14
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

print(f'num = {sys.getsizeof(num)}')
# num = 14
print(f'max_frq = {sys.getsizeof(max_frq)}')
# max_frq = 14

'''
Проведя анализ получаем такие рещультаты:
# mass = 76
# N = 14
# num = 14
# max_frq = 14

В этой реализации мы избавились от словаря, что позволило уменьшить потребление памяти. Если массив будет больше, 
то потребление памяти увеличится  у переменной mass. Первая задача будет требовать ещё больше места под словарь, 
так как массив стал больше и чилсо элементов, которые требуется обработать станет больше.
'''
