module NativeInterface

include("trinative.jl")
include("trioptions.jl")

depsjl = joinpath(dirname(@__FILE__), "../..", "deps", "deps.jl")
include(depsjl)

export TriangulateOptions
export basic_triangulation
export constrained_triangulation

function basic_triangulation(vertices::Vector{Cdouble}, verticesMap::Vector{Cint}, options::TriangulateOptions = TriangulateOptions())
  # Basic Tri
  inTri = TriangulateIO()  
  inTri.pointlist = pointer(vertices)
  inTri.numberofpoints = length(verticesMap)
  inTri.pointmarkerlist = pointer(verticesMap)

  # Call C
  tupleRes = ctriangulate(inTri, getTriangulateStringOptions(options))
  
  triangleList = unsafe_wrap(Array, tupleRes[1].trianglelist, 
  tupleRes[1].numberoftriangles * tupleRes[1].numberofcorners, true)
  
  # Clean C
  inTri.pointlist = C_NULL
  inTri.pointmarkerlist = C_NULL
  tupleRes[1].trianglelist = C_NULL

  return triangleList
end

function constrained_triangulation(vertices::Vector{Cdouble}, verticesMap::Vector{Cint}, edges::Vector{Cint}, options::TriangulateOptions = TriangulateOptions())
  # Basic Tri
  inTri = TriangulateIO()  
  inTri.pointlist = pointer(vertices)
  inTri.numberofpoints = length(verticesMap)
  inTri.pointmarkerlist = pointer(verticesMap)
  inTri.segmentlist = pointer(edges)
  inTri.numberofsegments = Int(length(edges)/2)

  # Call C
  tupleRes = ctriangulate(inTri, getTriangulateStringOptions(options))
  
  triangleList = unsafe_wrap(Array, tupleRes[1].trianglelist, 
  tupleRes[1].numberoftriangles * tupleRes[1].numberofcorners, true)
  
  # Clean C
  inTri.pointlist = C_NULL
  inTri.pointmarkerlist = C_NULL

  tupleRes[1].trianglelist = C_NULL

  return triangleList

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

end