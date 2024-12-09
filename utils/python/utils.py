import sys

def read_lines_from_file(path):
    with open(path) as file:
        return [line.rstrip() for line in file]


# if only python had macros!
# not very pythonic, but gets the job done
def main_maker(part1, part2, input_parser):
    def main_func():
        if len(sys.argv) < 3:
            print("You forgot arguments! Specify a part and an input file path!")
            exit(1)

        part = sys.argv[1]
        file = sys.argv[2]

        input = input_parser(file)

        if part == "1":
            s = part1(input)
            print(f"part 1:\t{s}")
        elif part == "2":
            s = part2(input)
            print(f"part 2:\t{s}")
        else:
            print(f"I don't know what {part} is!")

    return main_func
