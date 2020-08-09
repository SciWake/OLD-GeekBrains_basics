'''
Поиск кратчайшего пути в ширину

1. Поместить вершину, с которого начинается поиск, в путсую очередь.
2. Извлечь из начала очереди вершину.
    а. Если вершина является целевой, то завершить поиск.
    b. В противном случае, в конце очереди добавляются все смежные вершины, которые ещё не пройдены и не находятся в
    очереди.
3. Если очередь пуста, то все вершины графа были просмотрены, следовательно, целевой узел недостижим из начального;
Завершить поиск.
'''

from collections import deque

graph = [
    [0, 1, 1, 0, 1, 0, 0, 0],
    [1, 0, 0, 0, 0, 0, 0, 0],
    [1, 0, 0, 0, 1, 0, 0, 0],
    [0, 0, 0, 0, 0, 1, 0, 0],
    [1, 0, 1, 0, 0, 0, 1, 0],
    [0, 0, 0, 1, 0, 0, 1, 1],
    [0, 0, 0, 0, 1, 1, 0, 1],
    [0, 0, 0, 0, 0, 1, 1, 0],
]


def bfs(graph, start, finish):
    parent = [None for _ in range(len(graph))]  # Родитель для каждой вершины
    is_visited = [False for _ in range(len(graph))]  # Если были в данной вершине, тогда True инчае False

    deq = deque([start])
    is_visited[start] = True

    while len(deq) > 0:

        current = deq.pop()

        if current == finish:
            break

        for i, vertex in enumerate(graph[current]):
            if vertex == 1 and not is_visited[i]:
                is_visited[i] = True
                parent[i] = current
                deq.appendleft(i)

    else:
        return f'Из вершины {start} нельзя попасть в вершину {finish}'

    cost = 0
    way = deque([finish])
    i = finish

    while parent[i] != start:
        cost += 1
        way.appendleft(parent[i])
        i = parent[i]
    cost += 1
    way.appendleft(start)

    return f'Кратчайший путь {list(way)} длинною в {cost} условных едениц'


s = int(input('От какой вершины идти: '))
f = int(input('До какой вершины идти: '))
print(bfs(graph, s, f))
