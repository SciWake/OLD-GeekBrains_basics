import cProfile


# Проверка
def test_fib(func):
    lst = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
    for i, item in enumerate(lst):
        assert item == func(i)
        print(f'Test {i} OK')


def fib_dict(n):
    fib_d = {0: 0, 1: 1}

    def _fib_dict(n):
        if n in fib_d:
            return fib_d[n]

        fib_d[n] = _fib_dict(n - 1) + _fib_dict(n - 2)
        return fib_d[n]

    return _fib_dict(n)


# test_fib(fib_dict)

# python -m timeit -n 1000 -s "import memoization_dict" "memoization_dict.fib_dict(10)"
# 1000 loops, best of 5: 3.89 usec per loop

# python -m timeit -n 1000 -s "import memoization_dict" "memoization_dict.fib_dict(15)"
# 1000 loops, best of 5: 5.85 usec per loop

# python -m timeit -n 1000 -s "import memoization_dict" "memoization_dict.fib_dict(20)"
# 1000 loops, best of 5: 7.38 usec per loop

# python -m timeit -n 1000 -s "import memoization_dict" "memoization_dict.fib_dict(100)"
# 1000 loops, best of 5: 42.1 usec per loop

# python -m timeit -n 1000 -s "import memoization_dict" "memoization_dict.fib_dict(200)"
# 1000 loops, best of 5: 83.4 usec per loop

# python -m timeit -n 1000 -s "import memoization_dict" "memoization_dict.fib_dict(500)"
# 1000 loops, best of 5: 238 usec per loop

'''При n=1000 получем переполнение вызова функции, используем cProfile для оценки'''

cProfile.run('fib_dict(10)')
'''
   ncalls  tottime  percall  cumtime  percall filename:lineno(function)
     19/1    0.000    0.000    0.000    0.000 memoization_dict.py:15(_fib_dict) - 10
     39/1    0.000    0.000    0.000    0.000 memoization_dict.py:15(_fib_dict) - 20
     199/1    0.000    0.000    0.000    0.000 memoization_dict.py:15(_fib_dict) - 100
     999/1    0.001    0.000    0.001    0.001 memoization_dict.py:15(_fib_dict) - 500
'''

