### A Pluto.jl notebook ###
# v0.12.16

using Markdown
using InteractiveUtils

# ╔═╡ 4de51e08-3854-11eb-10f2-d17580deef9c
begin
	using Pkg
	Pkg.add(["AbstractTrees"])
end

# ╔═╡ 2ac17898-3856-11eb-1235-4fd15bc1592c
begin
	using AbstractTrees
end

# ╔═╡ 3e0c149a-3350-11eb-0b17-7bea5d1a28d4
begin
	DAY = 7
	md"# 2020 Day $DAY"
end

# ╔═╡ 18080fe2-339b-11eb-34f0-f393638506fc
md"## Part 1"

# ╔═╡ 4e084a4e-339b-11eb-3ffc-41118215f226
md"*Bags*"

# ╔═╡ 24e1613c-339b-11eb-2976-59884053d1ee
input = read("../data/day_$DAY.txt", String)

# ╔═╡ df1d1be2-36c6-11eb-07c6-493a612dd182
test_input = """
light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags.
"""

# ╔═╡ fefa6924-3850-11eb-067a-5f62b6570b06


# ╔═╡ 0f76e99c-3851-11eb-113c-0136765cd4c4


# ╔═╡ 5f974aa2-3851-11eb-2198-09a8c6d7881a
function get_edges(line::AbstractString)
	raw_container, contents = split(line,"contain")
	container = raw_container[1:end-6]
	bags = (
		split(contents,",")
		.|> strip
		.|> s -> replace(s, "s." => "")
		# container, content, number
		.|> s -> [container, strip(s[3:end-4]), parse(Int,s[1])]
		)
end

# ╔═╡ 3858684c-3857-11eb-3506-4f1c87a22921
function input2edges(input)
	(
	[s for s in split(strip(input),"\n") if !occursin("no other bags",s)]
	.|> get_edges
	|> nested_list -> [item for sublist in nested_list for item in sublist]
)
end

# ╔═╡ d7a2264a-3859-11eb-3ac9-a176933f2063
function edges2colors(edges)
	container, content, number = zip(edges...)
	union(Set(container),Set(content))
end

# ╔═╡ 00aec94e-385a-11eb-3985-b9a159435b1a
function edges2mapping(edges)
	colors = edges2colors(edges)
	d = Dict(c => [] for c in colors)
	for (o, i, n) in edges
		push!(d[i],o)
	end
	return d
end

# ╔═╡ 46c193da-385a-11eb-31a6-25e4eda23b35


# ╔═╡ 4fef820e-385b-11eb-1f9a-ff3310d2340c
function find_parent!(outer_colors,d,c)
	for color in d[c]
		if color ∉ outer_colors
			push!(outer_colors, color)
			find_parent!(outer_colors,d,color)
		end
	end
end

# ╔═╡ 31101e58-385f-11eb-2afa-55f88de38916
e = input2edges(input)

# ╔═╡ 6310ea54-385f-11eb-25b2-a353f8585388
mapping = edges2mapping(e)

# ╔═╡ 863e77da-385f-11eb-19a6-53f6116e4a24
colors = [i for i in edges2colors(e)]

# ╔═╡ 7e22f556-3893-11eb-38d2-1bfc0441a8ad
function find_parents(e,mapping,color)
	outer_colors = Set()
	return find_parent!(outer_colors,mapping,color)
end

# ╔═╡ 91204704-38bf-11eb-298c-6995aa085a06
begin
	outer_colors = Set()
	find_parent!(outer_colors,mapping,"shiny gold")
	outer_colors
end

# ╔═╡ 1b524b64-385e-11eb-17b1-d920e32aab0c


# ╔═╡ 2801d0ec-38c1-11eb-28dc-3ff0a89ee9a7
e

# ╔═╡ 5f797e22-339d-11eb-1ff3-dda90f946838
md"## Part 2"

# ╔═╡ e3177eae-339e-11eb-3f9f-1f7230976832
md"*<Insert Description>*"

# ╔═╡ Cell order:
# ╠═3e0c149a-3350-11eb-0b17-7bea5d1a28d4
# ╟─18080fe2-339b-11eb-34f0-f393638506fc
# ╠═4e084a4e-339b-11eb-3ffc-41118215f226
# ╠═4de51e08-3854-11eb-10f2-d17580deef9c
# ╠═2ac17898-3856-11eb-1235-4fd15bc1592c
# ╠═24e1613c-339b-11eb-2976-59884053d1ee
# ╠═df1d1be2-36c6-11eb-07c6-493a612dd182
# ╟─fefa6924-3850-11eb-067a-5f62b6570b06
# ╟─0f76e99c-3851-11eb-113c-0136765cd4c4
# ╠═5f974aa2-3851-11eb-2198-09a8c6d7881a
# ╠═3858684c-3857-11eb-3506-4f1c87a22921
# ╠═d7a2264a-3859-11eb-3ac9-a176933f2063
# ╠═00aec94e-385a-11eb-3985-b9a159435b1a
# ╟─46c193da-385a-11eb-31a6-25e4eda23b35
# ╠═4fef820e-385b-11eb-1f9a-ff3310d2340c
# ╠═31101e58-385f-11eb-2afa-55f88de38916
# ╠═6310ea54-385f-11eb-25b2-a353f8585388
# ╠═863e77da-385f-11eb-19a6-53f6116e4a24
# ╠═7e22f556-3893-11eb-38d2-1bfc0441a8ad
# ╠═91204704-38bf-11eb-298c-6995aa085a06
# ╟─1b524b64-385e-11eb-17b1-d920e32aab0c
# ╠═2801d0ec-38c1-11eb-28dc-3ff0a89ee9a7
# ╠═5f797e22-339d-11eb-1ff3-dda90f946838
# ╟─e3177eae-339e-11eb-3f9f-1f7230976832
