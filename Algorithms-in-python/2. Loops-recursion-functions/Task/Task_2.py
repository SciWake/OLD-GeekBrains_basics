# 2. Посчитать четные и нечетные цифры введенного натурального числа. Например, если введено число 34560,
# в нем 3 четные цифры (4, 6 и 0) и 2 нечетные (3 и 5).

number = input('Введите число: ')

not_even_number = ''
even_number = ''

for num in number:
    if int(num) % 2 == 0:
        even_number += num
    else:
        not_even_number += num

print(f'В числе {number}:\n {len(even_number)} чётных цифр(ы) {even_number}'
      f"\n {len(number) - len(even_number)} нечётных цифр(ы) {not_even_number}")
