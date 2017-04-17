module TRIANGLE

depsjl = joinpath(dirname(@__FILE__), "..", "deps", "deps.jl")

if isfile(depsjl)
	include(depsjl)
else
	error("TRIANGLE is not properly installed. Please try to run\nPkg.build(\"TRIANGLE\")")
end

print("Started")

# REAL = double = Cdouble
type triangulateio
  pointlist::Array{Cdouble}
  pointattributelist::Array{Cdouble}
  pointmarkerlist::Array{Cint}                                         /* In / out */
  numberofpoints::Cint                                           /* In / out */
  numberofpointattributes::Cint                                   /* In / out */

  trianglelist::Array{Cint}                                           /* In / out */
  triangleattributelist::Array{Cdouble}                                   /* In / out *
  trianglearealist::Array{Cdouble}                                        /* In only */
  neighborlist::Array{Cint}                                          /* Out only */
  numberoftriangles::Cint                                         /* In / out */
  numberofcorners::Cint                                          /* In / out */
  numberoftriangleattributes::Cint                                /* In / out */

  segmentlist::Array{Cint}                                                /* In / out */
  segmentmarkerlist::Array{Cint}                                          /* In / out */
  numberofsegments::Cint                                          /* In / out */

  holelist::Array{Cdouble}                        /* In / pointer to array copied out */
  numberofholes::Cint                                      /* In / copied out */

  regionlist::Array{Cdouble}                      /* In / pointer to array copied out */
  numberofregions::Cint                                    /* In / copied out */

  edgelist::Array{Cint}                                                   /* Out only */
  edgemarkerlist::Array{Cint}              /* Not used with Voronoi diagram; out only */
  normlist::Array{Cdouble}               /* Used only with Voronoi diagram; out only */
  numberofedges::Cint                                             /* Out only *
end

end