# 4. Определить, какое число в массиве встречается чаще всего.

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

