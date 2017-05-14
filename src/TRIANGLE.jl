module TRIANGLE
export basic_triangulation
export basic_triangulation_vertices
export constrained_triangulation

if !isfile(joinpath(dirname(@__FILE__), "..", "deps", "deps.jl"))
  error("TRIANGLE is not properly installed. Please run\nPkg.build(\"TRIANGLE\")")
end

include("common.jl")

function basic_triangulation_vertices(vertices::Array{Float64,2})
  basic_triangulation_vertices(vertices, Array{Int64,1}(collect(1:1:size(vertices)[1])))
end

function basic_triangulation(vertices::Array{Float64,2}, vertices_map::Array{Int64,1})
  Triangulate.basic_triangulation(vertices, vertices_map)
end

function basic_triangulation_vertices(vertices::Array{Float64,2}, vertices_map::Array{Int64,1})
  map_to_vertices( vertices, vertices_map, basic_triangulation(vertices, vertices_map) )
end

function constrained_triangulation(vertices::Array{Float64,2}, vertices_map::Array{Int64,1}, edges_list::Array{Int64,2})
  Triangulate.constrained_triangulation(vertices, vertices_map, edges_list)
end

function constrained_triangulation_vertices(vertices::Array{Float64,2}, vertices_map::Array{Int64,1}, edges_list::Array{Int64,2})
  map_to_vertices( vertices, vertices_map, constrained_triangulation(vertices, vertices_map, edges_list) )
end

function constrained_triangulation(vertices::Array{Float64,2}, vertices_map::Array{Int64,1}, edges_list::Array{Int64,2}, edges_boundary::Array{Bool,1})
  Triangulate.constrained_triangulation(vertices, vertices_map, edges_list, edges_boundary)
end

function constrained_triangulation_vertices(vertices::Array{Float64,2}, vertices_map::Array{Int64,1}, edges_list::Array{Int64,2}, edges_boundary::Array{Bool,1})
  map_to_vertices( vertices, vertices_map, constrained_triangulation(vertices, vertices_map, edges_list, edges_boundary) )
end

function map_to_vertices(vertices::Array{Float64,2}, vertices_map::Array{Int64,1}, triangle_list::Array{Array{Int64, 1},1})
  vert_size = size(vertices)

  map_positions = Array{Int64,1}(length(vertices_map))
  for i in 1:1:length(vertices_map)
    map_positions[vertices_map[i]] = i
  end

  triangle_list_vertices = Array{Array{Float64,2},1}()
  for i in 1:1:length(triangle_list)
        triangle = Array{Float64}(3,2)
        triangle[1] = vertices[map_positions[triangle_list[i][1]]]
        triangle[4] = vertices[map_positions[triangle_list[i][1]]+vert_size[1]]
        triangle[2] = vertices[map_positions[triangle_list[i][2]]]
        triangle[5] = vertices[map_positions[triangle_list[i][2]]+vert_size[1]]
        triangle[3] = vertices[map_positions[triangle_list[i][3]]]
        triangle[6] = vertices[map_positions[triangle_list[i][3]]+vert_size[1]]
        push!(triangle_list_vertices, triangle)
  end

  return triangle_list_vertices
end
+
end