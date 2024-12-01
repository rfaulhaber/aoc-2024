import re

def read_lines_from_file(path):
    with open(path) as file:
        return [line.rstrip() for line in file]

def lines_to_columns(lines):
    pattern = re.compile(r"(\d+)\s+(\d+)")
    return [(int(x),int(y)) for line in lines for (x,y) in pattern.findall(line)]

def part1(lines):
    cols = lines_to_columns(lines)
    left_col = sorted([x for (x, _) in cols])
    right_col = sorted([y for (_, y) in cols])

    diffs = [abs(y - x) for [x, y] in zip(left_col, right_col)]

    return sum(diffs)

def part2(lines):
    cols = lines_to_columns(lines)
    left_col = [x for (x, _) in cols]
    right_col = sorted([y for (_, y) in cols])

    freqs = [0]

    for x in left_col:
        for y in right_col:
            if x == y:
                freqs[-1] += 1
            if y > x:
                break
        freqs.append(0)

    return sum([x*y for [x,y] in zip(left_col, freqs[:-1])])
