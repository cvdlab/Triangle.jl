
<a id='TRIANGLE.jl-Documentation-1'></a>

# TRIANGLE.jl Documentation

- [TRIANGLE.jl Documentation](index.md#TRIANGLE.jl-Documentation-1)
    - [Functions](index.md#Functions-1)
    - [Index](index.md#Index-1)


<a id='Functions-1'></a>

## Functions

<a id='TRIANGLE.basic_triangulation_vertices-Tuple{Array{Float64,2}}' href='#TRIANGLE.basic_triangulation_vertices-Tuple{Array{Float64,2}}'>#</a>
**`TRIANGLE.basic_triangulation_vertices`** &mdash; *Method*.



```
basic_triangulation_vertices(vertices::Array{Float64,2})
```

Compute a Delaunay triangulation for a list of `vertices` in the form of _[x1 y1; x2 y2; ... ; xn yn]_

The function will return an array of array of 3-vertices lists (triangles with the correct vertices order) using the vertex coordinates in each triangle definition.

**Example**

```julia-repl
julia> points = Array{Float64,2}([0. 0.; 1. 0.; 0. 1.])
3×2 Array{Float64,2}:
 0.0  0.0
 1.0  0.0
 0.0  1.0

julia> basic_triangulation_vertices(points)
1-element Array{Array{Float64,2},1}:
 [0.0 0.0; 1.0 0.0; 0.0 1.0]
```


<a target='_blank' href='https://github.com/cvdlab/TRIANGLE.jl/blob/c2f692c33ba3a32f845145e869c3f05c3202bc41/src/TRIANGLE.jl#L13-L32' class='documenter-source'>source</a><br>

<a id='TRIANGLE.basic_triangulation-Tuple{Array{Float64,2},Array{Int64,1}}' href='#TRIANGLE.basic_triangulation-Tuple{Array{Float64,2},Array{Int64,1}}'>#</a>
**`TRIANGLE.basic_triangulation`** &mdash; *Method*.



```
basic_triangulation(vertices::Array{Float64,2},vertices_map::Array{Int64,1})
```

Compute a Delaunay triangulation for a list of `vertices` in the form of _[x1 y1; x2 y2; ... ; xn yn]_

A list of indexes is provided in `vertices_map` so that each vertex can have a custom integer identifier.

The function will return an array of array of 3-vertices lists (triangles with the correct vertices order) using the vertex identifiers in each triangle definition.

**Example**

```julia-repl
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


<a target='_blank' href='https://github.com/cvdlab/TRIANGLE.jl/blob/c2f692c33ba3a32f845145e869c3f05c3202bc41/src/TRIANGLE.jl#L37-L65' class='documenter-source'>source</a><br>

<a id='TRIANGLE.basic_triangulation_vertices-Tuple{Array{Float64,2},Array{Int64,1}}' href='#TRIANGLE.basic_triangulation_vertices-Tuple{Array{Float64,2},Array{Int64,1}}'>#</a>
**`TRIANGLE.basic_triangulation_vertices`** &mdash; *Method*.



```
basic_triangulation_vertices(vertices::Array{Float64,2},vertices_map::Array{Int64,1})
```

Compute a Delaunay triangulation for a list of `vertices` in the form of _[x1 y1; x2 y2; ... ; xn yn]_

A list of indexes is provided in `vertices_map` so that each vertex can have a custom integer identifier.

The function will return an array of array of 3-vertices lists (triangles with the correct vertices order) using the vertex coordinates in each triangle definition.

**Example**

```julia-repl
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


<a target='_blank' href='https://github.com/cvdlab/TRIANGLE.jl/blob/c2f692c33ba3a32f845145e869c3f05c3202bc41/src/TRIANGLE.jl#L71-L98' class='documenter-source'>source</a><br>

<a id='TRIANGLE.constrained_triangulation-Tuple{Array{Float64,2},Array{Int64,1},Array{Int64,2}}' href='#TRIANGLE.constrained_triangulation-Tuple{Array{Float64,2},Array{Int64,1},Array{Int64,2}}'>#</a>
**`TRIANGLE.constrained_triangulation`** &mdash; *Method*.



```
constrained_triangulation(vertices::Array{Float64,2}, vertices_map::Array{Int64,1}, edges_list::Array{Int64,2})
```

Compute a Constrained Delaunay triangulation for a list of `vertices` in the form of _[x1 y1; x2 y2; ... ; xn yn]_ and a list of edges that will be kept.

A list of indexes is provided in `vertices_map` so that each vertex can have a custom integer identifier.

A list of edges (to be included in the final triangulation) is passed in `edges_list` in the form of _[ vertex-identifier-1 vertex-identifier-2; vertex-identifier-1 vertex-identifier-3; ... ; vertex-identifier-N vertex-identifier-M ]_

The function will return an array of array of 3-vertices lists (triangles with the correct vertices order) using the vertex identifiers in each triangle definition.

**Example**

```julia-repl
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


<a target='_blank' href='https://github.com/cvdlab/TRIANGLE.jl/blob/c2f692c33ba3a32f845145e869c3f05c3202bc41/src/TRIANGLE.jl#L103-L152' class='documenter-source'>source</a><br>

<a id='TRIANGLE.constrained_triangulation_vertices-Tuple{Array{Float64,2},Array{Int64,1},Array{Int64,2}}' href='#TRIANGLE.constrained_triangulation_vertices-Tuple{Array{Float64,2},Array{Int64,1},Array{Int64,2}}'>#</a>
**`TRIANGLE.constrained_triangulation_vertices`** &mdash; *Method*.



```
constrained_triangulation_vertices(vertices::Array{Float64,2}, vertices_map::Array{Int64,1}, edges_list::Array{Int64,2})
```

Compute a Constrained Delaunay triangulation for a list of `vertices` in the form of _[x1 y1; x2 y2; ... ; xn yn]_ and a list of edges that will be kept.

A list of indexes is provided in `vertices_map` so that each vertex can have a custom integer identifier.

A list of edges (to be included in the final triangulation) is passed in `edges_list` in the form of _[ vertex-identifier-1 vertex-identifier-2; vertex-identifier-1 vertex-identifier-3; ... ; vertex-identifier-N vertex-identifier-M ]_

The function will return an array of array of 3-vertices lists (triangles with the correct vertices order) using the vertex coordinates in each triangle definition.

**Example**

```julia-repl
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


<a target='_blank' href='https://github.com/cvdlab/TRIANGLE.jl/blob/c2f692c33ba3a32f845145e869c3f05c3202bc41/src/TRIANGLE.jl#L157-L206' class='documenter-source'>source</a><br>

<a id='TRIANGLE.constrained_triangulation-Tuple{Array{Float64,2},Array{Int64,1},Array{Int64,2},Array{Bool,1}}' href='#TRIANGLE.constrained_triangulation-Tuple{Array{Float64,2},Array{Int64,1},Array{Int64,2},Array{Bool,1}}'>#</a>
**`TRIANGLE.constrained_triangulation`** &mdash; *Method*.



```
constrained_triangulation(vertices::Array{Float64,2}, vertices_map::Array{Int64,1}, edges_list::Array{Int64,2}, edges_boundary::Array{Bool,1})
```

Compute a Constrained Delaunay triangulation for a list of `vertices` in the form of _[x1 y1; x2 y2; ... ; xn yn]_ and a list of edges that will be kept. Some of those edges can be marked as the boundary of the mesh.

A list of indexes is provided in `vertices_map` so that each vertex can have a custom integer identifier.

A list of edge (to be included in the final triangulation) is passed in `edges_list` in the form of _[ vertex-identifier-1 vertex-identifier-2; vertex-identifier-1 vertex-identifier-3; ... ; vertex-identifier-N vertex-identifier-M ]_

A list of boundary markers passed in `edges_boundary` in the form of booleans that tell the triangulator if the edge is on the boundary or not (the indexing is the same of `edges_list`).

The function will return an array of array of 3-vertices lists (triangles with the correct vertices order) using the vertex identifiers in each triangle definition.

**Example**

```julia-repl
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


<a target='_blank' href='https://github.com/cvdlab/TRIANGLE.jl/blob/c2f692c33ba3a32f845145e869c3f05c3202bc41/src/TRIANGLE.jl#L211-L270' class='documenter-source'>source</a><br>

<a id='TRIANGLE.constrained_triangulation_vertices-Tuple{Array{Float64,2},Array{Int64,1},Array{Int64,2},Array{Bool,1}}' href='#TRIANGLE.constrained_triangulation_vertices-Tuple{Array{Float64,2},Array{Int64,1},Array{Int64,2},Array{Bool,1}}'>#</a>
**`TRIANGLE.constrained_triangulation_vertices`** &mdash; *Method*.



```
constrained_triangulation_vertices(vertices::Array{Float64,2}, vertices_map::Array{Int64,1}, edges_list::Array{Int64,2}, edges_boundary::Array{Bool,1})
```

Compute a Constrained Delaunay triangulation for a list of `vertices` in the form of _[x1 y1; x2 y2; ... ; xn yn]_ and a list of edges that will be kept. Some of those edges can be marked as the boundary of the mesh.

A list of indexes is provided in `vertices_map` so that each vertex can have a custom integer identifier.

A list of edge (to be included in the final triangulation) is passed in `edges_list` in the form of _[ vertex-identifier-1 vertex-identifier-2; vertex-identifier-1 vertex-identifier-3; ... ; vertex-identifier-N vertex-identifier-M ]_

A list of boundary markers passed in `edges_boundary` in the form of booleans that tell the triangulator if the edge is on the boundary or not (the indexing is the same of `edges_list`).

The function will return an array of array of 3-vertices lists (triangles with the correct vertices order) using the vertex coordinates in each triangle definition.

**Example**

```julia-repl
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


<a target='_blank' href='https://github.com/cvdlab/TRIANGLE.jl/blob/c2f692c33ba3a32f845145e869c3f05c3202bc41/src/TRIANGLE.jl#L275-L334' class='documenter-source'>source</a><br>


<a id='Index-1'></a>

## Index

- [`TRIANGLE.basic_triangulation`](index.md#TRIANGLE.basic_triangulation-Tuple{Array{Float64,2},Array{Int64,1}})
- [`TRIANGLE.basic_triangulation_vertices`](index.md#TRIANGLE.basic_triangulation_vertices-Tuple{Array{Float64,2},Array{Int64,1}})
- [`TRIANGLE.basic_triangulation_vertices`](index.md#TRIANGLE.basic_triangulation_vertices-Tuple{Array{Float64,2}})
- [`TRIANGLE.constrained_triangulation`](index.md#TRIANGLE.constrained_triangulation-Tuple{Array{Float64,2},Array{Int64,1},Array{Int64,2},Array{Bool,1}})
- [`TRIANGLE.constrained_triangulation`](index.md#TRIANGLE.constrained_triangulation-Tuple{Array{Float64,2},Array{Int64,1},Array{Int64,2}})
- [`TRIANGLE.constrained_triangulation_vertices`](index.md#TRIANGLE.constrained_triangulation_vertices-Tuple{Array{Float64,2},Array{Int64,1},Array{Int64,2}})
- [`TRIANGLE.constrained_triangulation_vertices`](index.md#TRIANGLE.constrained_triangulation_vertices-Tuple{Array{Float64,2},Array{Int64,1},Array{Int64,2},Array{Bool,1}})

