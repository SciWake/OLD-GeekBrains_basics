# 1. На улице встретились N друзей. Каждый пожал руку всем остальным друзьям (по одному разу). Сколько рукопожатий было?
# Примечание. Решите задачу при помощи построения графа.


def create_graph(n):
    if n < 2:
        return 0

    graph = []

    for i in range(n):
        for j in range(n):
            if i != j:
                graph.append((i, j))

    return graph


def friend(n):
    graph = create_graph(n)
    return len(graph) // 2


print(friend(4))
