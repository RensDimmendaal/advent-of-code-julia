input = read("2020/data/day_8.txt", String)

test_input = """
nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6
"""

mutable struct State
    total::Int
    index::Int
    used_codes::Array{Int,1}
end

function apply_rule!(state::State, rule::AbstractString)
    push!(state.used_codes, state.index)

    key, str_val = split(rule)
    val = parse(Int, str_val)

    if key == "nop"
        state.index += 1
    elseif key == "jmp"
        state.index += val
    elseif key == "acc"
        state.total += val
        state.index += 1
    end
    # @info state
end

function run_program(rules)
    state = State(0, 1, [])
    for unused in 1:length(rules)  # theoretical max iterations
        if state.index ∈ state.used_codes
            return (state, "ERROR: Infinite Loop")
        elseif state.index == length(rules) + 1
            return state, "SUCCESS"
        else
            rule = rules[state.index]
            apply_rule!(state, rule)
        end
    end
end

function part_1(input)
    rules = split(strip(input), "\n")

    state, exit_code = run_program(rules)
    @assert exit_code == "ERROR: Infinite Loop"
    state
end
@assert part_1(test_input).total == 5
@info part_1(input)

function part_2(input)
    state = State(0, 1, [])
    rules = split(strip(input), "\n")

    for i in 1:length(rules)
        if occursin("nop", rules[i]) | occursin("jmp", rules[i])
            new_rules = copy(rules)
            if occursin("nop", rules[i])
                new_rules[i] = replace(rules[i], "nop" => "jmp")
            else
                new_rules[i] = replace(rules[i], "jmp" => "nop")
            end
            state, exit_code = run_program(new_rules)
            if exit_code == "SUCCESS"
                return state, i
            end
        end
    end
end
@info part_2(input)
