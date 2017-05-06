module NativeInterface

include("trinative.jl")
include("trioptions.jl")

depsjl = joinpath(dirname(@__FILE__), "../..", "deps", "deps.jl")
include(depsjl)

export TriangulateOptions
export basic_triangulation
export constrained_triangulation
export constrained_triangulation_bounded

function basic_triangulation(vertices::Vector{Cdouble}, verticesMap::Vector{Cint}, options::TriangulateOptions = TriangulateOptions())
  # Basic Tri
  inTri = generate_basic_input(vertices, verticesMap)

  # Call C
  return calculate_output(inTri, options)
end

function constrained_triangulation(vertices::Vector{Cdouble}, verticesMap::Vector{Cint}, edges::Vector{Cint}, options::TriangulateOptions = TriangulateOptions())
  # Basic Tri
  inTri = generate_basic_input(vertices, verticesMap)
  inTri.segmentlist = pointer(edges)
  inTri.numberofsegments = Int(length(edges)/2)

  # Call C
  return calculate_output(inTri, options)
end

function constrained_triangulation_bounded(vertices::Vector{Cdouble}, verticesMap::Vector{Cint}, edges::Vector{Cint}, boundary_edges::Vector{Cint}, options::TriangulateOptions = TriangulateOptions())
  # Basic Tri
  inTri = generate_basic_input(vertices, verticesMap)
  inTri.segmentlist = pointer(edges)
  inTri.numberofsegments = Int(length(edges)/2)
  inTri.segmentmarkerlist = pointer(boundary_edges)

  # Call C
  return calculate_output(inTri, options)
end

function generate_basic_input(vertices::Vector{Cdouble}, verticesMap::Vector{Cint},)
  # Basic Tri
  inTri = TriangulateIO()  
  inTri.pointlist = pointer(vertices)
  inTri.numberofpoints = length(verticesMap)
  inTri.pointmarkerlist = pointer(verticesMap)

  return inTri
end

function calculate_output(inTri::TriangulateIO, options::TriangulateOptions)
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