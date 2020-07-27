'''Программа должна хранить значения ip-адреса и порта по умолчанию.
При этом пользователь, при запуске программы через консоль,
может в качестве ключей передать новый ip-адрес или порт.'''

import argparse  # позволяет работать с ключами в командной строке
from collections import ChainMap

defaults = {'ip': 'localhost',
            'port': 7777}  # Хранит значени по умалчанию для ip-адреса и порта

parser = argparse.ArgumentParser()
parser.add_argument('-i', '--ip')  # Добавление в парсер требуемых ключей
parser.add_argument('-p', '--port')

# Анализируем строку и сохраняем результат в одельный словарь
args = parser.parse_args()
new_dict = {key: value for key, value in vars(args).items() if value}

# Создаём файл с настройками, где будут ключи ChainMap
settings = ChainMap(new_dict, defaults)
print(settings['ip'])
print(settings['port'])

# python ChainMap_example.py --port 8080
