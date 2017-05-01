module TRIANGLE
export basic_triangulation

if !isfile(joinpath(dirname(@__FILE__), "..", "deps", "deps.jl"))
  error("TRIANGLE is not properly installed. Please run\nPkg.build(\"TRIANGLE\")")
end

include("common.jl")

function basic_triangulation(vertices::Array{Float64,2})
  vert_size = size(vertices)
  flat_vertices = Vector{Cdouble}(vert_size[1]*vert_size[2])
  flat_vertices_map = Vector{Cint}(collect(1:1:vert_size[1]))
  for vert_id=1:vert_size[1]
    flat_vertices[(vert_id*2)-1]=vertices[vert_id]
    flat_vertices[(vert_id*2)]=vertices[vert_id+vert_size[1]]
  end

  # Basic Tri
  options = ""
  inTri = NativeInterface.TriangulateIO()  
  inTri.pointlist = pointer(flat_vertices)
  inTri.numberofpoints = Cint(vert_size[1])
  inTri.pointmarkerlist = pointer(flat_vertices_map)

  # Call C
  tupleRes = NativeInterface.ctriangulate(inTri, options)
  tupleRes[1]
end


end