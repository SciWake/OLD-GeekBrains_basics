def prime(n):
    lst = []
    for i in range(2, n + 1):
        for j in lst:
            if i % j == 0:
                break
        else:
            lst.append(i)
    return lst

# python -m timeit -n 1000 "import prime_number_1" "prime_number_1.prime(10)"
# 1000 loops, best of 5: 1.74 usec per loop

# python -m timeit -n 1000 "import prime_number_1" "prime_number_1.prime(100)"
# 1000 loops, best of 5: 25.1 usec per loop

# python -m timeit -n 1000 "import prime_number_1" "prime_number_1.prime(1000)"
# 1000 loops, best of 5: 814 usec per loop

'''
В сравнении с решетом эратосфена, данный алгоритм является более медленный
'''