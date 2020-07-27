'''OrderedDict - это подкласс словаря dict, в котором элементы
(пары "ключ - значение") упорядочены.
OrderedDict запоминает порядок, в котором были добавлены "ключи"'''

from collections import OrderedDict

a = {'cat': 5, 'dog': 2, 'mouse': 4}
"Произведём сортировку по ключу"
new_a = OrderedDict(sorted(a.items(), key=lambda x: x[0]))

print(new_a)
# OrderedDict([('cat', 5), ('dog', 2), ('mouse', 4)])


b = {'cat': 5, 'dog': 2, 'mouse': 4}
"Произведём сортировку по значению"
new_b = OrderedDict(sorted(b.items(), key=lambda x: x[1]))

print(new_b)
# OrderedDict([('dog', 2), ('mouse', 4), ('cat', 5)])

"Сравним два словаря. Для него важен порядок"
print(new_a == new_b)
# False


"Перенесём в конец элемент"
new_b.move_to_end('mouse')

print(new_b)
# OrderedDict([('dog', 2), ('cat', 5), ('mouse', 4)])

"Перенесём в начало элемент"
new_b.move_to_end('mouse', last=False)

print(new_b)
# OrderedDict([('mouse', 4), ('dog', 2), ('cat', 5)])


"Удалим последний элемент"
new_b.popitem()

print(new_b)
# OrderedDict([('mouse', 4), ('dog', 2)])

"Удалим первый элемент"
new_b.popitem(last=False)

print(new_b)
# OrderedDict([('dog', 2)])


"При добавлении элемента в словарь, он будет добавлен в конец"
new_b['cow'] = 1

print(new_b)
# OrderedDict([('dog', 2), ('cow', 1)])

"Изменим ключ у значения, порядок не изменится"
new_b['dog'] = 8

print(new_b)
# OrderedDict([('dog', 8), ('cow', 1)])


"Сортировка по определённой характеристике"
new_c = OrderedDict(sorted(a.items(), key=lambda x: len(x[0])))

print(new_c)
# OrderedDict([('cat', 5), ('dog', 2), ('mouse', 4)])


"Вывод элементов в обратном порядке"
for key in reversed(new_c):
    print(key, new_c[key])
    # mouse 4
    # dog 2
    # cat 5
