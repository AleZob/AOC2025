using Test
include("day.jl")

@testset "Tests for Part 1" begin
    @test part_1("input_test.txt") == 4277556
end
# @testset "Tests for Part 2" begin
# @test part_2("input_test.txt") == 14
# end
