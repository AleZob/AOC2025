using Test
include("day5.jl")

# @testset "Tests for Part 1" begin
#     @test part_1("input_test.txt") == 3
# end
@testset "Tests for Part 2" begin
    @test part_2("input_test.txt") == 14
    @test part_2("input_test1.txt") == 15
    @test part_2("input_test2.txt") == 16
    @test part_2("input_test3.txt") == 16
    @test part_2("input_test4.txt") == 30
    @test part_2("input_test5.txt") == 7
end
