import random

size = 100
array = [i for i in range(0, 20)]
random.shuffle(array)
print(array)


def median(array, pivot_fn=random.choice):
    if len(array) % 2 == 1:
        return quickselect(array, len(array) / 2, pivot_fn)
    else:
        return 0.5 * (quickselect(array, len(array) / 2 - 1, pivot_fn) + quickselect(array, len(array) / 2, pivot_fn))


def quickselect(l, k, pivot_fn):
    if len(l) == 1:
        assert k == 0
        return l[0]

    pivot = pivot_fn(l)

    lows = []
    highs = []
    pivots = []
    for i in l:
        if i < pivot:
            lows.append(i)
        elif i > pivot:
            highs.append(i)
        else:
            pivots.append(i)

    if k < len(lows):
        return quickselect(lows, k, pivot_fn)
    elif k < len(lows) + len(pivots):
        return pivots[0]
    else:
        return quickselect(highs, k - len(lows) - len(pivots), pivot_fn)


print(median(array))
