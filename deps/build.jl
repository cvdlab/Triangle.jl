using BinDeps

isfile("deps.jl") && rm("deps.jl")

@BinDeps.setup
    deps = [libnix = library_dependency("libtriangle", aliases = ["libtriangle.so","libtriangle.dylib"], runtime = false, os = :Unix),
            libwin = library_dependency("libtriangle", aliases = ["libtriangle.dll"], runtime = false, os = :Windows)]
    rootdir = BinDeps.depsdir(libnix)
    srcdir = joinpath(rootdir, "src")
    prefix = joinpath(rootdir, "usr")
    libdir = joinpath(prefix, "lib")
    headerdir = joinpath(prefix, "include")

    if is_windows()
        libfile = joinpath(libdir, "libtriangle.dll")
    else 
        libname = "libtriangle.so"
        if is_apple()
            libname = "libtriangle.dylib"
        end
        libfile = joinpath(libdir, libname)
        provides(BinDeps.BuildProcess, (@build_steps begin
                    FileRule(libfile, @build_steps begin
                        BinDeps.ChangeDirectory(srcdir)
                        `make clean`
                        `make`
                        `cp libtriangle.so $libfile`
                        `cp triangle.h $headerdir/`
                        `cp tricall.h $headerdir/`
                        `cp commondefine.h $headerdir/`
                        `make clean`
                    end)
                end), libnix)
    end

if is_windows()
    @BinDeps.install Dict(:libwin => :_jl_libtriangle)
else
    @BinDeps.install Dict(:libnix => :_jl_libtriangle)
end