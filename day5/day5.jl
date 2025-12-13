using DataStructures

function parse_input(input_file)
    s = readlines(input_file)
    index = partialsortperm(s, 1) # find ""
    @views ranges, numbers = s[begin:index-1], s[index+1:end]

    ranges = ranges .|> x -> split(x, "-") .|> x -> parse.(Int, x)
    ranges = ranges .|> x -> range(x[1], x[2])

    numbers = numbers .|> x -> parse(Int, x)

    return ranges, numbers
end


function push_range!(set::DisjointSets{Any}, range::UnitRange{Int})
    repr = range.start
    for x in range
        if x ∉ set
            push!(set, x)
        end
        union!(a, repr, x)
    end
end


function part_1(input_file)
    ranges, numbers = parse_input(input_file)
    sets = DisjointSets()
    push_range!.(Ref(sets), ranges[begin:end])
    fresh = in.(num, Ref(a))
    return reduce(+, fresh)
end

function part_2(input_file, num=12)
    s = parse_input(input_file)
end
