### A Pluto.jl notebook ###
# v0.12.16

using Markdown
using InteractiveUtils

# ╔═╡ 3e0c149a-3350-11eb-0b17-7bea5d1a28d4
begin
	DAY = 5
	md"# 2020 Day $DAY"
end

# ╔═╡ 18080fe2-339b-11eb-34f0-f393638506fc
md"## Part 1"

# ╔═╡ 4e084a4e-339b-11eb-3ffc-41118215f226
md"*<Insert Description>*"

# ╔═╡ 24e1613c-339b-11eb-2976-59884053d1ee
input = split(read("../data/day_$DAY.txt", String))

# ╔═╡ a9da2b56-36c7-11eb-38c5-51bf188463f9
function partition(code::AbstractString,lower::Int,upper::Int)
	# Final iteration
	if (upper - lower == 1) & length(code) == 1
		if code[1] ∈ "FL"
			return lower
		else
			return upper
		end
	# Split and go recursive
	elseif (upper - lower > 2) & (length(code) > 1)
		middle = (upper - lower) ÷ 2 + lower
		if code[1] ∈ "FL"
			return partition(code[2:end],lower,middle)
		else
			return partition(code[2:end],middle+1,upper)
		end
	else
		throw(DomainError((code, lower, upper), "this input is bad"))
	end
end

# ╔═╡ 75423650-36c8-11eb-1b63-b3a86f084690
function get_row(boarding_pass::AbstractString)
	code = boarding_pass[1:7]
	return partition(code,0,127)
end

# ╔═╡ 14af022e-36ca-11eb-3a6c-737120328af3
@assert get_row("BFFFBBFRRR") == 70

# ╔═╡ 3c6af638-36ca-11eb-3b4a-a1eb6dbbfdfc
@assert get_row("FFFBBBFRRR") == 14

# ╔═╡ 3c6b5790-36ca-11eb-325f-5b39977ccab6
@assert get_row("BBFFBBFRLL") == 102

# ╔═╡ 8bd3528a-36c8-11eb-083b-4f795b8537de
function get_col(boarding_pass::AbstractString)
	code = boarding_pass[8:end]
	return partition(code,0,7)
end

# ╔═╡ 8b722b22-36c8-11eb-0870-81aa0ca325e2
@assert get_col("BFFFBBFRRR") == 7

# ╔═╡ a017e524-36ca-11eb-3ca8-099185680195
@assert get_col("FFFBBBFRRR") == 7

# ╔═╡ a018306a-36ca-11eb-0b9e-dd5c58259bc4
@assert get_col("BBFFBBFRLL") == 4

# ╔═╡ 1c865778-36c9-11eb-2a6d-63710b4917a1
function get_id(boarding_pass::AbstractString)
	col = get_col(boarding_pass)
	row = get_row(boarding_pass)
	return row*8+col
end

# ╔═╡ cc9399cc-36ca-11eb-338e-15e78e041ad6
@assert get_id("BFFFBBFRRR") == 567

# ╔═╡ 9f987d82-36d6-11eb-04e5-d749168db73c
maximum(get_id.(input))

# ╔═╡ 9136a95e-36d5-11eb-3ab2-719c2e16c155
# alternative solution
begin
	# make it into 01110111
	pass2binary(pass::AbstractString) = join((c ∈ "BR")*1 for c in pass)
	# convert that into a base 10 representation
	pass2id(pass::AbstractString) = parse(Int, pass2binary(pass); base=2)
	maximum(pass2id.(input))
end

# ╔═╡ 09abf424-36d7-11eb-1a53-67c78def2720
maximum(pass2id.(input))

# ╔═╡ d503722e-36d6-11eb-1634-1178998b10a8
pass2seat(pass) = parse(Int, map(c -> c ∈ ('R', 'B') ? '1' : '0', pass), base = 2)

# ╔═╡ fd392980-36d6-11eb-12f8-b7e499a15059
maximum(pass2seat.(input))

# ╔═╡ 96c8893e-36df-11eb-14bf-4dcc8dd0b9a7
(
	split(read("../data/day_$DAY.txt", String)) |>
	strings -> map.(c -> c ∈ ('R', 'B') ? '1' : '0', strings) |>
	binary_strings -> parse.(Int, binary_strings; base=2) |>
	maximum
)

# ╔═╡ 2088463e-3709-11eb-0f4f-dd0ffe4ca9ce
begin
	boarding_passes = split(read("../data/day_$DAY.txt", String))
	binary_strings = map.(c -> c ∈ ('R', 'B') ? '1' : '0', boarding_passes)
	seat_ids = parse.(Int, binary_strings; base=2)
	maximum(seat_ids)
end

# ╔═╡ 0c0945e2-36e0-11eb-2953-eda4795bc3b7
maximum(pipe_seatid.(input))

# ╔═╡ 249718d2-36e0-11eb-0258-d159b87e4641
"110010010" |> s -> parse(Int, s ; base=2)

# ╔═╡ 4e2a74a0-36f9-11eb-08b2-5f7f6263d020
"110010010" |> parse(Int, _ ; base=2)

# ╔═╡ 5f797e22-339d-11eb-1ff3-dda90f946838
md"## Part 2"

# ╔═╡ e3177eae-339e-11eb-3f9f-1f7230976832
md"*Find your seat, it's not in the list but -1 and +1 will be*"

# ╔═╡ 3efb171a-36cb-11eb-1005-af68bffb30aa
function part2(input)
	ids = sort(get_id.(input))
	for i in 2:length(ids)
		if ids[i] - ids[i-1] == 2
			return ids[i]-1
		end
	end
end

# ╔═╡ c7a03d02-36cb-11eb-31c3-df3892a9fdb4
part2(input)

# ╔═╡ a81ade6a-36cb-11eb-0935-d759440ebcfb
typof(input)

# ╔═╡ a2141e96-36cb-11eb-1d9d-89c94dc1a7fb
typeof(input)

# ╔═╡ 5c846a16-3707-11eb-0339-919634714fdc


# ╔═╡ Cell order:
# ╠═3e0c149a-3350-11eb-0b17-7bea5d1a28d4
# ╟─18080fe2-339b-11eb-34f0-f393638506fc
# ╠═4e084a4e-339b-11eb-3ffc-41118215f226
# ╠═24e1613c-339b-11eb-2976-59884053d1ee
# ╠═a9da2b56-36c7-11eb-38c5-51bf188463f9
# ╠═75423650-36c8-11eb-1b63-b3a86f084690
# ╠═14af022e-36ca-11eb-3a6c-737120328af3
# ╠═3c6af638-36ca-11eb-3b4a-a1eb6dbbfdfc
# ╠═3c6b5790-36ca-11eb-325f-5b39977ccab6
# ╠═8bd3528a-36c8-11eb-083b-4f795b8537de
# ╠═8b722b22-36c8-11eb-0870-81aa0ca325e2
# ╠═a017e524-36ca-11eb-3ca8-099185680195
# ╠═a018306a-36ca-11eb-0b9e-dd5c58259bc4
# ╠═1c865778-36c9-11eb-2a6d-63710b4917a1
# ╠═cc9399cc-36ca-11eb-338e-15e78e041ad6
# ╠═9f987d82-36d6-11eb-04e5-d749168db73c
# ╠═9136a95e-36d5-11eb-3ab2-719c2e16c155
# ╠═09abf424-36d7-11eb-1a53-67c78def2720
# ╠═d503722e-36d6-11eb-1634-1178998b10a8
# ╠═fd392980-36d6-11eb-12f8-b7e499a15059
# ╠═96c8893e-36df-11eb-14bf-4dcc8dd0b9a7
# ╠═2088463e-3709-11eb-0f4f-dd0ffe4ca9ce
# ╠═0c0945e2-36e0-11eb-2953-eda4795bc3b7
# ╠═249718d2-36e0-11eb-0258-d159b87e4641
# ╠═4e2a74a0-36f9-11eb-08b2-5f7f6263d020
# ╠═5f797e22-339d-11eb-1ff3-dda90f946838
# ╠═e3177eae-339e-11eb-3f9f-1f7230976832
# ╠═3efb171a-36cb-11eb-1005-af68bffb30aa
# ╠═c7a03d02-36cb-11eb-31c3-df3892a9fdb4
# ╠═a81ade6a-36cb-11eb-0935-d759440ebcfb
# ╠═a2141e96-36cb-11eb-1d9d-89c94dc1a7fb
# ╠═5c846a16-3707-11eb-0339-919634714fdc
