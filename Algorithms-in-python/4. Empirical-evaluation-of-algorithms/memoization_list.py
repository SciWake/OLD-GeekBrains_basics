import cProfile


# Проверка
def test_fib(func):
    lst = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
    for i, item in enumerate(lst):
        assert item == func(i)
        print(f'Test {i} OK')


def fib_list(n):
    fib_l = [None] * 1000
    fib_l[:2] = [0, 1]

    def _fib_list(n):
        if fib_l[n] is None:
            fib_l[n] = _fib_list(n - 1) + _fib_list(n - 2)
        return fib_l[n]

    return _fib_list(n)


# test_fib(fib_list)

# python -m timeit -n 1000 -s "import memoization_list" "memoization_list.fib_list(10)"
# 1000 loops, best of 5: 8.34 usec per loop

# python -m timeit -n 1000 -s "import memoization_list" "memoization_list.fib_list(20)"
# 1000 loops, best of 5: 11.1 usec per loop

# python -m timeit -n 1000 -s "import memoization_list" "memoization_list.fib_list(100)"
# 1000 loops, best of 5: 40.2 usec per loop

# python -m timeit -n 1000 -s "import memoization_list" "memoization_list.fib_list(200)"
# 1000 loops, best of 5: 75.5 usec per loop

# >python -m timeit -n 1000 -s "import memoization_list" "memoization_list.fib_list(500)"
# 1000 loops, best of 5: 205 usec per loop


'''При n=1000 получем переполнение вызова функции, используем cProfile для оценки'''

cProfile.run('fib_list(500)')
'''
   ncalls  tottime  percall  cumtime  percall filename:lineno(function)
     19/1    0.000    0.000    0.000    0.000 memoization_list.py:16(_fib_list) - 10
     39/1    0.000    0.000    0.000    0.000 memoization_dict.py:15(_fib_dict) - 20
     199/1    0.000    0.000    0.000    0.000 memoization_dict.py:15(_fib_dict) - 100
     999/1    0.001    0.000    0.001    0.001 memoization_dict.py:15(_fib_dict) - 500
'''
