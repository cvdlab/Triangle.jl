module TRIANGLE
export runtest

depsjl = joinpath(dirname(@__FILE__), "..", "deps", "deps.jl")

if isfile(depsjl)
	include(depsjl)
else
	error("TRIANGLE is not properly installed. Please try to run\nPkg.build(\"TRIANGLE\")")
end

# REAL = double = Cdouble
type TriangulateIO
  pointlist::Ptr{Cdouble}
  pointattributelist::Ptr{Cdouble}
  pointmarkerlist::Ptr{Cint}
  numberofpoints::Cint
  numberofpointattributes::Cint
  trianglelist::Ptr{Cint}
  triangleattributelist::Ptr{Cdouble}
  trianglearealist::Ptr{Cdouble}
  neighborlist::Ptr{Cint}
  numberoftriangles::Cint
  numberofcorners::Cint
  numberoftriangleattributes::Cint
  segmentlist::Ptr{Cint}
  segmentmarkerlist::Ptr{Cint}
  numberofsegments::Cint
  holelist::Ptr{Cdouble}
  numberofholes::Cint
  regionlist::Ptr{Cdouble}
  numberofregions::Cint
  edgelist::Ptr{Cint}
  edgemarkerlist::Ptr{Cint}
  normlist::Ptr{Cdouble}
  numberofedges::Cint
  TriangulateIO() = new(C_NULL, C_NULL, C_NULL, 0, 0, C_NULL, C_NULL, C_NULL, C_NULL, 0, 0, 0, C_NULL, C_NULL, 0, C_NULL, 0, C_NULL, 0, C_NULL, C_NULL, C_NULL, 0)
end

function ctriangulate(inTri::TriangulateIO, options::String)
  outTri = TriangulateIO()
  voronoiTri = TriangulateIO()
  ccall(
    (:call_triangulate, libtriangle), 
    Void, 
    (Ptr{UInt8}, Ref{TriangulateIO}, Ref{TriangulateIO}, Ref{TriangulateIO}), 
    options, Ref(inTri), Ref(outTri), Ref(voronoiTri)
  )

  (outTri, voronoiTri)
end

function runtest()
  # Options
  options = ""
  inTri = TriangulateIO()
  a = Vector{Cdouble}(8)
  a[1] = 0.
  a[2] = 0.
  a[3] = 0.
  a[4] = 1.
  a[5] = 1.
  a[6] = 0.
  a[7] = 1.
  a[8] = 1.
  inTri.pointlist = pointer(a)
  inTri.numberofpoints = Cint(length(a)/2)
  b = Vector{Cint}(4)
  b[1] = 1
  b[2] = 2
  b[3] = 3
  b[4] = 4
  inTri.pointmarkerlist = pointer(b)
  # Call tri in C
  tupleRes = ctriangulate(inTri, options)
  # Ret
  tupleRes
end

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
  inTri = TriangulateIO()  
  inTri.pointlist = pointer(flat_vertices)
  inTri.numberofpoints = Cint(vert_size[1])
  inTri.pointmarkerlist = pointer(flat_vertices_map)

  # Call C
  tupleRes = ctriangulate(inTri, options)
  tupleRes[1]
end

function decode_result(outTri::TriangulateIO)
  elems = unsafe_wrap(Array, outTri.trianglelist, outTri.numberoftriangles*outTri.numberofcorners, true)
  print(elems)
  outTri.trianglelist = C_NULL
end

end