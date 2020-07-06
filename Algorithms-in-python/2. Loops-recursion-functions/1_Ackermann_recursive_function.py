#             [ n + 1,                    m = 0
# A(m, n) =   | A(m - 1, 1),              m > 0, n = 0
#             [ A(m - 1, A(m, n - 1)),    m > 0, n > 0

import sys

sys.setrecursionlimit(3000)


def akk(m, n):
    if m == 0:
        return n + 1
    elif m > 0 and n == 0:
        return akk(m - 1, 1)
    return akk(m - 1, akk(m, n - 1))


print(akk(3, 8))
