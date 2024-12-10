
def part1(input):
    sum = 0

    directions = [(-1,-1), (-1,0), (-1,1), (0,-1), (0,1), (1,-1), (1,0), (1,1)]

    # this is so ugly....
    for (x, row) in enumerate(input):
        for (y, char) in enumerate(row):
            if char == 'X':
                for (ax, ay) in directions:
                    (sx, sy) = tuple_add((x, y), (ax, ay))
                    (tx, ty) = tuple_add((sx, sy), (ax, ay))
                    (fx, fy) = tuple_add((tx, ty), (ax, ay))

                    if sx >= 0 and sy >= 0 and tx >= 0 and ty >= 0 and fx >= 0 and fy >= 0 and sx < len(input) and tx < len(input) and sy < len(row) and ty < len(row) and fx < len(input) and fy < len(row) and input[sx][sy] == 'M' and input[tx][ty] == 'A' and input[fx][fy] == 'S':
                        sum += 1

    return sum

def part2(input):
    sum = 0

    directions = [(-1, -1), (1, 1), (1, -1), (1, 1)]

    for (x, row) in enumerate(input):
        for (y, char) in enumerate(row):
            if char == 'A':
                maxX = len(input)
                maxY = len(row)

                in_bounds = tuple_in_bounds(maxX, maxY)

                up_left = tuple_add((x, y), (-1, -1))
                up_right = tuple_add((x, y ), (1, -1))
                down_left = tuple_add((x, y), (-1, 1))
                down_right = tuple_add((x, y), (1, 1))

                if all([in_bounds(pos) for pos in [up_left, up_right, down_left, down_right]]):
                    up_left_char = input[up_left[0]][up_left[1]]
                    up_right_char = input[up_right[0]][up_right[1]]
                    down_left_char = input[down_left[0]][down_left[1]]
                    down_right_char = input[down_right[0]][down_right[1]]

                    diag_one = [up_left_char, down_right_char]
                    diag_two = [up_right_char, down_left_char]

                    if diag_one.count('M') == 1 and diag_one.count('S') == 1 and diag_two.count('M') == 1 and diag_two.count('S') == 1:
                        sum += 1

    return sum

def tuple_add(l, r):
    (lx, ly) = l
    (rx, ry) = r

    return (lx + rx, ly + ry)

def tuple_in_bounds(x, y):
    def in_bounds(tup):
        (tx, ty) = tup

        return tx >= 0 and ty >= 0 and tx < x and ty < y

    return in_bounds
