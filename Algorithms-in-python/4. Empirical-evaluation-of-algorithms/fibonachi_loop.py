import cProfile


#  Проверка
# def test_fib(func):
#     lst = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
#     for i, item in enumerate(lst):
#         assert item == func(i)
#         print(f'Test {i} OK')

def fib_loop(n):
    if n < 2:
        return n

    first, second = 0, 1
    for i in range(2, n + 1):
        first, second = second, first + second

    return second


# test_fib(fib_loop)

# python -m timeit -n 1000 "import fibonachi_loop" "fibonachi_loop.fib_loop(10)"
# 1000 loops, best of 5: 0.872 usec per loop

# python -m timeit -n 1000 "import fibonachi_loop" "fibonachi_loop.fib_loop(20)"
# 1000 loops, best of 5: 1.45 usec per loop

# python -m timeit -n 1000 "import fibonachi_loop" "fibonachi_loop.fib_loop(100)"
# 1000 loops, best of 5: 5.44 usec per loop

# >python -m timeit -n 1000 "import fibonachi_loop" "fibonachi_loop.fib_loop(500)"
# 1000 loops, best of 5: 30.7 usec per loop

# python -m timeit -n 1000 "import fibonachi_loop" "fibonachi_loop.fib_loop(5000)"
# 1000 loops, best of 5: 543 usec per loop

cProfile.run('fib_loop(10)')

'''
   ncalls  tottime  percall  cumtime  percall filename:lineno(function)
        1    0.000    0.000    0.000    0.000 fibonachi_loop.py:12(fib_loop) - 10
        1    0.000    0.000    0.000    0.000 fibonachi_loop.py:12(fib_loop) - 1000
'''
