from collections import deque

'''Обращение к 1-му и последнему элементу очереди занимает O(1), к другим объектам О(n)'''

"Создадим 3 deque разных видов"
a = deque()
b = deque('abcdef')
c = deque([1, 2, 3, 4, 5])

print(a, b, c, sep='\n')
# deque([])
# deque(['a', 'b', 'c', 'd', 'e', 'f'])
# deque([1, 2, 3, 4, 5])


"Изменим максимальную длину очереди"
b = deque('abcdef', maxlen=3)
c = deque([1, 2, 3, 4, 5], maxlen=4)

print(b, c, sep='\n')
# deque(['d', 'e', 'f'], maxlen=3)
# deque([2, 3, 4, 5], maxlen=4)

"Очиста очереди"
c.clear()

print(c)
# deque([], maxlen=4)


"Добавление элементов в начало и конец очереди"
d = deque([i for i in range(5)])
d.append(5)  # Добавление элемента в конец очереди
d.appendleft(6)  # Добавление в начало очереди

print(d)
# deque([6, 0, 1, 2, 3, 4, 5])

"Добавление сразу нескольких элементов в очередь"
d.extend([7, 8, 9])
d.extendleft([10, 11, 12])

print(d)
# deque([12, 11, 10, 6, 0, 1, 2, 3, 4, 5, 7, 8, 9])


"Сделаем всё тоже, но ограничем максимальный размер очереди"
"Добавление элементов в начало и конец очереди"
d = deque([i for i in range(5)], maxlen=7)
d.append(5)  # Добавление элемента в конец очереди
d.appendleft(6)  # Добавление в начало очереди

print(d)
# deque([6, 0, 1, 2, 3, 4, 5], maxlen=7)

"Добавление сразу нескольких элементов в очередь"
d.extend([7, 8, 9])
d.extendleft([10, 11, 12])

print(d)
# deque([12, 11, 10, 2, 3, 4, 5], maxlen=7)


"Забрать элементы можно командой pop/popleft"
f = deque([i for i in range(5)], maxlen=7)
x = f.pop()
y = f.popleft()

print(f, x, y, sep='\n')
# deque([1, 2, 3], maxlen=7)
# 4
# 0


"Подсчёт количества входящих элементов"
g = deque([i for i in range(5)], maxlen=7)

print(g.count(2))
# 1

"Вернём позицию элемента в очереди"
print(g.index(3))
# 3

"Добавление элемента в середину очереди"
g.insert(2, 6)

print(g)
# deque([0, 1, 6, 2, 3, 4], maxlen=7)

"Разворот очереди"
g.reverse()

print(g)
# deque([4, 3, 2, 6, 1, 0], maxlen=7)

'''Команда rotate позволяет переместить n элементов из правой части очереди в 
левую, или из левой в правую если n отрицательный'''
g.rotate(3)

print(g)
# deque([6, 1, 0, 4, 3, 2], maxlen=7)
