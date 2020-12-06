# advent-of-code-julia
fail with advent of code, this time with julia

# Day 0 -- Setup Environment

Create a Manifest and Project.toml in the folder and automatically set the current julia project to the current folder with direnv.

```bash
echo "export JULIA_PROJECT=@." >.envrc
touch Manifest.toml
touch Project.toml
```

Install packages

```julia
]  # go into package mode
add AdventOfCode  # lets you automatically download the data, check docs for how to setup the cookie
add Pluto  # nice interactive programming environment
```

# Day 1 -- Syntax

A bit more setup 

```julia
using AdventOfCode
setup_files(2020,1)  # downloads the input file automatically
using Pluto
Pluto.run()  # starts up the pluto notebook server
```

Loading the real input

```julia
using DelimitedFiles
input = readdlm("../data/day_1.txt", ' ', Int, '\n');
```

Loading test input

```julia
test_txt = """1721
	979
	366
	299
	675
	1456"""
test_input = [parse(Int, x) for x in split(test_txt,"\n")]
```

Writing tests

```julia
@assert true != false
@assert nothing == nothing
@assert false != nothing
```

The actual assignment: for loop over te first number then see if te second is in the list
Part 2: If you have the first number then you can put the second number in the function of the first part to find the other two numbers

# Day 2 -- XOR

During part two you needed an exclusive or operation.
I thought it was a neat application for the nice symbols julia has for those operations

```julia
true ⊻ false
```

However later I realised that a simple unequal sign also works. Less cool, but neat in a different way.

```julia
true != false
```


# Day 3 -- Reading files...

Actual problem was easy, reading was hard. Especially making actual and test input consistent.
I've decided it's better to have consistency between test and real input rather than read in the actual input in the most efficient way.

```julia
input = read("../data/day_$DAY.txt", String)
test_input = """<some multiline>\nstring"""
```

For actual parsing this days input grid into a 2dim array:

```julia
function parse_input(input::String)
	lines = map(collect, split(input,"\n"))
	grid = permutedims(hcat(lines...))
	return grid .== '#'
end
```

# Day 4 -- Input validation...

I wish I knew how to do python's `f(*args)` in julia. below looks ugly:

```julia
all_valid(pair) = all([is_valid(t[1], t[2]) for t in pair])
```

I do like dot notatiaon versus list comprehensions in python though

```python
sum([square(x) for x in my_list])
```

```julia
sum(square.(my_list))
```

...just wish I knew how to do this for a function of multiple arguments and a list of (kw)args.

# Day 5 -- binary numbers

I don't know much about this stuff, guess its because i never studied computer science.
I solved the problem very naively with a `get_row` and `get_col` function using recursion.
It was a fun solution to write, but horribly inefficient...and everybody says you shouldn't use recursion.
On the julia zulip I saw that

> 8 * (row string converted to 7 bit integer) + (column string converted to 3 bit integer) is the same as just converting the whole string to a 10 bit integer

So I got to learn something new :-)

binary numbers are like "regular numbers", except they stick a zero to the end when you reach 1 instead of 9.
With regular numbers we go from 0 (zero) to 10 (ten) to 100 (hundred).
With binary numbers we go from 0 (zero) to 10 (two) to 100 (four).
Any easy way to count binary numbers is to go right to left, and keep doubling

```
"100" -> 0 * 1 =  0
   ^
"10 " -> 0 * 2 =  0
  ^
"1  " -> 1 * 4 =  4
 ^
===================== +
                  4
```

So "100" in binary is 4

```
"1011" -> 1 * 1 =  1
    ^  
"101 " -> 1 * 2 =  2
   ^
"10  " -> 0 * 4 =  0
  ^
"10  " -> 1 * 4 =  8
 ^  
===================== +
                  11
```

And "1011" in binary is 11. We can do that in julia like this:

```julia
parse(Int, "1011";base=2)
```

```julia
pass2binary(pass::AbstractString) = join((c ∈ "BR")*1 for c in pass)
pass2id(pass::AbstractString) = parse(Int, pass2bits(pass); base=2)
maximum(pass2id.(input))
```

using an inline map makes it even shorter (also from zulip)

```julia
seatid(s) = parse(Int, map(c -> c ∈ ('R', 'B') ? '1' : '0', s), base = 2)
```
I like how it uses map, and this inline if-else structure.

with some piping it's maybe even a bit more readable. I don't like having to use the anonymous function here, but the `_` character to signal which argument should be replaced.

```julia
# with pipe
pipe_seatid(s) = (
	map(c -> c ∈ ('R', 'B') ? '1' : '0', s) |>
	s -> parse(Int, s; base=2)
	)
```

