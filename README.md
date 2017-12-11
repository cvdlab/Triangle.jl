# TRIANGLE.jl

[![Build Status](https://travis-ci.org/cvdlab/TRIANGLE.jl.svg?branch=master)](https://travis-ci.org/cvdlab/TRIANGLE.jl)
[![Coverage Status](https://coveralls.io/repos/github/cvdlab/TRIANGLE.jl/badge.svg)](https://coveralls.io/github/cvdlab/TRIANGLE.jl)
[![DOI](https://zenodo.org/badge/doi/10.1007/BFb0014497.svg)](http://dx.doi.org/10.1007/BFb0014497)

A Julia interface to Jonathan Richard Shewchuk [Triangle](https://www.cs.cmu.edu/~quake/triangle.html).

### Version
0.2.1

### Library notes
At the moment the library will use only CDT, planning to expand later.

### Licensing note

Note that while this binding-library is under a permissive license ([MIT](LICENSE)), the original [Triangle](https://www.cs.cmu.edu/~quake/triangle.html) library isn't:
> Please note that although Triangle is freely available, it is copyrighted by the author and may not be sold or included in commercial products without a license.

So be wary of any possible conflict between your project license and [Triangle](https://www.cs.cmu.edu/~quake/triangle.html)'s

## Installing

Just run `Pkg.clone("https://github.com/cvdlab/TRIANGLE.jl.git")` and `Pkg.build("TRIANGLE")`

### Windows

The build proces uses [VC++ for Python](https://www.microsoft.com/en-us/download/details.aspx?id=44266) to build so be sure you have it before running the build part.

## API

Include the module (`using TRIANGLE`).

You can use Julia `?TRIANGLE.methodname` for inline documentation, here a short summary:


`TRIANGLE.basic_triangulation_vertices(vertices::Array{Float64,2})`
* *vertices* containing the list of your vertices in the form of _[x1 y1; x2 y2; ... ; xn yn]_

Returns:
* __Array{Array{Float64,2},1}__ an array of array of 3-vertices lists (a triangle). Each triangle is properly order in the whole mesh.

`TRIANGLE.basic_triangulation(vertices::Array{Float64,2}, vertices_map::Array{Int64,1})`
* *vertices* containing the list of your vertices in the form of _[x1 y1; x2 y2; ... ; xn yn]_
* *vertices_map* a list of custom integer identifier for the vertices

Returns:
* __Array{Array{Int64,1},1}__ an array of array of 3-vertices marker lists (a triangle). Each triangle is properly order in the whole mesh.

`TRIANGLE.basic_triangulation_vertices(vertices::Array{Float64,2}, vertices_map::Array{Int64,1})`
* *vertices* containing the list of your vertices in the form of _[x1 y1; x2 y2; ... ; xn yn]_
* *vertices_map* a list of custom integer identifier for the vertices

Returns:
* __Array{Array{Float64,2},1}__ an array of array of 3-vertices lists (a triangle). Each triangle is properly order in the whole mesh.

`TRIANGLE.constrained_triangulation(vertices::Array{Float64,2}, vertices_map::Array{Int64,1}, edges_list::Array{Int64,2})`
* *vertices* containing the list of your vertices in the form of _[x1 y1; x2 y2; ... ; xn yn]_ 
* *vertices_map* a list of custom integer identifier for the vertices
* *edges_list* a list of edges in the form of _[ vertex-identifier-1 vertex-identifier-2; vertex-identifier-1 vertex-identifier-3; ... ; vertex-identifier-N vertex-identifier-M ]_ that will be retaied during the constrained Delaunay triangulation

Returns:
* __Array{Array{Int64,1},1}__ an array of array of 3-vertices marker lists (a triangle). Each triangle is properly order in the whole mesh.

`TRIANGLE.constrained_triangulation_vertices(vertices::Array{Float64,2}, vertices_map::Array{Int64,1}, edges_list::Array{Int64,2})`
* *vertices* containing the list of your vertices in the form of _[x1 y1; x2 y2; ... ; xn yn]_ 
* *vertices_map* a list of custom integer identifier for the vertices
* *edges_list* a list of edges in the form of _[ vertex-identifier-1 vertex-identifier-2; vertex-identifier-1 vertex-identifier-3; ... ; vertex-identifier-N vertex-identifier-M ]_ that will be retaied during the constrained Delaunay triangulation

Returns:
* __Array{Array{Float64,2},1}__ an array of array of 3-vertices lists (a triangle). Each triangle is properly order in the whole mesh.

`TRIANGLE.constrained_triangulation(vertices::Array{Float64,2}, vertices_map::Array{Int64,1}, edges_list::Array{Int64,2}, edges_boundary::Array{Bool,1})`
* *vertices* containing the list of your vertices in the form of _[x1 y1; x2 y2; ... ; xn yn]_ 
* *vertices_map* a list of custom integer identifier for the vertices
* *edges_list* a list of edges in the form of _[ vertex-identifier-1 vertex-identifier-2; vertex-identifier-1 vertex-identifier-3; ... ; vertex-identifier-N vertex-identifier-M ]_ that will be retaied during the constrained Delaunay triangulation
* *edges_boundary* a list of booleans that tells TRIANGLE if the edge is on the boundary or not (the indexing is the same of *edges_list*)

Returns:
* __Array{Array{Int64,1},1}__ an array of array of 3-vertices marker lists (a triangle). Each triangle is properly order in the whole mesh.

`TRIANGLE.constrained_triangulation_vertices(vertices::Array{Float64,2}, vertices_map::Array{Int64,1}, edges_list::Array{Int64,2}, edges_boundary::Array{Bool,1})`
* *vertices* containing the list of your vertices in the form of _[x1 y1; x2 y2; ... ; xn yn]_ 
* *vertices_map* a list of custom integer identifier for the vertices
* *edges_list* a list of edges in the form of _[ vertex-identifier-1 vertex-identifier-2; vertex-identifier-1 vertex-identifier-3; ... ; vertex-identifier-N vertex-identifier-M ]_ that will be retaied during the constrained Delaunay triangulation
* *edges_boundary* a list of booleans that tells TRIANGLE if the edge is on the boundary or not (the indexing is the same of *edges_list*)

Returns:
* __Array{Array{Float64,2},1}__ an array of array of 3-vertices lists (a triangle). Each triangle is properly order in the whole mesh.

`TRIANGLE.constrained_triangulation(vertices::Array{Float64,2}, vertices_map::Array{Int64,1}, edges_list::Array{Int64,2}, edges_boundary::Array{Bool,1}, holes::Array{Float64,2})`
* *vertices* containing the list of your vertices in the form of _[x1 y1; x2 y2; ... ; xn yn]_ 
* *vertices_map* a list of custom integer identifier for the vertices
* *edges_list* a list of edges in the form of _[ vertex-identifier-1 vertex-identifier-2; vertex-identifier-1 vertex-identifier-3; ... ; vertex-identifier-N vertex-identifier-M ]_ that will be retaied during the constrained Delaunay triangulation
* *edges_boundary* a list of booleans that tells TRIANGLE if the edge is on the boundary or not (the indexing is the same of *edges_list*)
* *holes* containing the list of your holes in the form of _[x1 y1; x2 y2; ... ; xn yn]_ they will be used as marker to remove pieces of the mesh

Returns:
* __Array{Array{Int64,1},1}__ an array of array of 3-vertices marker lists (a triangle). Each triangle is properly order in the whole mesh.

`TRIANGLE.constrained_triangulation_vertices(vertices::Array{Float64,2}, vertices_map::Array{Int64,1}, edges_list::Array{Int64,2}, edges_boundary::Array{Bool,1}, holes::Array{Float64,2})`
* *vertices* containing the list of your vertices in the form of _[x1 y1; x2 y2; ... ; xn yn]_ 
* *vertices_map* a list of custom integer identifier for the vertices
* *edges_list* a list of edges in the form of _[ vertex-identifier-1 vertex-identifier-2; vertex-identifier-1 vertex-identifier-3; ... ; vertex-identifier-N vertex-identifier-M ]_ that will be retaied during the constrained Delaunay triangulation
* *edges_boundary* a list of booleans that tells TRIANGLE if the edge is on the boundary or not (the indexing is the same of *edges_list*)
* *holes* containing the list of your holes in the form of _[x1 y1; x2 y2; ... ; xn yn]_ they will be used as marker to remove pieces of the mesh

Returns:
* __Array{Array{Float64,2},1}__ an array of array of 3-vertices lists (a triangle). Each triangle is properly order in the whole mesh.
