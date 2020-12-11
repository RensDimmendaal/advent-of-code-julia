# https://adventofcode.com/2020/day/10
using DataStructures
using BenchmarkTools

input = read("2020/data/day_10.txt", String)

test_input = """
28
33
18
42
31
14
46
20
48
47
24
23
49
45
19
38
39
11
1
32
25
35
8
17
7
9
4
2
34
10
3
"""

function parse_input(input)
    numbers = [0]
    inp = sort(parse.(Int, split(strip(input), "\n")))
    append!(numbers, inp)
    append!(numbers, numbers[end] + 3)
    numbers
end

function part_1(input)
    numbers = parse_input(input)
    counts = counter(numbers[2:end] - numbers[1:end - 1])
    counts[3] * counts[1]
end
# @info part_1(test_input)
@info part_1(input)

function part_2(input)
    numbers = parse_input(input)
    routes = zeros(Int, length(numbers))
    for (idx, n) in enumerate(numbers)
        if idx == 1
            routes[idx] = 1
        else
            is_connector = numbers[idx] - 3 .<= numbers .< numbers[idx]
            routes[idx] = sum(routes[is_connector])
        end
    end
    routes[end]
end
# @info part_2(test_input)
@info part_2(input)
# @btime part_2(input)
