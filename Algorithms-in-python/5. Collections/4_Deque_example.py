"Есть log file, куда постоянно добавляются ip-адреса. Задача просмотреть последние 10 ip-адресов"

from collections import deque

with open('big_log.txt', 'r', encoding='utf-8') as f:
    last_ten = deque(f, 10)

print(last_ten)
