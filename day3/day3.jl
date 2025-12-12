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

function best_slice(x, num=12)
    indexes = partialsortperm(x, 1:num, rev=true)
    look = []
    for (k, index) in enumerate(indexes)
        look = x[index:end]
        look.size[1] >= num && break
    end
    if look.size[1] == num
        indexes = partialsortperm(look, 1:num, rev=true)
        sort!(indexes)
        num_view = view(look, indexes)
        reverse!(num_view)
        # @show num_view
        # @show num_view[1]
        # @show num_view[1] * 10^(1 - 1)
        # @show num_view[num] * 10^(num - 1)
        # @show sum(num_view[k] * 10^(k - 1) for k in 1:num)
        n = 0
        for k in 1:num
            n += num_view[k] * 10^(k - 1)
        end
        @show n
        return n
    else
        @show num
        return look[1] * 10^(num - 1) + best_slice(look[2:end], num - 1)
    end
end

function part_2(input_file, num=12)
    s = parse_input(input_file)
    sum = 0
    for x in s
        sum += best_slice(x)
    end
    return sum
end
