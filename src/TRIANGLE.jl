module TRIANGLE
export basic_triangulation
export basic_triangulation_vertices
export constrained_triangulation
export constrained_triangulation_vertices

if !isfile(joinpath(dirname(@__FILE__), "..", "deps", "deps.jl"))
  error("TRIANGLE is not properly installed. Please run\nPkg.build(\"TRIANGLE\")")
end

include("common.jl")

"""
    basic_triangulation_vertices(vertices::Array{Float64,2})

Compute a Delaunay triangulation for a list of `vertices` in the form of _[x1 y1; x2 y2; ... ; xn yn]_

The function will return an array of array of 3-vertices lists (triangles with the correct vertices order) using the vertex coordinates in each triangle definition.

# Example
```jldoctest
julia> points = Array{Float64,2}([0. 0.; 1. 0.; 0. 1.])
3×2 Array{Float64,2}:
 0.0  0.0
 1.0  0.0
 0.0  1.0

julia> basic_triangulation_vertices(points)
1-element Array{Array{Float64,2},1}:
 [0.0 0.0; 1.0 0.0; 0.0 1.0]
```
"""
function basic_triangulation_vertices(vertices::Array{Float64,2})
  basic_triangulation_vertices(vertices, Array{Int64,1}(collect(1:1:size(vertices)[1])))
end

"""
    basic_triangulation(vertices::Array{Float64,2},vertices_map::Array{Int64,1})

Compute a Delaunay triangulation for a list of `vertices` in the form of _[x1 y1; x2 y2; ... ; xn yn]_

A list of indexes is provided in `vertices_map` so that each vertex can have a custom integer identifier.

The function will return an array of array of 3-vertices lists (triangles with the correct vertices order) using the vertex identifiers in each triangle definition.


# Example
```jldoctest
julia> points = Array{Float64,2}([0. 0.; 1. 0.; 0. 1.])
3×2 Array{Float64,2}:
 0.0  0.0
 1.0  0.0
 0.0  1.0

julia> points_map = [1, 2, 3]
3-element Array{Int64,1}:
 1
 2
 3

julia> basic_triangulation(points,points_map)
1-element Array{Array{Int64,1},1}:
 [1,2,3]
```
"""
function basic_triangulation(vertices::Array{Float64,2}, vertices_map::Array{Int64,1})
  Triangulate.basic_triangulation(vertices, vertices_map)
end


"""
    basic_triangulation_vertices(vertices::Array{Float64,2},vertices_map::Array{Int64,1})

Compute a Delaunay triangulation for a list of `vertices` in the form of _[x1 y1; x2 y2; ... ; xn yn]_

A list of indexes is provided in `vertices_map` so that each vertex can have a custom integer identifier.

The function will return an array of array of 3-vertices lists (triangles with the correct vertices order) using the vertex coordinates in each triangle definition.

# Example
```jldoctest
julia> points = Array{Float64,2}([0. 0.; 1. 0.; 0. 1.])
3×2 Array{Float64,2}:
 0.0  0.0
 1.0  0.0
 0.0  1.0

julia> points_map = [1, 2, 3]
3-element Array{Int64,1}:
 1
 2
 3

julia> basic_triangulation_vertices(points,points_map)
1-element Array{Array{Float64,2},1}:
 [0.0 0.0; 1.0 0.0; 0.0 1.0]
```
"""
function basic_triangulation_vertices(vertices::Array{Float64,2}, vertices_map::Array{Int64,1})
  map_to_vertices( vertices, vertices_map, basic_triangulation(vertices, vertices_map) )
end

"""
    constrained_triangulation(vertices::Array{Float64,2}, vertices_map::Array{Int64,1}, edges_list::Array{Int64,2})

Compute a Constrained Delaunay triangulation for a list of `vertices` in the form of _[x1 y1; x2 y2; ... ; xn yn]_ and a list of edges that will be kept.

A list of indexes is provided in `vertices_map` so that each vertex can have a custom integer identifier.

A list of edges (to be included in the final triangulation) is passed in `edges_list` in the form of _[ vertex-identifier-1 vertex-identifier-2; vertex-identifier-1 vertex-identifier-3; ... ; vertex-identifier-N vertex-identifier-M ]_

The function will return an array of array of 3-vertices lists (triangles with the correct vertices order) using the vertex identifiers in each triangle definition.


# Example
```jldoctest
julia> points = [0. 0.; 0. 3.; 1. 3.; 1. 1.; 2. 1.; 2. 0.]
6×2 Array{Float64,2}:
 0.0  0.0
 0.0  3.0
 1.0  3.0
 1.0  1.0
 2.0  1.0
 2.0  0.0

julia> points_map = Array{Int64,1}(collect(1:1:size(points)[1]))
6-element Array{Int64,1}:
 1
 2
 3
 4
 5
 6

julia> edges_list = Array{Int64,2}([1 2; 2 3; 3 4; 4 5; 5 6; 6 1])
6×2 Array{Int64,2}:
 1  2
 2  3
 3  4
 4  5
 5  6
 6  1

julia> constrained_triangulation(points,points_map,edges_list)
5-element Array{Array{Int64,1},1}:
 [1,4,2]
 [4,1,6]
 [2,4,3]
 [4,5,3]
 [5,4,6]
```
"""
function constrained_triangulation(vertices::Array{Float64,2}, vertices_map::Array{Int64,1}, edges_list::Array{Int64,2})
  Triangulate.constrained_triangulation(vertices, vertices_map, edges_list)
end

"""
    constrained_triangulation_vertices(vertices::Array{Float64,2}, vertices_map::Array{Int64,1}, edges_list::Array{Int64,2})

Compute a Constrained Delaunay triangulation for a list of `vertices` in the form of _[x1 y1; x2 y2; ... ; xn yn]_ and a list of edges that will be kept.

A list of indexes is provided in `vertices_map` so that each vertex can have a custom integer identifier.

A list of edges (to be included in the final triangulation) is passed in `edges_list` in the form of _[ vertex-identifier-1 vertex-identifier-2; vertex-identifier-1 vertex-identifier-3; ... ; vertex-identifier-N vertex-identifier-M ]_

The function will return an array of array of 3-vertices lists (triangles with the correct vertices order) using the vertex coordinates in each triangle definition.


# Example
```jldoctest
julia> points = [0. 0.; 0. 3.; 1. 3.; 1. 1.; 2. 1.; 2. 0.]
6×2 Array{Float64,2}:
 0.0  0.0
 0.0  3.0
 1.0  3.0
 1.0  1.0
 2.0  1.0
 2.0  0.0

julia> points_map = Array{Int64,1}(collect(1:1:size(points)[1]))
6-element Array{Int64,1}:
 1
 2
 3
 4
 5
 6

julia> edges_list = Array{Int64,2}([1 2; 2 3; 3 4; 4 5; 5 6; 6 1])
6×2 Array{Int64,2}:
 1  2
 2  3
 3  4
 4  5
 5  6
 6  1

julia> constrained_triangulation_vertices(points,points_map,edges_list)
5-element Array{Array{Float64,2},1}:
 [0.0 0.0; 1.0 1.0; 0.0 3.0]
 [1.0 1.0; 0.0 0.0; 2.0 0.0]
 [0.0 3.0; 1.0 1.0; 1.0 3.0]
 [1.0 1.0; 2.0 1.0; 1.0 3.0]
 [2.0 1.0; 1.0 1.0; 2.0 0.0]
```
"""
function constrained_triangulation_vertices(vertices::Array{Float64,2}, vertices_map::Array{Int64,1}, edges_list::Array{Int64,2})
  map_to_vertices( vertices, vertices_map, constrained_triangulation(vertices, vertices_map, edges_list) )
end

"""
    constrained_triangulation(vertices::Array{Float64,2}, vertices_map::Array{Int64,1}, edges_list::Array{Int64,2}, edges_boundary::Array{Bool,1})

Compute a Constrained Delaunay triangulation for a list of `vertices` in the form of _[x1 y1; x2 y2; ... ; xn yn]_ and a list of edges that will be kept. Some of those edges can be marked as the boundary of the mesh.

A list of indexes is provided in `vertices_map` so that each vertex can have a custom integer identifier.

A list of edge (to be included in the final triangulation) is passed in `edges_list` in the form of _[ vertex-identifier-1 vertex-identifier-2; vertex-identifier-1 vertex-identifier-3; ... ; vertex-identifier-N vertex-identifier-M ]_

A list of boundary markers passed in `edges_boundary` in the form of booleans that tell the triangulator if the edge is on the boundary or not (the indexing is the same of `edges_list`).

The function will return an array of array of 3-vertices lists (triangles with the correct vertices order) using the vertex identifiers in each triangle definition.


# Example
```jldoctest
julia> points = [0. 0.; 0. 3.; 1. 3.; 1. 1.; 2. 1.; 2. 0.]
6×2 Array{Float64,2}:
 0.0  0.0
 0.0  3.0
 1.0  3.0
 1.0  1.0
 2.0  1.0
 2.0  0.0

julia> points_map = Array{Int64,1}(collect(1:1:size(points)[1]))
6-element Array{Int64,1}:
 1
 2
 3
 4
 5
 6

julia> edges_list = Array{Int64,2}([1 2; 2 3; 3 4; 4 5; 5 6; 6 1])
6×2 Array{Int64,2}:
 1  2
 2  3
 3  4
 4  5
 5  6
 6  1

julia> edge_boundary = [false, false, true, true, false, false]
6-element Array{Bool,1}:
 false
 false
  true
  true
 false
 false

julia> constrained_triangulation(points,points_map,edges_list,edge_boundary)
4-element Array{Array{Int64,1},1}:
 [1,4,2]
 [4,1,6]
 [2,4,3]
 [5,4,6]
```
"""
function constrained_triangulation(vertices::Array{Float64,2}, vertices_map::Array{Int64,1}, edges_list::Array{Int64,2}, edges_boundary::Array{Bool,1})
  Triangulate.constrained_triangulation(vertices, vertices_map, edges_list, edges_boundary)
end

"""
    constrained_triangulation_vertices(vertices::Array{Float64,2}, vertices_map::Array{Int64,1}, edges_list::Array{Int64,2}, edges_boundary::Array{Bool,1})

Compute a Constrained Delaunay triangulation for a list of `vertices` in the form of _[x1 y1; x2 y2; ... ; xn yn]_ and a list of edges that will be kept. Some of those edges can be marked as the boundary of the mesh.

A list of indexes is provided in `vertices_map` so that each vertex can have a custom integer identifier.

A list of edge (to be included in the final triangulation) is passed in `edges_list` in the form of _[ vertex-identifier-1 vertex-identifier-2; vertex-identifier-1 vertex-identifier-3; ... ; vertex-identifier-N vertex-identifier-M ]_

A list of boundary markers passed in `edges_boundary` in the form of booleans that tell the triangulator if the edge is on the boundary or not (the indexing is the same of `edges_list`).

The function will return an array of array of 3-vertices lists (triangles with the correct vertices order) using the vertex coordinates in each triangle definition.


# Example
```jldoctest
julia> points = [0. 0.; 0. 3.; 1. 3.; 1. 1.; 2. 1.; 2. 0.]
6×2 Array{Float64,2}:
 0.0  0.0
 0.0  3.0
 1.0  3.0
 1.0  1.0
 2.0  1.0
 2.0  0.0

julia> points_map = Array{Int64,1}(collect(1:1:size(points)[1]))
6-element Array{Int64,1}:
 1
 2
 3
 4
 5
 6

julia> edges_list = Array{Int64,2}([1 2; 2 3; 3 4; 4 5; 5 6; 6 1])
6×2 Array{Int64,2}:
 1  2
 2  3
 3  4
 4  5
 5  6
 6  1

julia> edge_boundary = [false, false, true, true, false, false]
6-element Array{Bool,1}:
 false
 false
  true
  true
 false
 false

julia> constrained_triangulation_vertices(points,points_map,edges_list,edge_boundary)
4-element Array{Array{Float64,2},1}:
 [0.0 0.0; 1.0 1.0; 0.0 3.0]
 [1.0 1.0; 0.0 0.0; 2.0 0.0]
 [0.0 3.0; 1.0 1.0; 1.0 3.0]
 [2.0 1.0; 1.0 1.0; 2.0 0.0]
```
"""
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

end