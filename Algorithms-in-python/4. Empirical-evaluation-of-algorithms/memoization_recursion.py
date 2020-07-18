import cProfile
import functools


# Проверка
def test_fib(func):
    lst = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
    for i, item in enumerate(lst):
        assert item == func(i)
        print(f'Test {i} OK')


@functools.lru_cache()  # Используем технологию мемоизации для текцщей функции
def fib(n):
    if n < 2:
        return n
    return fib(n - 1) + fib(n - 2)


# test_fib(fib)

# python -m timeit -n 1000 -s "import memoization_recursion" "memoization_recursion.fib(10)"
# 1000 loops, best of 5: 87.9 nsec per loop

# python -m timeit -n 1000 -s "import memoization_recursion" "memoization_recursion.fib(100)"
# 1000 loops, best of 5: 96.3 nsec per loop

# python -m timeit -n 1000 -s "import memoization_recursion" "memoization_recursion.fib(200)"
# 1000 loops, best of 5: 92.4 nsec per loop


cProfile.run('fib(200)')
'''
   ncalls  tottime  percall  cumtime  percall filename:lineno(function)
     11/1    0.000    0.000    0.000    0.000 memoization_recursion.py:13(fib) - 10
    101/1    0.000    0.000    0.000    0.000 memoization_recursion.py:13(fib) - 100
    201/1    0.000    0.000    0.000    0.000 memoization_recursion.py:13(fib) - 200
'''

'''
Вывод: Скорость выполнения медленная даже при маленьких згаечениях функции
Экспоненциальная сложность выполнения алгоритма 2^O(n)
'''
