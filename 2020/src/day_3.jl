### A Pluto.jl notebook ###
# v0.12.16

using Markdown
using InteractiveUtils

# ╔═╡ 2bf8e4c2-339b-11eb-1d49-7f1b210a650a
using DelimitedFiles

# ╔═╡ 3e0c149a-3350-11eb-0b17-7bea5d1a28d4
begin
	DAY = 3
	md"# 2020 Day $DAY"
end

# ╔═╡ 18080fe2-339b-11eb-34f0-f393638506fc
md"## Part 1"

# ╔═╡ 4e084a4e-339b-11eb-3ffc-41118215f226
md"*<Insert Description>*"

# ╔═╡ 24e1613c-339b-11eb-2976-59884053d1ee
input = read("../data/day_$DAY.txt",String)

# ╔═╡ 3a854976-3531-11eb-11a3-9f976a15a484
test_input="""..##.........##.........##.........##.........##.........##.......
#...#...#..#...#...#..#...#...#..#...#...#..#...#...#..#...#...#..
.#....#..#..#....#..#..#....#..#..#....#..#..#....#..#..#....#..#.
..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#
.#...##..#..#...##..#..#...##..#..#...##..#..#...##..#..#...##..#.
..#.##.......#.##.......#.##.......#.##.......#.##.......#.##.....
.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#
.#........#.#........#.#........#.#........#.#........#.#........#
#.##...#...#.##...#...#.##...#...#.##...#...#.##...#...#.##...#...
#...##....##...##....##...##....##...##....##...##....##...##....#
.#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#"""

# ╔═╡ 4f43d440-3531-11eb-146a-87dc6a097671
function parse_input(input::String)
	lines = map(collect, split(strip(input),"\n"))
	grid = permutedims(hcat(lines...))
	return grid .== '#'
end

# ╔═╡ 677bfffc-3549-11eb-3a98-9b427086e291
grid = parse_input(input)

# ╔═╡ 6cdac000-3549-11eb-19a4-8f7b31617365
test_grid = parse_input(test_input)

# ╔═╡ 2a9d0e9a-353b-11eb-25be-91691063ebe8
struct Slope
	right :: Int
	down :: Int
end

# ╔═╡ 692ac206-352c-11eb-145c-09870dd70a59
function number_of_trees_hit(grid,slope::Slope)
	l, w = size(grid)
	trees = 0
	for i in 1:(l÷slope.down)
		row = 1 + (i-1) * slope.down
		col = 1 + ((i-1)*slope.right) % w
		trees += grid[row,col]
	end
	trees
end

# ╔═╡ 980fd572-3539-11eb-337e-b576b6828534
@assert number_of_trees_hit(test_grid,Slope(3,1)) == 7

# ╔═╡ b9e4243c-3539-11eb-2756-b15d2871fd3a
number_of_trees_hit(grid,Slope(3,1))

# ╔═╡ 5f797e22-339d-11eb-1ff3-dda90f946838
md"## Part 2"

# ╔═╡ e3177eae-339e-11eb-3f9f-1f7230976832
md"*More Slopes*"

# ╔═╡ f76e45a8-3539-11eb-08e4-3d7a927a1f83
begin
	@assert number_of_trees_hit(test_grid,Slope(1,1)) == 2
	@assert number_of_trees_hit(test_grid,Slope(3,1)) == 7
	@assert number_of_trees_hit(test_grid,Slope(5,1)) == 3
	@assert number_of_trees_hit(test_grid,Slope(7,1)) == 4
	@assert number_of_trees_hit(test_grid,Slope(1,2)) == 2
end

# ╔═╡ 04005abc-353b-11eb-0a87-619740b6667f
slopes = [Slope(1,1), Slope(3,1), Slope(5,1), Slope(7,1), Slope(1,2)]

# ╔═╡ 5ca2b0f2-353b-11eb-088b-5567569dcbbe
typeof(slopes)

# ╔═╡ 58792402-353b-11eb-2307-651f8d88994a
part2(grid,slopes) = prod(number_of_trees_hit(grid,slope) for slope in slopes)

# ╔═╡ 72316a6a-353b-11eb-3ce1-3bd721f6136a
@assert part2(test_grid,slopes) == 336

# ╔═╡ 7afd4df0-353b-11eb-2be5-d3d305edeb40
part2(grid,slopes)

# ╔═╡ Cell order:
# ╟─3e0c149a-3350-11eb-0b17-7bea5d1a28d4
# ╠═2bf8e4c2-339b-11eb-1d49-7f1b210a650a
# ╟─18080fe2-339b-11eb-34f0-f393638506fc
# ╠═4e084a4e-339b-11eb-3ffc-41118215f226
# ╠═24e1613c-339b-11eb-2976-59884053d1ee
# ╠═3a854976-3531-11eb-11a3-9f976a15a484
# ╠═4f43d440-3531-11eb-146a-87dc6a097671
# ╠═677bfffc-3549-11eb-3a98-9b427086e291
# ╠═6cdac000-3549-11eb-19a4-8f7b31617365
# ╠═2a9d0e9a-353b-11eb-25be-91691063ebe8
# ╠═692ac206-352c-11eb-145c-09870dd70a59
# ╠═980fd572-3539-11eb-337e-b576b6828534
# ╠═b9e4243c-3539-11eb-2756-b15d2871fd3a
# ╠═5f797e22-339d-11eb-1ff3-dda90f946838
# ╠═e3177eae-339e-11eb-3f9f-1f7230976832
# ╠═f76e45a8-3539-11eb-08e4-3d7a927a1f83
# ╠═04005abc-353b-11eb-0a87-619740b6667f
# ╠═5ca2b0f2-353b-11eb-088b-5567569dcbbe
# ╠═58792402-353b-11eb-2307-651f8d88994a
# ╠═72316a6a-353b-11eb-3ce1-3bd721f6136a
# ╠═7afd4df0-353b-11eb-2be5-d3d305edeb40
