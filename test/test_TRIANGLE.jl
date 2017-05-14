@testset "TRIANGLE.jl Interface" begin
    @testset "Basic Triangulation" begin
        
        @testset "basic_triangulation_vertices" begin
            points = Array{Float64,2}([0. 0.; 1. 0.; 0. 1.])
            @test TRIANGLE.basic_triangulation_vertices(points)[1] == points
        end
        
        @testset "basic_triangulation with point map" begin
            points = Array{Float64,2}([0. 0.; 1. 0.; 0. 1.])
            points_map = [1, 2, 3]
            @test TRIANGLE.basic_triangulation(points,points_map)[1] == points_map
        end

        @testset "basic_triangulation_vertices with point map" begin
            points = Array{Float64,2}([0. 0.; 1. 0.; 0. 1.])
            points_map = [1, 2, 3]
            @test TRIANGLE.basic_triangulation_vertices(points,points_map)[1] == points
        end

        @testset "constrained_triangulation" begin
            points = [0. 0.; 0. 3.; 1. 3.; 1. 1.; 2. 1.; 2. 0.]
            points_map = Array{Int64,1}(collect(1:1:size(points)[1]))
            edges_list = Array{Int64,2}([1 2; 2 3; 3 4; 4 5; 5 6; 6 1])
            triangles = TRIANGLE.constrained_triangulation(points,points_map,edges_list)
            @test length(triangles) == 5
        end

        @testset "constrained_triangulation_vertices" begin
            points = [0. 0.; 0. 3.; 1. 3.; 1. 1.; 2. 1.; 2. 0.]
            points_map = Array{Int64,1}(collect(1:1:size(points)[1]))
            edges_list = Array{Int64,2}([1 2; 2 3; 3 4; 4 5; 5 6; 6 1])
            triangles = TRIANGLE.constrained_triangulation_vertices(points,points_map,edges_list)
            @test length(triangles) == 5
        end        

        @testset "constrained_triangulation with boundary" begin
            points = [0. 0.; 0. 3.; 1. 3.; 1. 1.; 2. 1.; 2. 0.]
            points_map = Array{Int64,1}(collect(1:1:size(points)[1]))
            edges_list = Array{Int64,2}([1 2; 2 3; 3 4; 4 5; 5 6; 6 1])
            edge_boundary = [false, false, true, true, false, false]
            triangles = TRIANGLE.constrained_triangulation(points,points_map,edges_list,edge_boundary)
            @test length(triangles) == 4
        end

        @testset "constrained_triangulation_vertices with boundary" begin
            points = [0. 0.; 0. 3.; 1. 3.; 1. 1.; 2. 1.; 2. 0.]
            points_map = Array{Int64,1}(collect(1:1:size(points)[1]))
            edges_list = Array{Int64,2}([1 2; 2 3; 3 4; 4 5; 5 6; 6 1])
            edge_boundary = [false, false, true, true, false, false]
            triangles = TRIANGLE.constrained_triangulation_vertices(points,points_map,edges_list,edge_boundary)
            @test length(triangles) == 4
        end                 
    end
end

## Strange case (TRIFORCE)
# a = Array{Float64,2}([0. 0.; 4. 0.; 2. 3.; 8. 0.; 6. 3.; 4. 6.])
# map = [1,2,3,4,5,6] => works
# map = [1,2,4,3,5,6] => WTF