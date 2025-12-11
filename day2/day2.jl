function parse_input(input_file)::Vector{UnitRange{Int64}}
    s = ""
    open(input_file, "r") do f
        s = readline(f)
    end
    s = split(s, ",")
    s = s .|> (x -> split(x, "-")) .|> x -> parse.(Int, x)
    s = s .|> x -> range(x[1], x[2])
    return s
end

function repeat(number)
    return number * 10^(ndigits(number)) + number
end

# repeat(number, 1) <=> repeat(number)
function repeat(number, times)
    new_number = number
    for i in 1:times
        new_number = new_number * 10^(ndigits(number)) + number
    end
    return new_number
end

function invalid_ID_1(input_file)
    s = parse_input(input_file)
    sum_out = 0
    for range_s in s
        @info range_s
        start = range_s.start
        stop = range_s.stop
        startd = ndigits(start)
        stopd = ndigits(stop)
        ndig = 0
        # No valid numbers to repeat (must be even)
        isodd(startd) && isodd(stopd) && startd == stopd && continue

        ndig = iseven(startd) ? startd / 2 : (startd + 1) / 2
        number::Integer = 10^(ndig - 1)
        repeated = 0
        @info "Entering the loop"
        while true
            repeated = repeat(number)
            repeated > stop && break
            if repeated ∈ range_s
                @info repeated
                sum_out += repeated
            end
            number += 1
        end
        @info ("-"^10)
    end
    print(sum_out)
end

function invalid_ID_2(input_file)
    s = parse_input(input_file)
    sum_out = 0
    for range_s in s
        @info range_s
        avoid_duplicates = []
        start = range_s.start
        stop = range_s.stop
        startd = ndigits(start)
        stopd = ndigits(stop)
        ndig = 1
        while true
            ndig * 2 > stopd && break
            # idea: start in another loop and increase digits, untill we have too much to repeat
            for times in Iterators.countfrom(1)
                ndig * (times + 1) < startd && continue # skip to good stuff
                ndig * (times + 1) > stopd && break # there is no more
                number::Integer = 10^(ndig - 1)
                repeated = 0
                for number in Iterators.countfrom(number)
                    repeated = repeat(number, times)
                    repeated > stop && break
                    if repeated ∈ range_s
                        repeated ∈ avoid_duplicates && continue
                        @info repeated
                        push!(avoid_duplicates, repeated)
                        sum_out += repeated
                    end
                    number += 1
                end
            end
            ndig += 1

        end
        @info ("-"^10)
    end
    print(sum_out)
end
