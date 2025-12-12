function parse_input(input_file)::Vector{Vector{Int64}}
    s = readlines(input_file) .|> x -> split(x, "") .|> x -> parse.(Int, x)
    return s
end

function part_1(input_file)
    #idea find 2 maximal elements, construct the battaries from them
    s = parse_input(input_file)
    largest_digits = s .|> x -> partialsort(x, 1:2, rev=true)
    reverse_bool = s1 .|> x -> partialsortperm(x, 1:2, rev=true) |> x -> x[1] > x[2] ? true : false
    sum = 0
    for x in zip(largest_digits, reverse_bool)
        calc = x[2] ? x[1][2] * 10 + x[1][1] : x[1][1] * 10 + x[1][2]
        @show calc
        sum += calc
    end
    return sum
end

function part_2(input_file)
    s = parse_input(input_file)
end
