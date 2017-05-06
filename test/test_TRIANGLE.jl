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

#=
# Costrained
point = [0. 0.; 0. 3.; 1. 3.; 1. 1.; 2. 1.; 2. 0.]
point_map = Array{Int64,1}(collect(1:1:size(point)[1]))
edge_list = Array{Int64,2}([1 2; 2 3; 3 4; 4 5; 5 6; 6 1])
TRIANGLE.constrained_triangulation(point, point_map, edge_list)
=#

#=
# Costrained + Boundary
point = [0. 0.; 0. 3.; 1. 3.; 1. 1.; 2. 1.; 2. 0.]
point_map = Array{Int64,1}(collect(1:1:size(point)[1]))
edge_list = Array{Int64,2}([1 2; 2 3; 3 4; 4 5; 5 6; 6 1])
edge_boundary = [false, false, true, true, false, false]
TRIANGLE.constrained_triangulation(point, point_map, edge_list, edge_boundary)
=#