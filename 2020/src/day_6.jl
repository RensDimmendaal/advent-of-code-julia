### A Pluto.jl notebook ###
# v0.12.16

using Markdown
using InteractiveUtils

# ╔═╡ 3e0c149a-3350-11eb-0b17-7bea5d1a28d4
begin
	DAY = 6
	md"# 2020 Day $DAY"
end

# ╔═╡ 18080fe2-339b-11eb-34f0-f393638506fc
md"## Part 1"

# ╔═╡ 4e084a4e-339b-11eb-3ffc-41118215f226
md"*Count if any members in the group have said yes to a question*"

# ╔═╡ 24e1613c-339b-11eb-2976-59884053d1ee
input = read("../data/day_$DAY.txt", String)

# ╔═╡ df1d1be2-36c6-11eb-07c6-493a612dd182
test_input = """
abc

a
b
c

ab
ac

a
a
a
a

b
"""

# ╔═╡ 6cc1348c-3786-11eb-07c8-bb4f6ddfe769
part1(input) = sum(length.(Set.(replace.((split(input,"\n\n")),"\n"=>""))))

# ╔═╡ cdea65a0-3786-11eb-2444-b7d482414e20
@assert part1(test_input) == 11

# ╔═╡ d5b57b6c-3786-11eb-13da-33cee18cfa8b
@assert part1(input)  == 6590

# ╔═╡ 5f797e22-339d-11eb-1ff3-dda90f946838
md"## Part 2"

# ╔═╡ e3177eae-339e-11eb-3f9f-1f7230976832
md"*Only count if all members in the group have said yes to a question*"

# ╔═╡ 5218903e-3789-11eb-11c2-ebed36baf6fe
function part2(input::AbstractString)
	group_strings = split.((split(input,"\n\n")))
	groups = [Set.(ls) for ls in group_strings] # array with list of sets	
	intersects = [intersect(group...) for group in groups]
	lengths = length.(intersects)
	return sum(lengths)
end

# ╔═╡ 6a2ab5da-3789-11eb-221f-7d829e2967b6
@assert part2(test_input) == 6

# ╔═╡ a8b55df0-3789-11eb-28c1-edc492b7060e
@assert part2(input) == 3288

# ╔═╡ 4afd939a-378d-11eb-1609-45e4f3fcd2f7
begin
	items = [(1,2,3),(4,5,6)]
	zitems = zip(items...)
	fun(a,b,c) =  a*b+c
	fun.(zitems...)
end

# ╔═╡ Cell order:
# ╠═3e0c149a-3350-11eb-0b17-7bea5d1a28d4
# ╟─18080fe2-339b-11eb-34f0-f393638506fc
# ╠═4e084a4e-339b-11eb-3ffc-41118215f226
# ╠═24e1613c-339b-11eb-2976-59884053d1ee
# ╠═df1d1be2-36c6-11eb-07c6-493a612dd182
# ╠═6cc1348c-3786-11eb-07c8-bb4f6ddfe769
# ╠═cdea65a0-3786-11eb-2444-b7d482414e20
# ╠═d5b57b6c-3786-11eb-13da-33cee18cfa8b
# ╟─5f797e22-339d-11eb-1ff3-dda90f946838
# ╠═e3177eae-339e-11eb-3f9f-1f7230976832
# ╠═5218903e-3789-11eb-11c2-ebed36baf6fe
# ╠═6a2ab5da-3789-11eb-221f-7d829e2967b6
# ╠═a8b55df0-3789-11eb-28c1-edc492b7060e
# ╠═4afd939a-378d-11eb-1609-45e4f3fcd2f7
