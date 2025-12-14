# using DataStructures
using ProgressMeter


function parse_input(input_file)
    s = readlines(input_file)
    index = partialsortperm(s, 1) # find ""
    @views ranges, numbers = s[begin:index-1], s[index+1:end]

    ranges = ranges .|> x -> split(x, "-") .|> x -> parse.(Int, x)
    ranges = ranges .|> x -> range(x[1], x[2])

    numbers = numbers .|> x -> parse(Int, x)

    return ranges, numbers
end

function combine_ranges(a::UnitRange, b::UnitRange)
    # ASSUME sort(a,b) <==> a,b
    # that is a.start < b.start, if a.start == b.start => a.stop < b.stop
    if b.start <= a.stop
        return UnitRange(a.start, b.stop)
    elseif a.stop == b.stop
        return a
    else
        @warn "Should not happend"
    end
end

function combination(A)
    out = zeros(size(A)) .|> Bool
    R = CartesianIndices(A)
    Ifirst, Ilast = first(R), last(R)
    step = oneunit(Ifirst)
    for I in R
        s = intersect(A[I], A[min(I + step, Ilast)])
        @show s A[I] A[min(I + step, Ilast)]
        if s.start < s.stop
            out[I] = 1

        end
    end
    out
end

# function push_range!(set::DisjointSets{Any}, range::UnitRange{Int})
#     repr = range.start
#     for x in range
#         if x ∉ set
#             push!(set, x)
#         end
#         union!(set, repr, x)
#     end
# end


function part_1(input_file)
    @showtime ranges, numbers = parse_input(input_file)
    @show size(ranges)
    @showtime sort!(ranges, by=last) # Because default sort is stable
    @showtime sort!(ranges, by=first)
    # combine_bollean = combination(ranges)
    # combined_ranges = []
    cont = 0
    @info "Entering the loop"
    @showprogress for i in numbers
        found = searchsortedlast(ranges, i, by=first)
        found == 0 && continue
        if i ∈ ranges[found]
            cont += 1
        end
    end
    return cont
end

function part_2(input_file, num=12)
    s = parse_input(input_file)
end
