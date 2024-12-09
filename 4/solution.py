char_lookup = {
    'X': 'M',
    'M': 'A',
    'A': 'S',
    'S': None,
}

def part1(input):
    m = get_positions(input)
    adj_list = get_adjacency_list(m)
    paths = get_paths(adj_list)

    print(paths)

    return "part1"

def part2(input):
    return "part2"

def get_positions(input):
    matrix = []
    for (line, row) in enumerate(input):
        row_items = []
        for (i, item) in enumerate(row):
            row_items.append(((line, i), item))
        matrix.append(row_items)

    return matrix

def get_adjacent_positions(x, y):
    vals = [(x - 1, y - 1), (x, y - 1), (x + 1, y - 1),
            (x - 1, y),                 (x + 1, y),
            (x - 1, y + 1), (x, y + 1), (x + 1, y + 1)]

    return [(x, y) for (x, y) in vals if x >= 0 and y >= 0]

def get_relevant_adjacents(m, x, y):
    (pos, c) = m[x][y]
    next_char = char_lookup[c]

    if next_char == None:
        return []

    adjacents = [(ax, ay) for (ax, ay) in get_adjacent_positions(x, y) if ax < len(m[x]) and ay < len(m)]
    chars = [m[x][y] for (x, y) in adjacents]
    return [(p, ch) for (p, ch) in chars if ch == next_char]

def get_adjacency_list(m):
    adj = {}
    for row in m:
        for pos in row:
            ((x, y), _) = pos
            adjs = get_relevant_adjacents(m, x, y)
            if len(adjs) != 0:
                adj[pos] = adjs

    return adj

def get_paths(adj_list):
    print(adj_list)

    paths = []

    x_paths = []

    for (k, v) in adj_list.items():
        (_, kc) = k
        if kc == 'X':
            x_paths.append(k)

    m_paths = []

    for x_path in x_paths:
        for x_value in adj_list[x_path]:
            (_, kc) = x_value

            if kc == 'M':
                m_paths.append((x_path, x_value))

    a_paths = []
    for (x_path, m_value) in m_paths:
        for value in adj_list[m_value]:
            (_, kc) = value

            if kc == 'A' and value in adj_list:
                a_paths.append((x_path, m_value, value))

    s_paths = []
    for (x_path, m_value, a_value) in a_paths:
        for value in adj_list[a_value]:
            (_, kc) = value

            if kc == 'S' :
                s_paths.append((x_path, m_value, a_value, value))


    print(s_paths)
