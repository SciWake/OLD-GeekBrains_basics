# 2. Написать два алгоритма нахождения i-го по счёту простого числа. Функция нахождения простого числа должна принимать
# на вход натуральное и возвращать соответствующее простое число. Проанализировать скорость и сложность алгоритмов.


def erat(n):
    sieve = [i for i in range(n)]
    sieve[1] = 0

    for i in range(2, n):

        if sieve[i] != 0:
            j = i * 2

            while j < n:
                sieve[j] = 0
                j += i

    result = [i for i in sieve if i != 0]
    return result

# python -m timeit -n 1000 "import Eratosthenes_1" "Eratosthenes_1.erat(10)"
# 1000 loops, best of 5: 2.43 usec per loop

# python -m timeit -n 1000 "import Eratosthenes_1" "Eratosthenes_1.erat(100)"
# 1000 loops, best of 5: 23.2 usec per loop

# python -m timeit -n 1000 "import Eratosthenes_1" "Eratosthenes_1.erat(1000)"
# 1000 loops, best of 5: 276 usec per loop