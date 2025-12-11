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
        start = range_s.start
        stop = range_s.stop
        startd = ndigits(start)
        stopd = ndigits(stop)
        ndig = 0

        ndig = iseven(startd) ? startd / 2 : (startd + 1) / 2
        number::Integer = 10^(ndig - 1)
        repeated = 0
        # idea: start in another loop and increase digits, untill we have too much to repeat
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
