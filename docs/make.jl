push!(LOAD_PATH,"../src/")
using Documenter, TRIANGLE

makedocs(
	format = :html,
	sitename = "TRIANGLE.jl",
	pages = [
		"Home" => "index.md"
	]
)
