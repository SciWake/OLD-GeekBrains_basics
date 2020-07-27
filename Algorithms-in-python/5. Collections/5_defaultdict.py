from collections import defaultdict

'''defaultdict - это подкласс словаря (dict). Отличие от обычного, необходимо в качестве аргумента передать функцию'''

"Создадим defaultdict"
a = defaultdict()

print(a)
# defaultdict(None, {})


"Создадим строку"
s = 'dfsfsadfsadfasdfsaf'

"Подсчитаем сколько раз встречается каждое значение в строке"
b = defaultdict(int)
for i in s:
    b[i] += 1

print(b)
# defaultdict(<class 'int'>, {'d': 4, 'f': 6, 's': 5, 'a': 4})


'''Создадим список.
Первый элемент: название датчика
Второй элемент: статус данного датчика'''
list_1 = [('cat', 1), ('dog', 5), ('cat', 2), ('mouse', 1), ('dog', 1)]
c = defaultdict(list)
for k, v in list_1:  # k - ключ / v - значение
    c[k].append(v)

print(c)
# defaultdict(<class 'list'>, {'cat': [1, 2], 'dog': [5, 1], 'mouse': [1]})
# Теперь мы видим какие сгиналы каждый датчик нам передал


"Сделаем реализацию, где оставим только уникальные сигналы"
list_1 = [('cat', 1), ('dog', 5), ('cat', 2), ('cat', 1), ('mouse', 1),
          ('dog', 1), ('dog', 5)]
d = defaultdict(set)
for k, v in list_1:  # k - ключ / v - значение
    d[k].add(v)

print(d)
# defaultdict(<class 'set'>, {'cat': {1, 2}, 'dog': {1, 5}, 'mouse': {1}})


"Передача lambda функций"
f = defaultdict(lambda: 'unknown')
f.update(rex='dog', tomas='cat')

print(f)
# efaultdict(<function <lambda> at 0x00000207598081F8>, {'rex': 'dog', 'tomas': 'cat'})

"Выполним запросы по ключам"
print(f['rex'])
# dog

print(f['jerry'])
# unknown
