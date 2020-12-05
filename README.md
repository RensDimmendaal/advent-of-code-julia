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


