module TRIANGLE

depsjl = joinpath(dirname(@__FILE__), "..", "deps", "deps.jl")

if isfile(depsjl)
	include(depsjl)
else
	error("TRIANGLE is not properly installed. Please try to run\nPkg.build(\"TRIANGLE\")")
end

print("Started")

end