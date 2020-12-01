### A Pluto.jl notebook ###
# v0.12.15

using Markdown
using InteractiveUtils

# ╔═╡ 2bf8e4c2-339b-11eb-1d49-7f1b210a650a
using DelimitedFiles

# ╔═╡ 3e0c149a-3350-11eb-0b17-7bea5d1a28d4
md"# 2020 Day 1"

# ╔═╡ 18080fe2-339b-11eb-34f0-f393638506fc
md"## Part 1"

# ╔═╡ 4e084a4e-339b-11eb-3ffc-41118215f226
md"Find two elements that sum to 2020 and multiply them"

# ╔═╡ 24e1613c-339b-11eb-2976-59884053d1ee
input = readdlm("../data/day_1.txt", ' ', Int, '\n');

# ╔═╡ 67af36ec-339b-11eb-2bea-b1b1d06816d1
begin 
	test_txt = """1721
	979
	366
	299
	675
	1456"""
	test_input = [parse(Int, x) for x in split(test_txt,"\n")]
end

# ╔═╡ c6762a40-339c-11eb-2313-a1266d053a73
17221 in test_input

# ╔═╡ bf6397c0-339b-11eb-346e-758d99ec2a5e
function find_sum_pairs(input::Array{Int},total::Int)
	for first_number in input
		second_number = total - first_number
		if second_number in input
			return [first_number, second_number]
		end
	end
end

# ╔═╡ d25fa824-339c-11eb-3cc2-75f419dc4740
begin
	test_pair = find_sum_pairs(test_input,2020)
	product_of_test_pair = test_pair[1] * test_pair[2]
	test_pair, product_of_test_pair
end

# ╔═╡ 0f8198aa-339d-11eb-0ae3-efa5f999b4f3
begin
	pair = find_sum_pairs(input,2020)
	product_of_pair = pair[1]*pair[2]
	pair, product_of_pair
end

# ╔═╡ 5f797e22-339d-11eb-1ff3-dda90f946838
md"## Part 2"

# ╔═╡ e3177eae-339e-11eb-3f9f-1f7230976832
md"Find the product of the triplet that sums to 2020"

# ╔═╡ 6b4a06e0-339d-11eb-0168-73ec316f0508
function find_sum_triplet(input::Array{Int},total::Int)
	for first_number in input
		remainder = total - first_number
		pair = find_sum_pairs(input, remainder)
		if pair != nothing
			return [first_number, pair[1], pair[2]]
		end
	end
end

# ╔═╡ 2fbb1bc0-339e-11eb-0917-376ee88ab59e
begin
	test_triplet = find_sum_triplet(test_input,2020)
	product_of_test_triplet = prod(test_triplet)
	test_triplet, product_of_test_triplet
end

# ╔═╡ 493f1fbc-339e-11eb-1d12-d1946e3f2f63
begin
	triplet = find_sum_triplet(input,2020)
	product_of_triplet = prod(triplet)
	triplet, product_of_triplet
end

# ╔═╡ Cell order:
# ╟─3e0c149a-3350-11eb-0b17-7bea5d1a28d4
# ╠═2bf8e4c2-339b-11eb-1d49-7f1b210a650a
# ╟─18080fe2-339b-11eb-34f0-f393638506fc
# ╟─4e084a4e-339b-11eb-3ffc-41118215f226
# ╠═24e1613c-339b-11eb-2976-59884053d1ee
# ╠═67af36ec-339b-11eb-2bea-b1b1d06816d1
# ╠═c6762a40-339c-11eb-2313-a1266d053a73
# ╠═bf6397c0-339b-11eb-346e-758d99ec2a5e
# ╠═d25fa824-339c-11eb-3cc2-75f419dc4740
# ╠═0f8198aa-339d-11eb-0ae3-efa5f999b4f3
# ╟─5f797e22-339d-11eb-1ff3-dda90f946838
# ╟─e3177eae-339e-11eb-3f9f-1f7230976832
# ╠═6b4a06e0-339d-11eb-0168-73ec316f0508
# ╠═2fbb1bc0-339e-11eb-0917-376ee88ab59e
# ╠═493f1fbc-339e-11eb-1d12-d1946e3f2f63
