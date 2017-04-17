using BinDeps

@BinDeps.setup

libtriangle = library_dependency("libtriangle")

# provides(Binaries, URI("https://cache.julialang.org/https://bintray.com/artifact/download/tkelman/generic/gumbo.7z"),
#         libgumbo, unpacked_dir="usr$(Sys.WORD_SIZE)/bin", os = :Windows)

_prefix = joinpath(BinDeps.depsdir(libtriangle),"usr")
_libdir = joinpath(_prefix, "lib")

@static if is_linux()
    provides(BuildProcess,
         Autotools(libtarget="libtriangle.so"),
         libtriangle, os = :Unix)
end

@static if is_windows()

end        

@BinDeps.install Dict(:libtriangle => :libtriangle)