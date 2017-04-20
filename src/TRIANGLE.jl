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
    (:call_triangulate, jl_libtriangle), 
    Void, 
    (Ptr{UInt8}, Ref{TriangulateIO}, Ref{TriangulateIO}, Ref{TriangulateIO}), 
    options, Ref(inTri), Ref(outTri), Ref(voronoiTri)
  )

  (outTri, voronoiTri)
end

function runtest()
  options = "pz"
  inTri = TriangulateIO()
  a = Vector{Cdouble}(6)
  a[1] = 0.
  a[2] = 0.
  a[3] = 0.
  a[4] = 1.
  a[5] = 1.
  a[6] = 0.
  inTri.pointlist = pointer(a)
  inTri.numberofpoints = length(a)/2

  outTri,voroTri = ctriangulate(inTri, options)
end

end