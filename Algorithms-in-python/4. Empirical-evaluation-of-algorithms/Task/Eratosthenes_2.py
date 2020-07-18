# 2. Написать два алгоритма нахождения i-го по счёту простого числа. Функция нахождения простого числа должна принимать
# на вход натуральное и возвращать соответствующее простое число. Проанализировать скорость и сложность алгоритмов.
import functools


@functools.lru_cache()
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


# python -m timeit -n 1000 "import Eratosthenes_2" "Eratosthenes_2.erat(10)"
# 1000 loops, best of 5: 201 nsec per loop

# python -m timeit -n 1000 "import Eratosthenes_2" "Eratosthenes_2.erat(100)"
# 1000 loops, best of 5: 192 nsec per loop

# python -m timeit -n 1000 "import Eratosthenes_2" "Eratosthenes_2.erat(1000)"
# 1000 loops, best of 5: 197 nsec per loop

'''
Используем метод оптимизации "мемоизация", в данном алогоритме есть смымол использовать мемоизацию.
Мы видим большой прирост к срорости выполнения кода.
'''
