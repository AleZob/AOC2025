function password_zero_1()
    number = 50
    zero_counter = 0

    open("input1.txt", "r") do f
        # read till end of file
        input_number = 0
        while !eof(f)
            s = readline(f)
            # print(typeof(s[1]))
            if occursin("L", s)
                input_number = -parse(Int, s[2:end])
            elseif occursin("R", s)
                input_number = parse(Int, s[2:end])
            end
            number += input_number
            number = mod(number, 100)
            if number == 0
                zero_counter += 1
            end
        end
    end
    print(zero_counter)
end

function password_zero_2(input_file)
    number = 50
    zero_counter = 0

    open(input_file, "r") do f
        # read till end of file
        input_number = 0
        while !eof(f)
            s = readline(f)
            # print(typeof(s[1]))
            if occursin("L", s)
                input_number = -parse(Int, s[2:end])
            elseif occursin("R", s)
                input_number = parse(Int, s[2:end])
            end
            #include multiple rotations
            rotations, simple = divrem(input_number, 100)

            zero_counter += abs(rotations)

            if number == 0
                number += simple
                if number <= 0

                elseif number >= 100
                    zero_counter += 1
                end
            else
                number += simple
                if number <= 0
                    zero_counter += 1
                elseif number >= 100
                    zero_counter += 1
                end
            end
            number = mod(number, 100)
            # println(s)
            # @show rotations simple number zero_counter
            # println("-"^10)
        end
    end
    print(zero_counter)
end
