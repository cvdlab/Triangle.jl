module NativeInterface

include("triangle_structure.jl")
include("options_structure.jl")
include("native_calls.jl")

export TriangulateOptions
export basic_triangulation
export constrained_triangulation
export constrained_triangulation_bounded

function basic_triangulation(vertices::Vector{Cdouble}, verticesMap::Vector{Cint}, options::TriangulateOptions = TriangulateOptions())
  # Basic Tri
  inTri = generate_basic_input(vertices, verticesMap)
  #inTri.holelist = pointer(Vector{Cdouble}([2., 4.]))
  options.nopolywritten = false
  options.nobound = false
  # options.pslg = true
  options.quiet = false
  options.verbose = true

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

function generate_basic_input(vertices::Vector{Cdouble}, verticesMap::Vector{Cint})
  # Basic Tri
  print(vertices)
  print(verticesMap)
  inTri = TriangulateIO()  
  inTri.pointlist = pointer(vertices)
  inTri.numberofpoints = length(verticesMap)
  inTri.pointmarkerlist = pointer(verticesMap)

  return inTri
end

function calculate_output(inTri::TriangulateIO, options::TriangulateOptions)
  # Call C
  tupleRes = ctriangulate(inTri, getTriangulateStringOptions(options))
  
  print( unsafe_wrap(Array, tupleRes[1].pointlist, tupleRes[1].numberofpoints * 2, false) )

  print( unsafe_wrap(Array, tupleRes[1].pointmarkerlist, tupleRes[1].numberofpoints, false) )  

  print(tupleRes[1])
  triangleList = unsafe_wrap(Array, tupleRes[1].trianglelist, 
  tupleRes[1].numberoftriangles * tupleRes[1].numberofcorners, true)
  
  # Clean C
  inTri.pointlist = C_NULL
  inTri.pointmarkerlist = C_NULL

  tupleRes[1].trianglelist = C_NULL

  print(triangleList)
  return triangleList
end

end