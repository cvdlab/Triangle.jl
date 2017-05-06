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

function constrained_triangulation(vertices::Array{Float64,2}, vertices_map::Array{Int64,1}, edges_list::Array{Int64,2})
  Triangulate.constrained_triangulation(vertices, vertices_map, edges_list)
end

function constrained_triangulation(vertices::Array{Float64,2}, vertices_map::Array{Int64,1}, edges_list::Array{Int64,2}, edges_boundary::Array{Bool,1})
  Triangulate.constrained_triangulation(vertices, vertices_map, edges_list, edges_boundary)
end

end