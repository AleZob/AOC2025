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
    opers = Dict('*' => *, '+' => +)
    input_tape = stack(readlines(input_file))
    # oper = inputtape[:, end]
    cont = 0
    buff = []
    oper = +
    for row in reverse(eachrow(input_tape))
        # @show row
        # @show row[end] != ' '
        # if empty
        if join(row, "") == ' '^size(row)[1]
            @show reduce(oper, buff)
            cont += reduce(oper, buff)
            buff = []
            continue
        end
        # if we have op then this is last num
        if row[end] != ' '
            oper = opers[row[end]]
        end
        num = row[1:end-1] |> x -> join(x, "") |> x -> parse(Int, x)
        append!(buff, num)
    end
    @show reduce(oper, buff)
    cont += reduce(oper, buff) # forgot the edge case
    cont
end
