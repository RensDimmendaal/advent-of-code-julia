# https://adventofcode.com/2020/day/9

input = read("2020/data/day_9.txt", String)

test_input = """
35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576
"""

function part_1(input, preamble)
    numbers = parse.(Int, split(strip(input), "\n"))
    for idx in (preamble + 1):length(numbers)

        sums = [i + j for (i, j) in combinations(numbers[idx - preamble:idx - 1], 2) if i != j]
        if numbers[idx] ∉ sums
            return numbers[idx]
        end
    end
end
@assert part_1(test_input, 5) == 127
@info part_1(input, 25)

function part_2(input, preamble)
    invalid_number = part_1(input, preamble)
    numbers = parse.(Int, split(strip(input), "\n"))
    for i in 1:length(numbers)
        for j in (i + 1):length(numbers)
            total = sum(numbers[i:j])
            if total == invalid_number
                return maximum(numbers[i:j]) + minimum(numbers[i:j])
            # avoid continuing inner loop if you know sum is too high anyway
            elseif total > invalid_number
                break
            end
        end
    end
end
@assert part_2(test_input, 5) == 62
@info part_2(input, 25)
