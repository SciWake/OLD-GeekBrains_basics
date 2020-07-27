'''
Задача. В log файл сервер добавляет ip-адреса, с которых пришёл запрос.
Проанализирвоать последние N адресов и сохранить в новый
файл пары значений 'ip-адрес - количество запросов'.
    Исключить локальные ip-адреса: 192.168.*.*
    Сохранить исходный порядок адресов.'''

"Анализируем последние 3000 адресов"
from collections import OrderedDict, defaultdict, deque

N = 3000
with open('big_log.txt', 'r', encoding='utf-8') as f:
    log = deque(f, N)

print(log)

data = OrderedDict()
spam = defaultdict(int)

for item in log:
    ip = item[:-1]

    if not ip.startswith('192.168'):
        spam[ip] += 1  # Считает ко-во запросов по ip-адресу
        data[ip] = 1  # Сохранение порядка ip-адресов

print(spam)
print(data)

data.update(spam)  # В словарь data добавляем ключи из словаря spam
print(data)

with open('data.txt', 'w', encoding='utf-8') as f:
    for key, value in data.items():
        f.write(f'{key} - {value}\n')
