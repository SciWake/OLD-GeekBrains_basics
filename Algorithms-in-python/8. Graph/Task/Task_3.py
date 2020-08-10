# 3. Написать программу, которая обходит не взвешенный ориентированный граф без петель, в котором все вершины связаны,
# по алгоритму поиска в глубину (Depth-First Search).
# Примечания:
# a. граф должен храниться в виде списка смежности;
# b. генерация графа выполняется в отдельной функции, которая принимает на вход число вершин.

import random


def create_graph(vertex, percent=1.0):
    if 0 < percent <= 1:
        print('Данный диапозон невозможен')

    graph = {}

    for i in range(vertex):
        graph[i] = set()

        count = random.randrange(1, int(vertex * percent))
        while len(graph[i]) < count:
            edge = random.randrange(0, vertex)
            if edge != i:
                graph[i].add(edge)
    return graph


def dfs(graph, start):
    path = []
    parent = [None for _ in range(len(graph))]  # Родитель для каждой вершины
    is_visited = [False for _ in range(len(graph))]  # Если были в данной вершине, тогда True инчае False

    def _dfs(vertex):
        is_visited[vertex] = True
        path.append(vertex)

        for item in graph[vertex]:
            if not is_visited[item]:
                parent[item] = vertex
                _dfs(item)
                path.append(vertex)
        else:
            path.append(-vertex)

    _dfs(start)
    return parent, path


if __name__ == '__main__':
    graph = create_graph(10, 0.5)
    for key, value in graph.items():
        print(f'Вершина {key} соеденяется с вершинами {value}')

    start = 0  # Вершина с которой начинается обход
    parent, path = dfs(graph, start)
    print(parent)
    
    print('Путь движения')
    for i, vertex in enumerate(path):
        if i % 10 == 0:
            print()
        print(f'{vertex:>5};', end='')
