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

# 7257
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
            zero_counter += abs(div(input_number, 100))

            input_number = rem(input_number, 100)

            number += input_number
            if number <= 0
                zero_counter += 1
            elseif number >= 100
                zero_counter += 1
            end
            number = mod(number, 100)
        end
    end
    print(zero_counter)
end
