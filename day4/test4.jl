using Test
include("day4.jl")

@test part_1("input_test.txt") == 13
@test part_2("input_test.txt") == 43
