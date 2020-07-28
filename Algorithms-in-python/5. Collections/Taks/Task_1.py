# 1. Пользователь вводит данные о количестве предприятий, их наименования
# и прибыль за четыре квартала для каждого предприятия. Программа должна
# определить среднюю прибыль (за год для всех предприятий) и отдельно
# вывести наименования предприятий, чья прибыль выше среднего и ниже среднего.

from collections import OrderedDict

mean_profit = 0
k = int(input('Введите количество предприятий: '))

company = OrderedDict()

for i in range(1, k + 1):
    name = input('Введите название предприятия: ')
    company[name] = [float(input('Квартал 1: ')), float(input('Квартал 2: ')),
                     float(input('Квартал 3: ')), float(input('Квартал 4: '))]
    mean_profit += sum(company[name])

mean_profit /= k

max_company = []
min_company = []
[max_company.append(item[0]) if sum(item[1]) > mean_profit else min_company.append(item[0]) for item in company.items()]

print(f'Средняя прибыль предприятий за всё время = {mean_profit:.2f}\n'
      f'Предприятия, прибыль которых выше среднего = {max_company}\n'
      f'Предприятия, прибыль которых ниже среднего = {min_company}\n')