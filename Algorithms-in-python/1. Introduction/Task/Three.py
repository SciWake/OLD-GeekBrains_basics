# 3. Написать программу, которая генерирует в указанных пользователем границах:
# a. случайное целое число,
# b. случайное вещественное число,
# c. случайный символ.
# Для каждого из трех случаев пользователь задает свои границы диапазона.
# Например, если надо получить случайный символ от 'a' до 'f', то вводятся эти символы.
# Программа должна вывести на экран любой символ алфавита от 'a' до 'f' включительно.

import random as rd

select = input('[1] - Целое число\n'
               '[2] - Вещественное число\n'
               '[3] - Символ\n'
               'Выберите тип: ')
if select not in ['1', '2', '3']:
    print('Ошибка выбора типа')
    exit()

print('Выберите диапозон чисел')
start = input('От: ')
stop = input('До: ')

if select == '1':
    rand_result = rd.randint(int(start), int(stop))
    print(f'Ваш результат: {rand_result}')
elif select == '2':
    rand_result = rd.uniform(float(start), float(stop))
    print(f'Ваш результат: {rand_result:.3}')
elif select == '3':
    rand_result = rd.randint(ord(start), ord(stop))
    print(f'Ваш результат: {chr(rand_result)}')