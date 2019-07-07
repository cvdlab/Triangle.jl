push!(LOAD_PATH,"../src/")
using Documenter, Triangle

makedocs(
	format = Documenter.HTML(),
	sitename = "Triangle.jl",
	pages = [
		"Home" => "index.md"
	]
)
