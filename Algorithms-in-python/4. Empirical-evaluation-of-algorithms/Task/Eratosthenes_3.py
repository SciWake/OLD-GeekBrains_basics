import math


def erat(num):
    assert num <= 5761455, 'Слишком большой аргумент'
    pi_func = {
        4: 10,
        25: 10 ** 2,
        168: 10 ** 3,
        1229: 10 ** 4,
        9592: 10 ** 5,
        78498: 10 ** 6,
        664579: 10 ** 7,
        5761455: 10 ** 8,
    }

    for key in pi_func.keys():
        if num <= key:
            size = pi_func[key]
            break

    array = [True for _ in range(size)]
    array[:2] = [False, False]
    count = 0

    for m in range(2, size):
        if array[m]:

            count += 1
            if count == num:
                return m

            for j in range(m ** 2, size, m):
                array[j] = False
    return None


# python -m timeit -n 1000 "import Eratosthenes_3" "Eratosthenes_3.erat(10)"
# 1000 loops, best of 5: 14 usec per loop

# python -m timeit -n 1000 "import Eratosthenes_3" "Eratosthenes_3.erat(100)"
# 1000 loops, best of 5: 170 usec per loop

# python -m timeit -n 1000 "import Eratosthenes_3" "Eratosthenes_3.erat(1000)"
# 1000 loops, best of 5: 1.96 msec per loop

'''
Данная реализация получетсся весьма большой и по скорости не превосходит первую реализацию
'''
