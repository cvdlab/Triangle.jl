module Triangulate

include("call_native_iface.jl")
include("utils_methods.jl")

export basic_triangulation
export constrained_triangulation

function basic_triangulation(vertices::Array{Float64,2}, vertices_map::Array{Int64,1})
    flat_triangle_list = call_basic_triangulation(flat_vertices(vertices), Vector{Cint}(vertices_map))
    
    return triangle_list_from_marker(flat_triangle_list)
end

function constrained_triangulation(vertices::Array{Float64,2}, vertices_map::Array{Int64,1}, edges_list::Array{Int64,2})
    return constrained_triangulation(vertices, vertices_map, edges_list, Array{Bool,1}())
end

function constrained_triangulation(vertices::Array{Float64,2}, vertices_map::Array{Int64,1}, edges_list::Array{Int64,2}, edges_boundary::Array{Bool,1})
    if length(edges_boundary) != size(edges_list)[1]
        flat_triangle_list = call_constrained_triangulation(
                flat_vertices(vertices), 
                Vector{Cint}(vertices_map), 
                flat_edges(edges_list)
            )
        return triangle_list_from_marker(flat_triangle_list)
    else
        flat_triangle_list = call_constrained_triangulation_bounded(
                flat_vertices(vertices), 
                Vector{Cint}(vertices_map), 
                flat_edges(edges_list),
                Vector{Cint}(map(x -> x ? 1 : 0, edges_boundary))
            )
        return triangle_list_from_marker(flat_triangle_list)
    end
end

end