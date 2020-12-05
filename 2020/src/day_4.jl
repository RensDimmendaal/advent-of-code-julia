### A Pluto.jl notebook ###
# v0.12.16

using Markdown
using InteractiveUtils

# ╔═╡ 3e0c149a-3350-11eb-0b17-7bea5d1a28d4
begin
	DAY = 4
	md"# 2020 Day $DAY"
end

# ╔═╡ 18080fe2-339b-11eb-34f0-f393638506fc
md"## Part 1"

# ╔═╡ 4e084a4e-339b-11eb-3ffc-41118215f226
md"*Allow passports without a 'cir' key to pass*"

# ╔═╡ 24e1613c-339b-11eb-2976-59884053d1ee
input = read("../data/day_$DAY.txt", String)

# ╔═╡ 3a0fa07a-3605-11eb-30ef-4598213ce6ec
test_input = """
ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
byr:1937 iyr:2017 cid:147 hgt:183cm

iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
hcl:#cfa07d byr:1929

hcl:#ae17e1 iyr:2013
eyr:2024
ecl:brn pid:760753108 byr:1931
hgt:179cm

hcl:#cfa07d eyr:2025 pid:166559648
iyr:2011 ecl:brn hgt:59in
"""

# ╔═╡ 08cd4892-362c-11eb-28d8-81540aa5945e
line2keys(line) = Set([split(entry,":")[1] for entry in split(line)])

# ╔═╡ 34846d78-362f-11eb-3547-4978e97e89d9
fields_raw = """
    byr (Birth Year)
    iyr (Issue Year)
    eyr (Expiration Year)
    hgt (Height)
    hcl (Hair Color)
    ecl (Eye Color)
    pid (Passport ID)
    cid (Country ID)
"""

# ╔═╡ 46ee77ec-362f-11eb-3c13-f384ed78a348
required_fields = Set([string(split(line)[1]) for line in split(strip(fields_raw),"\n")])

# ╔═╡ f08c3ad2-362f-11eb-295d-4ddac22b387f
delete!(required_fields,"cid")

# ╔═╡ 673d8218-366b-11eb-2a4d-f548f9d131ee
has_required_fields(line) = required_fields ⊆ line2keys(line) 

# ╔═╡ 8c68eb76-362e-11eb-300f-6b92a90010fa
function part1(input::String)
	sum([has_required_fields(line) for line in split(input,"\n\n")])
end

# ╔═╡ 4b3eb86a-3630-11eb-39c0-6d67c0f84a22
@assert part1(test_input) == 2

# ╔═╡ 53200a48-3630-11eb-05e9-99811ae65d11
part1(input)

# ╔═╡ 5f797e22-339d-11eb-1ff3-dda90f946838
md"## Part 2

Validate the values of fields too.
"

# ╔═╡ 6a522dd4-3641-11eb-1c9e-45074da49c82
line2pair(line) = [split(entry,":") for entry in split(line)]

# ╔═╡ 9ac14414-3641-11eb-33c4-75b9e4357068
function is_valid(key,value)
	if key == "byr"
		return 1920 ≤ parse(Int,value) ≤ 2002
	elseif key == "iyr"
		return 2010 ≤ parse(Int,value) ≤ 2020
	elseif key == "eyr"
		return 2020 ≤ parse(Int,value) ≤ 2030
	elseif key == "hgt"
		if last(value,2)=="cm"
			return return 150 ≤ parse(Int, value[1:end-2]) ≤ 193
		elseif last(value,2)=="in"
			return return 59 ≤ parse(Int, value[1:end-2]) ≤ 76
		else
			return false
		end
	elseif key == "hcl"
		return (
			(value[1] == '#') & 
			( Set(value[2:end]) ⊆ Set("0123456789abcdef")) &
			( length(value) == 7)
			)
	elseif key == "ecl"
		return value ∈ split("amb blu brn gry grn hzl oth")
	elseif key == "pid"
		# 9 digit number
		return length(value) == 9
	else
		return true
	end
end
	

# ╔═╡ 5189e182-3664-11eb-0dcc-f508fe33be4c
@assert is_valid("byr",   "2002") ==true

# ╔═╡ 6947baf8-3664-11eb-0ace-3f6c7f808068
@assert is_valid("byr", "2003") == false

# ╔═╡ 694808aa-3664-11eb-0443-c162e7388740
@assert is_valid("hgt",   "60in") ==true

# ╔═╡ 694e56b0-3664-11eb-0d26-b9e7b641b9f6
@assert is_valid("hgt",   "190cm") ==true

# ╔═╡ 694ee300-3664-11eb-11f7-49462e6aa1d2
@assert is_valid("hgt", "190in") == false

# ╔═╡ 69599412-3664-11eb-26c7-21afa8e93b9c
@assert is_valid("hgt", "190") == false

# ╔═╡ 695a2420-3664-11eb-0978-5be1861a5f49
@assert is_valid("hcl",   "#123abc") ==true

# ╔═╡ 69657fa2-3664-11eb-3056-a98b35ba51e3
@assert is_valid("hcl", "#123abz") == false

# ╔═╡ 696628c6-3664-11eb-2643-fd542cd9eab5
@assert is_valid("hcl", "123abc") == false

# ╔═╡ 6971b038-3664-11eb-2c31-c5245b309553
@assert is_valid("ecl",   "brn") ==true

# ╔═╡ 6972e2b4-3664-11eb-1052-af8fccaeac05
@assert is_valid("ecl", "wat") == false

# ╔═╡ 697f53fa-3664-11eb-3962-030d46f24ba7
@assert is_valid("pid",   "000000001") ==true

# ╔═╡ 69800c82-3664-11eb-2d6e-155e57cdc323
@assert is_valid("pid", "0123456789") == false

# ╔═╡ edc481a6-3664-11eb-1c02-797a3670af3f
[line2pair(line) for line in split(input,"\n\n")]

# ╔═╡ 3da5c12e-3669-11eb-1a79-73e9fad032e8
all_valid(pair) = all([is_valid(t[1], t[2]) for t in pair])

# ╔═╡ 05f62636-366b-11eb-1435-632abff666d1
is_valid_passport(line) = all_valid(line2pair(line)) & has_required_fields(line)

# ╔═╡ 42b157f0-3669-11eb-2abc-f16c5da1a521
function part2(input)
	sum(is_valid_passport.(split(input,"\n\n")))
end

# ╔═╡ dfa0bb9c-3668-11eb-26ae-59f47e74033f
invalid_passports = """
eyr:1972 cid:100
hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926

iyr:2019
hcl:#602927 eyr:1967 hgt:170cm
ecl:grn pid:012533040 byr:1946

hcl:dab227 iyr:2012
ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277

hgt:59cm ecl:zzz
eyr:2038 hcl:74454a iyr:2023
pid:3556412378 byr:2007
"""

# ╔═╡ fd483df0-3668-11eb-09f4-bb26699ab6bf
valid_passports = """
pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980
hcl:#623a2f

eyr:2029 ecl:blu cid:129 byr:1989
iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm

hcl:#888785
hgt:164cm byr:2001 iyr:2015 cid:88
pid:545766238 ecl:hzl
eyr:2022
"""

# ╔═╡ d95d9cbc-3665-11eb-131c-3f53f873ce71
@assert part2(invalid_passports) == 0

# ╔═╡ 5b8c1242-3669-11eb-2b51-2d878f04f456
@assert part2(valid_passports) == 3

# ╔═╡ dfff04d0-3669-11eb-37a8-67ede57fa4f6
part2(input)

# ╔═╡ Cell order:
# ╠═3e0c149a-3350-11eb-0b17-7bea5d1a28d4
# ╟─18080fe2-339b-11eb-34f0-f393638506fc
# ╠═4e084a4e-339b-11eb-3ffc-41118215f226
# ╠═24e1613c-339b-11eb-2976-59884053d1ee
# ╠═3a0fa07a-3605-11eb-30ef-4598213ce6ec
# ╠═08cd4892-362c-11eb-28d8-81540aa5945e
# ╠═34846d78-362f-11eb-3547-4978e97e89d9
# ╠═46ee77ec-362f-11eb-3c13-f384ed78a348
# ╠═f08c3ad2-362f-11eb-295d-4ddac22b387f
# ╠═673d8218-366b-11eb-2a4d-f548f9d131ee
# ╠═8c68eb76-362e-11eb-300f-6b92a90010fa
# ╠═4b3eb86a-3630-11eb-39c0-6d67c0f84a22
# ╠═53200a48-3630-11eb-05e9-99811ae65d11
# ╠═5f797e22-339d-11eb-1ff3-dda90f946838
# ╠═6a522dd4-3641-11eb-1c9e-45074da49c82
# ╠═9ac14414-3641-11eb-33c4-75b9e4357068
# ╠═5189e182-3664-11eb-0dcc-f508fe33be4c
# ╠═6947baf8-3664-11eb-0ace-3f6c7f808068
# ╠═694808aa-3664-11eb-0443-c162e7388740
# ╠═694e56b0-3664-11eb-0d26-b9e7b641b9f6
# ╠═694ee300-3664-11eb-11f7-49462e6aa1d2
# ╠═69599412-3664-11eb-26c7-21afa8e93b9c
# ╠═695a2420-3664-11eb-0978-5be1861a5f49
# ╠═69657fa2-3664-11eb-3056-a98b35ba51e3
# ╠═696628c6-3664-11eb-2643-fd542cd9eab5
# ╠═6971b038-3664-11eb-2c31-c5245b309553
# ╠═6972e2b4-3664-11eb-1052-af8fccaeac05
# ╠═697f53fa-3664-11eb-3962-030d46f24ba7
# ╠═69800c82-3664-11eb-2d6e-155e57cdc323
# ╠═edc481a6-3664-11eb-1c02-797a3670af3f
# ╠═3da5c12e-3669-11eb-1a79-73e9fad032e8
# ╠═05f62636-366b-11eb-1435-632abff666d1
# ╠═42b157f0-3669-11eb-2abc-f16c5da1a521
# ╠═dfa0bb9c-3668-11eb-26ae-59f47e74033f
# ╠═fd483df0-3668-11eb-09f4-bb26699ab6bf
# ╠═d95d9cbc-3665-11eb-131c-3f53f873ce71
# ╠═5b8c1242-3669-11eb-2b51-2d878f04f456
# ╠═dfff04d0-3669-11eb-37a8-67ede57fa4f6
