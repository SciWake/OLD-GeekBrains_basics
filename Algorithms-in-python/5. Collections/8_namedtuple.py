'''namedtuple - именнованный кортеж, обеспечивающий достуа к
содержимому по именам'''

from collections import namedtuple

"Представим, что пишем игру, требуется соранить параметры игрока"

"Создадим кортеж"
hero_1 = ('Aaz', 'Izverg', 100, 0.0, 250)

print(hero_1[4])
# 250
# Проблема данного метода заключается в следующем:
# сложность обращения к данным


"Создадим класс, чтоб решить данную проблему"


class Person:

    def __init__(self, name, race, health, mana, strenght):
        self.name = name
        self.race = race
        self.health = health
        self.mana = mana
        self.strenght = strenght


hero_2 = Person('Aaz', 'Izverg', 100, 0.0, 250)
print(hero_2.mana)
# 0.0


"Воспользуемся namedtuple"
# (Слева) Указываем название нового класса New_Person
# (Справа) В качестве первого параметра передаём название нашего класса
# Можно записать вторую строку без , только использовать пробелы
New_Person = namedtuple('New_Person', 'name, race, health, mana, strenght')
hero_3 = New_Person('Aaz', 'Izverg', 100, 0.0, 250)

print(hero_3.race)
# Izverg


"Создадим характеристики нашего персонажа в списке"
"rename=True кортеж автоматически переименует недопустимые значения"
prop = ['name', '3race', 'health', '_mana', 'strenght']
New_Person_1 = namedtuple('New_Person_1', prop, rename=True)
hero_4 = New_Person_1('Aaz', 'Izverg', 100, 0.0, 250)

print(hero_4)
# New_Person_1(name='Aaz', _1='Izverg', health=100, _3=0.0, strenght=250)


"Создадим класс Point"
Point = namedtuple('Point', 'x, y, z')

p1 = Point(2, z=3, y=4)

print(p1)
# Point(x=2, y=4, z=3)


"method 1 - Передача списка как аргумент"
t = [5, 10, 15]
p2 = Point._make(t)

print(p2)
# Point(x=5, y=10, z=15)

"method 2 - Преобразование namedtuple в OrderDict"
d2 = p2._asdict()

print(d2)
# OrderedDict([('x', 5), ('y', 10), ('z', 15)])

"method 3 - OrderDict замена объекта в неизменяемом типе данных"
p3 = p2._replace(x=6)

print(p3)
# Point(x=6, y=10, z=15)

"method 4 - Просмотр полей у именнованного кортежа"
print(p3._fields)
# ('x', 'y', 'z')

"В (python 3.7) появилась возможность установить аргументы по умолчанию"
New_Point = namedtuple('New_Point', 'x, y, z', defaults=[0, 0])  # y, z = 0
p4 = New_Point(5)

print(p4)
# New_Point(x=5, y=0, z=0)

"method 5 - (python 3.7) Данный метод позволяет получить значение по умолчпнию"
print(p4._field_defaults)
# {'y': 0, 'z': 0}


"Создание именнованного кортежа на основе словаря"
dct = {'x': 10, 'y': 20, 'z': 30}
p5 = New_Point(**dct)

print(p5)
# New_Point(x=10, y=20, z=30)
