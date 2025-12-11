using Test
include("day2.jl")

@test_skip invalid_ID_2("input_test.txt") == 4174379265
@test invalid_ID_1("input_test.txt") == 1227775554
