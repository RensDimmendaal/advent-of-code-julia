# https://adventofcode.com/2020/day/11
input = read("2020/data/day_11.txt", String)

test_input = """
L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL
"""

function parse_input(input::String)
	lines = map(collect, split(strip(input), "\n"))
    grid = permutedims(hcat(lines...))
	return grid
end



function execute_one_round_part1(grid)
    new = copy(grid)
    nrows, ncols = size(grid)
    for c in 1:ncols
        for r in 1:nrows
            row_range = max(1, r - 1):min(nrows, r + 1)
            col_range = max(1, c - 1):min(ncols, c + 1)
            window = grid[row_range,col_range]

            if grid[r,c] == 'L'  # isempty
                if all(window .∈ ".L")  # all surround empty
                    new[r,c] = '#'
                end
            elseif grid[r,c] == '#' # is occupied
                if sum(window .== '#') >= 5 # 4 or more surround full  (+1 for self)
                    new[r,c] = 'L'
                end
            end
        end
    end
    new
end


function part_1(input)
    grid = parse_input(input)
    old = copy(grid)

    for i in 1:1000000
        new = execute_one_round_part1(old)
        if all(new .== old)
            return sum(new .== '#')
        else
            old = new
        end
    end
end
@assert part_1(test_input) == 37
@info part_1(input)


function get_neighbors(grid, idx)
    all_seats = findall(v -> v == 'L', grid)
    neighbors = []
    nrows, ncols = size(grid)

    # right
    for i in (idx[1] + 1):nrows
        candidate = CartesianIndex(i, idx[2])
        if candidate ∈ all_seats
            push!(neighbors, candidate)
            break
        end
    end

    # bottom right
    c = minimum([nrows - idx[1], ncols - idx[2]])  # ugly
    for i in 1:c
        candidate = CartesianIndex(idx[1] + i, idx[2] + i)
        if candidate ∈ all_seats
            push!(neighbors, candidate)
            break
        end
    end

    # bottom
    for col in (idx[2] + 1):ncols
        candidate = CartesianIndex(idx[1], col)
        if candidate ∈ all_seats
            push!(neighbors, candidate)
            break
        end
    end

    # bottom left
    c = minimum([idx[1] - 1, ncols - idx[2]])  # ugly
    for i in 1:c
        candidate = CartesianIndex(idx[1] - i, idx[2] + i)
        if candidate ∈ all_seats
            push!(neighbors, candidate)
            break
        end
    end

    # left
    for row in (idx[1] - 1):-1:1
        candidate = CartesianIndex(row, idx[2])
        if candidate ∈ all_seats
            push!(neighbors, candidate)
            break
        end
    end

    # top left
    c = minimum([idx[1] - 1, idx[2] - 1])  # ugly
    for i in 1:c
        candidate = CartesianIndex(idx[1] - i, idx[2] - i)
        if candidate ∈ all_seats
            push!(neighbors, candidate)
            break
        end
    end

    # top
    for col in (idx[2] - 1):-1:1
        candidate = CartesianIndex(idx[1], col)
        if candidate ∈ all_seats
            push!(neighbors, candidate)
            break
        end
    end

    # top right
    c = minimum([nrows - idx[1], idx[2] - 1])  # ugly
    for i in 1:c
        candidate = CartesianIndex(idx[1] + i, idx[2] - i)
        if candidate ∈ all_seats
            push!(neighbors, candidate)
            break
        end
    end
    return neighbors
end

function execute_one_round_part2(old, grid)
    new = copy(old)
    nrows, ncols = size(old)
    for c in 1:ncols
        for r in 1:nrows
            neighbors = get_neighbors(grid, CartesianIndex(r, c))
            window = [old[idx] for idx in neighbors]

            if old[r,c] == 'L'  # isempty
                if all(window .∈ ".L")  # all surround empty
                    new[r,c] = '#'
                end
            elseif old[r,c] == '#' # is occupied
                if sum(window .== '#') >= 5 # 4 or more surround full  (+1 for self)
                    new[r,c] = 'L'
                end
            end
        end
    end
    new
end

function part_2(input)
    grid = parse_input(input)
    old = copy(grid)
    for i in 1:1000000
        new = execute_one_round_part2(old, grid)
        if all(new .== old)
            return sum(new .== '#')
        else
            old = new
        end
    end
end
@assert part_2(test_input) == 26
# @info part_2("part 2 $input")