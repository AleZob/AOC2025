function parse_input(input_file)
    s = readlines(input_file) .|> x -> split(x, "") .|> x -> x == "@"
    return stack(s)'
end

function summation_kernel(A)
    out = zeros(size(A)) .|> Int
    R = CartesianIndices(A)
    Ifirst, Ilast = first(R), last(R)
    step = oneunit(Ifirst)
    for I in R
        !A[I] && continue
        s = 0
        for J in max(Ifirst, I - step):min(Ilast, I + step)
            s += A[J]
        end
        out[I] = s
    end
    out
end

function part_1(input_file)
    s = parse_input(input_file)
    count = summation_kernel(s)
    accesible = count .|> x -> x != 0 && x < 4 + 1
    return reduce(+, accesible)
end


function part_2(input_file, num=12)
    s = parse_input(input_file)
end
