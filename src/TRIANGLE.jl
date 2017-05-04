module TRIANGLE
export basic_triangulation
export constrained_triangulation

if !isfile(joinpath(dirname(@__FILE__), "..", "deps", "deps.jl"))
  error("TRIANGLE is not properly installed. Please run\nPkg.build(\"TRIANGLE\")")
end

include("common.jl")

function basic_triangulation(vertices::Array{Float64,2})
  Triangulate.basic_triangulation(vertices)
end

function basic_triangulation(vertices::Array{Float64,2}, vertices_map::Array{Int64,1})
  Triangulate.basic_triangulation(vertices, vertices_map)
end

#=
point = [0. 0.; 0. 3.; 1. 3.; 1. 1.; 2. 1.; 2. 0.]
point_map = Array{Int64,1}(collect(1:1:size(point)[1]))
edge_list = Array{Int64,2}([1 2; 2 3; 3 4; 4 5; 5 6; 6 1])
=#
function constrained_triangulation(vertices::Array{Float64,2}, vertices_map::Array{Int64,1}, edges_list::Array{Int64,2})
  Triangulate.constrained_triangulation(vertices, vertices_map, edges_list)
end

end