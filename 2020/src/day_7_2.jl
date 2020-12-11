function rule(line)
    outer, inner = split(line, r" bags contain ")
    list = Dict{String,Int}()
    for m in eachmatch(r"(\d+) (.*?) bag", inner)
        n, bag = m.captures
        list[bag] = parse(Int, n)
    end
    return outer => list
end


function part1(rules)
    queue = [k for (k, v) in rules if haskey(v, "shiny gold")]
    found = Set(queue)
    while !isempty(queue)
        bag = pop!(queue)
        new = (k for (k, v) in rules if haskey(v, bag))
        union!(found, new)
        append!(queue, new)
    end
    return length(found)
end

function part2(rules)
    queue = ["shiny gold" => 1]
    found = Pair{String,Int}[]
    while !isempty(queue)
        bag, n = pop!(queue)
        new = (k => n * v for (k, v) in rules[bag])
        append!(found, new)
        append!(queue, new)
    end
    return sum(last, found)
end

rules = Dict(rule(line) for line in eachline("./2020/data/day_7.txt"))

queue = ["shiny gold" => 1]
found = Pair{String,Int}[]
while !isempty(queue)
    lq = length(queue)
    lf = length(found)
    println("#Queue: $lq -- #QFound: $lf")
    bag, n = pop!(queue)
    new = (k => n * v for (k, v) in rules[bag])
    println("$rules[bag]")
    append!(found, new)
    append!(queue, new)
end
println(sum(last, found))