# Вариант № 1 (Циклический алгоритм основаный на вычитании)
def euclid_1(m, n):
    while m != n:
        if m > n:
            m -= n
        else:
            n -= m
    return m


# Вариант № 2 (Рекурсивный алгоритм основанный на нахождении остатка от деления)
def euclid_2(m, n):
    if n == 0:
        return m
    return euclid_2(n, m % n)


# Вариант № 3 (Циклический алгоритм основанный на нахождении остатка от деления)
def euclid_3(m, n):
    while n != 0:
        m, n = n, m % n
    return m
