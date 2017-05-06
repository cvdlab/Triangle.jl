include("../src/NativeInterface/trioptions.jl")

@testset "TRIANGLE.NativeInterface.TriangulateOptions" begin
    @testset "TriangulateOptions" begin
        opt = TriangulateOptions()
        @testset "getTriangulateStringOptions() Default" begin
            @test getTriangulateStringOptions(opt) == "BPIQ"
        end

        opt = TriangulateOptions()
        opt.nobound = false
        opt.nopolywritten = false
        opt.noiterationnum = false
        opt.quiet = false
        @testset "getTriangulateStringOptions() All disable" begin
            @test getTriangulateStringOptions(opt) == ""
        end        

        opt = TriangulateOptions()
        opt.pslg = true
        opt.regionattrib = true
        opt.convex = true
        opt.jettison = true
        opt.firstnumberiszero = true
        opt.edgesout = true
        opt.voronoi = true
        opt.neighbors = true
        opt.nobound = true        
        opt.nopolywritten = true
        opt.nonodewritten = true
        opt.noelewritten = true
        opt.noiterationnum = true
        opt.noholes = true
        opt.noexactaritmetic = true
        opt.order = true
        opt.orderHow = 1
        opt.dwyer = true
        opt.quiet = true
        opt.verbose = true
        @testset "getTriangulateStringOptions() All enable" begin
            @test getTriangulateStringOptions(opt) == "pAcjzevnBPNEIOXo1lQV"
        end
    end
end