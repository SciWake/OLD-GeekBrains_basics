# Сравнение строк с помощью хеширования

import hashlib


def is_eq_sr(a: str, b: str, verbose=False) -> bool:
    assert len(a) > 0 and len(b) > 0, 'Строки не могут быт нулевыми'
    ha = hashlib.sha1(a.encode('utf-8')).hexdigest()
    hb = hashlib.sha1(b.encode('utf-8')).hexdigest()
    if verbose:
        print(f'hash 1 = {ha}\nhash 2 = {hb}')
    return ha == hb


s_1 = input('Введите строку 1: ')
s_2 = input('Введите строку 2: ')

print('Строки одинаковые' if is_eq_sr(s_1, s_2, True) else 'Строки разные')
