function parse_input(input_file)::Vector{Vector{Int64}}
    s = readlines(input_file) .|> x -> split(x, "") .|> x -> parse.(Int, x)
    return s
end

function part_1(input_file)
    #idea find 2 maximal elements, construct the battaries from them
    s = parse_input(input_file)
    largest_digits = s .|> x -> partialsort(x, 1:2, rev=true)
    reverse_index = s .|> x -> partialsortperm(x, 1:2, rev=true)
    reverse_bool = reverse_index .|> x -> x[1] > x[2] ? true : false
    sum = 0
    for (k, (dig, rev)) in enumerate(zip(largest_digits, reverse_bool))
        if !rev
            calc = dig[1] * 10 + dig[2]
        else
            look = s[k][reverse_index[k][1]+1:end]
            if look == []
                calc = dig[2] * 10 + dig[1]
            else
                calc = dig[1] * 10 + partialsort(look, 1, rev=true)
            end
        end
        @info k calc
        sum += calc
    end
    return sum
end

function part_2(input_file)
    s = parse_input(input_file)
end
