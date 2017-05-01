module NativeInterface

include("trinative.jl")
include("trioptions.jl")

depsjl = joinpath(dirname(@__FILE__), "../..", "deps", "deps.jl")
include(depsjl)

export basic_triangulation
export TriangulateOptions

function basic_triangulation(vertices::Vector{Cdouble}, verticesMap::Vector{Cint}, options::TriangulateOptions)
  # Basic Tri
  inTri = TriangulateIO()  
  inTri.pointlist = pointer(vertices)
  inTri.numberofpoints = length(verticesMap)
  inTri.pointmarkerlist = pointer(verticesMap)

  # Call C
  tupleRes = ctriangulate(inTri, getTriangulateStringOptions(options))
  tupleRes[1]
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

function decode_result(triObject::TriangulateIO)
  elems = unsafe_wrap(Array, triObject.trianglelist, triObject.numberoftriangles*triObject.numberofcorners, true)
  print(elems)
  triObject.trianglelist = C_NULL

  # trianglelist
  # triangleattributelist
  # neighborlist

end

end