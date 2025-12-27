function parse_input(input_file)
    opers = Dict("*" => *, "+" => +)
    s = readlines(input_file) .|> x -> split(x, " ", keepempty=false)
    oper = s[end] .|> x -> opers[x]
    nums = s[1:end-1] .|> x -> x .|> x -> parse(Int, x)
    return stack(nums), oper
end

function part_1(input_file)
    num, oper = parse_input(input_file)
    cont = 0
    for (key, row) in enumerate(eachrow(num))
        cont += reduce(oper[key], row)
    end
    cont
end

function part_2(input_file)
end
