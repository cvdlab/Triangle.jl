module Triangulate

include("../NativeInterface/native.jl")

export basic_triangulation

function basic_triangulation(vertices::Array{Float64,2})
  vert_size = size(vertices)
  flat_vertices = Vector{Cdouble}(vert_size[1]*vert_size[2])
  flat_vertices_map = Vector{Cint}(collect(1:1:vert_size[1]))
  for vert_id=1:vert_size[1]
    flat_vertices[(vert_id*2)-1]=vertices[vert_id]
    flat_vertices[(vert_id*2)]=vertices[vert_id+vert_size[1]]
  end

  options = NativeInterface.TriangulateOptions()
  options.quiet = false
  options.verbose = true

  ret = NativeInterface.basic_triangulation(flat_vertices, flat_vertices_map, options)
  ret

end


end