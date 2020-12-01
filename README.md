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


