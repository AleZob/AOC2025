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

function combine_ranges(a::UnitRange{Int64}, b::UnitRange{Int64})
    # ASSUME sort(a,b) <==> a,b
    # that is a.start < b.start, if a.start == b.start => a.stop < b.stop
    if a.start <= b.start <= a.stop <= b.stop
        return UnitRange(a.start, b.stop)
    elseif a.start <= b.start <= b.stop <= a.stop
        return a
    else
        @warn "Should not happend"
    end
end

function range_combiner!(ranges::Vector{UnitRange{Int64}})
    overlap = overlaps(ranges)
    overlaps_num = reduce(+, overlap)
    if overlaps_num == 0
        return ranges
    end
    R = CartesianIndices(ranges)
    step = oneunit(R[1])
    for (rangeindex, over) in zip(reverse(R), reverse(overlap))
        over == 0 && continue
        @assert over == 1
        # @show ranges[rangeindex] "with"
        # @show ranges[rangeindex+step]
        ranges[rangeindex] = combine_ranges(ranges[rangeindex], popat!(ranges, (rangeindex+step)[1]))
    end
    return range_combiner!(ranges)

end

function overlaps(A::UnitRange)
    out = zeros(size(A)) .|> Bool
    R = CartesianIndices(A)
    Ifirst, Ilast = first(R), last(R)
    step = oneunit(Ifirst)
    for I in R
        s = intersect(A[I], A[min(I + step, Ilast)])
        # @show s A[I] A[min(I + step, Ilast)]
        if s.start < s.stop
            out[I] = 1
        end
    end
    out[end] = 0
    out
end


function part_1(input_file)
    @showtime ranges, numbers = parse_input(input_file)
    @show size(ranges)
    @showtime sort!(ranges, by=last) # Because default sort is stable
    @showtime sort!(ranges, by=first)
    # combine_bollean = combination(ranges)
    # combined_ranges = []
    cont = 0
    @info "Entering the loop"
    # @showprogress for i in numbers
    #     found = searchsortedlast(ranges, i, by=first)
    #     found == 0 && continue
    #     if i ∈ ranges[found]
    #         cont += 1
    #     end
    # end
    @showprogress for i in numbers
        for range in ranges
            if i in range
                cont += 1
                break
            end
        end
    end
    return cont
end

function part_2(input_file)
    ranges, _ = parse_input(input_file)
    # first sort the ranges
    # NOTE: just `sort!(ranges)` takes ridiculus ammount of time
    sort!(ranges, by=last)
    sort!(ranges, by=first)
    range_combiner!(ranges)
    # here we have a vector of disjoint ranges
    # ran.stop-ran.start+1 # number of elements in the range
    count_ranges = ranges .|> x -> x.stop - x.start + 1
    reduce(+, count_ranges)
end
