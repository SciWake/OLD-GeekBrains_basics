from collections import Counter

'''
Counter - Это подкласс словаря (dict). Неупорядоченная коллекция пар "ключ - значение", гда "значение" - частота
вхождения "ключа"
'''

"Создадим 4 Counter разных видов"
a = Counter()
b = Counter('abravasvsdsa')
c = Counter({'red': 2, 'blue': 4})
d = Counter(cats=4, dogs=5)

print(a, b, c, d)
# Counter()
# Counter({'a': 4, 's': 3, 'v': 2, 'b': 1, 'r': 1, 'd': 1})
# Counter({'blue': 4, 'red': 2})
# Counter({'dogs': 5, 'cats': 4})


"Вернём ключ которого нет в Counter b"
print(b['z'])
# 0
# Получили частоту встречаемости символа, в нашем случае это 0

"Добавим новый ключ'z' в Counter b, с значением равным 0, то ест 'z' не встречается в Counter b"
b['z'] = 0

print(b)
# Counter({'a': 4, 's': 3, 'v': 2, 'b': 1, 'r': 1, 'd': 1, 'z': 0})

"Метод elements() - возвращает набор итерируемых элементов, которые > 0"
print(list(b.elements()))
# ['a', 'a', 'a', 'a', 'b', 'r', 'v', 'v', 's', 's', 's', 'd']

'''Метод most_common() - возвращает список фильтруя его по частоте 
встречаемости, элементы которого кортежи'''
print(b.most_common(2))
# [('a', 4), ('s', 3)]


"Создаём новые колекции для последющих операций"
g = Counter(a=4, b=6, c=-2, d=0)
f = Counter(a=1, b=2, c=3, d=-2)

"g.subtract(f) производит вычитание Counter g - Counter f"
g.subtract(f)

print(g)
# Counter({'b': 4, 'a': 3, 'd': 2, 'c': -5})


"Преобразование типа Counter"
print(set(g))
# {'b', 'd', 'c', 'a'}
print(dict(g))
# {'a': 3, 'b': 4, 'c': -5, 'd': 2}

"Метод clear() очищает все элементы из Counter"
g.clear()
print(g)
# Counter()


"Создаём новые колекции для последющих операций"
x = Counter(a=3, b=1)
y = Counter(a=1, b=2)

"Произведём математические операции"
print(x + y)
# Counter({'a': 4, 'b': 3})

print(x - y)
# Counter({'a': 2})

print(x & y)
# Counter({'a': 1, 'b': 1})
# Возвращает такое количество значений, которое 1 и во 2 Counter

print(x | y)
# Counter({'a': 3, 'b': 2})
# Возвращает такое количество значений, которые есть в 1 или во 2 Counter


"Унарные операции"
z = Counter(a=2, b=-4)

print(+z)
# Counter({'a': 2})
# Оставляет только положительные числа

print(-z)
# Counter({'b': 4})
# Оставляет только отрицательные числа и меняет знак
