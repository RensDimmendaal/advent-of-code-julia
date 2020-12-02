### A Pluto.jl notebook ###
# v0.12.15

using Markdown
using InteractiveUtils

# ╔═╡ 2bf8e4c2-339b-11eb-1d49-7f1b210a650a
using DelimitedFiles

# ╔═╡ 3e0c149a-3350-11eb-0b17-7bea5d1a28d4
begin
	DAY = 2
	md"# 2020 Day $DAY"
end

# ╔═╡ 18080fe2-339b-11eb-34f0-f393638506fc
md"## Part 1"

# ╔═╡ 4e084a4e-339b-11eb-3ffc-41118215f226
md"*A password is is valid if the character occurs between the lower and higher number of times.*"

# ╔═╡ 24e1613c-339b-11eb-2976-59884053d1ee
input = readdlm("../data/day_$DAY.txt", '\n');

# ╔═╡ 0dcf6e94-346d-11eb-10f4-bb7c5248522b
test_input = split("""1-3 a: abcde
1-3 b: cdefg
2-9 c: ccccccccc""","\n") 

# ╔═╡ 94a3659c-346d-11eb-1854-971ac36a57c7
row = test_input[1]

# ╔═╡ 7f6eb578-346d-11eb-050d-8396d5ae6c09
function parse_row(row)
	rest, password = split(row,": ")
	l, rest = split(rest,"-")
	u, char = split(rest," ")
	return parse(Int, l), parse(Int, u), char[1], password
end

# ╔═╡ 9876725e-346d-11eb-3b79-b3f9973d57ca
parse_row(row)

# ╔═╡ 028a6038-346e-11eb-057c-c9b6a9e9a12e
function is_valid_password_part_1(row)
	l, u, char, password = parse_row(row)
	n_chars = sum([char == c for c in password])
	if l ≤ n_chars ≤ u
		return true
	else
		return false
	end
end

# ╔═╡ 2fa28998-346f-11eb-0780-bf2d8ac8f835
part_1(input) = sum(is_valid_password_part_1.(input))

# ╔═╡ 5e2f24aa-346e-11eb-0429-610e74921e6f
@assert part_1(test_input) == 2

# ╔═╡ 438f54ca-346f-11eb-1103-ff18132314b4
part_1(input)

# ╔═╡ 5f797e22-339d-11eb-1ff3-dda90f946838
md"## Part 2"

# ╔═╡ e3177eae-339e-11eb-3f9f-1f7230976832
md"*Now the numbers are indexes and exactly one must match the required character*"

# ╔═╡ 85fa9e14-346f-11eb-3369-7f4fda1d3da2
function is_valid_password_part_2(row)
	l, u, char, password = parse_row(row)
	return (password[l] == char) ⊻ (password[u] == char)
end

# ╔═╡ bebc8de0-346f-11eb-3977-8745fed75644
part_2(input) = sum(is_valid_password_part_2.(input))

# ╔═╡ f1e5075c-346f-11eb-197a-ad88701d918f
@assert part_2(test_input) == 1

# ╔═╡ c6a335e8-346f-11eb-1b2f-ad88443694b6
part_2(input)

# ╔═╡ Cell order:
# ╠═3e0c149a-3350-11eb-0b17-7bea5d1a28d4
# ╠═2bf8e4c2-339b-11eb-1d49-7f1b210a650a
# ╟─18080fe2-339b-11eb-34f0-f393638506fc
# ╟─4e084a4e-339b-11eb-3ffc-41118215f226
# ╠═24e1613c-339b-11eb-2976-59884053d1ee
# ╠═0dcf6e94-346d-11eb-10f4-bb7c5248522b
# ╠═94a3659c-346d-11eb-1854-971ac36a57c7
# ╠═9876725e-346d-11eb-3b79-b3f9973d57ca
# ╠═7f6eb578-346d-11eb-050d-8396d5ae6c09
# ╠═028a6038-346e-11eb-057c-c9b6a9e9a12e
# ╠═2fa28998-346f-11eb-0780-bf2d8ac8f835
# ╠═5e2f24aa-346e-11eb-0429-610e74921e6f
# ╠═438f54ca-346f-11eb-1103-ff18132314b4
# ╟─5f797e22-339d-11eb-1ff3-dda90f946838
# ╠═e3177eae-339e-11eb-3f9f-1f7230976832
# ╠═85fa9e14-346f-11eb-3369-7f4fda1d3da2
# ╠═bebc8de0-346f-11eb-3977-8745fed75644
# ╠═f1e5075c-346f-11eb-197a-ad88701d918f
# ╠═c6a335e8-346f-11eb-1b2f-ad88443694b6
