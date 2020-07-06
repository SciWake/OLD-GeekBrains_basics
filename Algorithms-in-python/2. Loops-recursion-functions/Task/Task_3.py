# 3. Сформировать из введенного числа обратное по порядку входящих в него цифр и вывести на экран.
# Например, если введено число 3486, надо вывести 6843.

number = int(input('Введите число: '))
revers_number = ''

for _ in str(number):
    revers_number += str(number % 10)
    number //= 10

print(revers_number)
