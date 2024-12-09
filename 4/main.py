import sys
import os

# some dirty load path manipulation so that we can import utils
utils_path = os.path.abspath("../utils/python")
sys.path.append(utils_path)

import utils
import solution

main = utils.main_maker(solution.part1, solution.part2, utils.read_lines_from_file)

if __name__ == '__main__':
    main()
