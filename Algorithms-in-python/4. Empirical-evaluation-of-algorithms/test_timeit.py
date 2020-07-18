import timeit

print(timeit.timeit('x = 2 + 2'))
# 0.0158134

print(timeit.timeit('x = sum(range(10))'))
# 0.5026959


'''Запустим модуль timeit в терминале'''
# python -m timeit -n 100 -s "import test_timeit"
# -n количество запуска кода, в нашем случае это 100 раз
# 100 loops, best of 5: 9 nsec per loop


import cProfile


def get_len(array):
    return len(array)


def get_sum(array):
    s = 0
    for i in array:
        s += i
    return s


def main():
    lst = [i for i in range(10000000)]
    a = get_len(lst)
    b = get_sum(lst)


cProfile.run('main()')
'''
         8 function calls in 1.877 seconds

   Ordered by: standard name

   ncalls  tottime  percall  cumtime  percall filename:lineno(function)
        1    0.000    0.000    0.000    0.000 test_timeit.py:19(get_len)
        1    0.907    0.907    0.907    0.907 test_timeit.py:23(get_sum)
        1    0.000    0.000    1.763    1.763 test_timeit.py:30(main)
        1    0.856    0.856    0.856    0.856 test_timeit.py:31(<listcomp>)
        1    0.114    0.114    1.877    1.877 <string>:1(<module>)
        1    0.000    0.000    1.877    1.877 {built-in method builtins.exec}
        1    0.000    0.000    0.000    0.000 {built-in method builtins.len}
        1    0.000    0.000    0.000    0.000 {method 'disable' of '_lsprof.Profiler' objects}

'''
# 8 function calls in 1.877 seconds - Количество вывзванных функций за время
# ncalls - Количество вывзовов каждой строки
# tottime - Время выполнения данной строки
# percall - Время выполнения в процентах для одной строки
# cumtime - Время выполнения одной строки и например, функций, которые запускаются в этой строке
# percall - Время выполнения в процентах для cumtime
# filename:lineno(function) - Указание на строки, которые были проанализированы
