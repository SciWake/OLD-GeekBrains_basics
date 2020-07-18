import cProfile


# Проверка
def test_fib(func):
    lst = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
    for i, item in enumerate(lst):
        assert item == func(i)
        print(f'Test {i} OK')


def fib(n):
    if n < 2:
        return n
    return fib(n - 1) + fib(n - 2)


# test_fib(fib)

# python -m timeit -n 1000 -s "import fibonachi_recursion" "fibonachi_recursion.fib(10)"
# 1000 loops, best of 5: 18.8 usec per loop

# python -m timeit -n 1000 -s "import fibonachi_recursion" "fibonachi_recursion.fib(15)"
# 1000 loops, best of 5: 214 usec per loop

# python -m timeit -n 1000 -s "import fibonachi_recursion" "fibonachi_recursion.fib(20)"
# 1000 loops, best of 5: 2.63 msec per loop

# python -m timeit -n 1000 -s "import fibonachi_recursion" "fibonachi_recursion.fib(25)"
# 1000 loops, best of 5: 26.5 msec per loop


cProfile.run('fib(10)')
'''
   ncalls  tottime  percall  cumtime  percall filename:lineno(function)
    177/1    0.000    0.000    0.000    0.000 fibonachi_recursion.py:9(fib) - 10
    1973/1    0.001    0.000    0.001    0.001 fibonachi_recursion.py:9(fib) - 15
    21891/1    0.008    0.000    0.008    0.008 fibonachi_recursion.py:9(fib) - 20
    
'''

'''
Вывод: Скорость выполнения медленная даже при маленьких згаечениях функции
Экспоненциальная сложность выполнения алгоритма 2^O(n)
'''
