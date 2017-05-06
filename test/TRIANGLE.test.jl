using Base.Test
include("../src/TRIANGLE.jl")

@testset "TRIANGLE" begin
    points = Array{Float64,2}([0. 0.; 1. 0.; 0. 1.])
    @testset "basic_triangulation" begin
        @test TRIANGLE.basic_triangulation(points)[1] == points
    end

    points_map = [1, 2, 3]
    @testset "basic_triangulation" begin
        @test TRIANGLE.basic_triangulation(points,points_map)[1] == points
    end    
end