## Utils
function triangle_list_from_marker(vertices::Array{Float64,2}, vertices_map::Array{Int64,1}, flat_triangle_list)
    vert_size = size(vertices)

    map_positions = Array{Int64,1}(length(vertices_map))
    for i in 1:1:length(vertices_map)
        map_positions[vertices_map[i]] = i
    end

    triangle_list = Array{Array{Float64,2},1}()
    for i in 1:3:length(flat_triangle_list)
        triangle = Array{Float64}(3,2)
        triangle[1] = vertices[map_positions[flat_triangle_list[i]]]
        triangle[4] = vertices[map_positions[flat_triangle_list[i]]+vert_size[1]]
        triangle[2] = vertices[map_positions[flat_triangle_list[i+1]]]
        triangle[5] = vertices[map_positions[flat_triangle_list[i+1]]+vert_size[1]]
        triangle[3] = vertices[map_positions[flat_triangle_list[i+2]]]
        triangle[6] = vertices[map_positions[flat_triangle_list[i+2]]+vert_size[1]]
        push!(triangle_list, triangle)
    end

    return triangle_list
end

function flat_vertices(vertices::Array{Float64,2})
    vert_size = size(vertices)
    flat_vertices_vector = Vector{Cdouble}(vert_size[1]*vert_size[2])

    for vert_id=1:vert_size[1]
        flat_vertices_vector[(vert_id*2)-1]=vertices[vert_id]
        flat_vertices_vector[(vert_id*2)]=vertices[vert_id+vert_size[1]]
    end
    
    return flat_vertices_vector
end

function flat_edges(edges::Array{Int64,2})
    edge_size = size(edges)
    flat_edges_vector = Vector{Cint}(edge_size[1]*edge_size[2])

    for edge_id=1:edge_size[1]
        flat_edges_vector[(edge_id*2)-1]=edges[edge_id]
        flat_edges_vector[(edge_id*2)]=edges[edge_id+edge_size[1]]
    end
    
    return flat_edges_vector
end