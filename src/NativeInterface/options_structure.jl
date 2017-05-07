#=
/* Switches for the triangulator.                                            */
/*   poly: -p switch.  refine: -r switch.                                    */
/*   quality: -q switch.                                                     */
/*     minangle: minimum angle bound, specified after -q switch.             */
/*     goodangle: cosine squared of minangle.                                */
/*     offconstant: constant used to place off-center Steiner points.        */
/*   vararea: -a switch without number.                                      */
/*   fixedarea: -a switch with number.                                       */
/*     maxarea: maximum area bound, specified after -a switch.               */
/*   usertest: -u switch.                                                    */
/*   regionattrib: -A switch.  convex: -c switch.                            */
/*   weighted: 1 for -w switch, 2 for -W switch.  jettison: -j switch        */
/*   firstnumber: inverse of -z switch.  All items are numbered starting     */
/*     from `firstnumber'.                                                   */
/*   edgesout: -e switch.  voronoi: -v switch.                               */
/*   neighbors: -n switch.  geomview: -g switch.                             */
/*   nobound: -B switch.  nopolywritten: -P switch.                          */
/*   nonodewritten: -N switch.  noelewritten: -E switch.                     */
/*   noiterationnum: -I switch.  noholes: -O switch.                         */
/*   noexact: -X switch.                                                     */
/*   order: element order, specified after -o switch.                        */
/*   nobisect: count of how often -Y switch is selected.                     */
/*   steiner: maximum number of Steiner points, specified after -S switch.   */
/*   incremental: -i switch.  sweepline: -F switch.                          */
/*   dwyer: inverse of -l switch.                                            */
/*   splitseg: -s switch.                                                    */
/*   conformdel: -D switch.  docheck: -C switch.                             */
/*   quiet: -Q switch.  verbose: count of how often -V switch is selected.   */
/*   usesegments: -p, -r, -q, or -c switch; determines whether segments are  */
/*     used at all.                                                          */
/* 

/*  If the size of the object file is important to you, you may wish to      */
/*  generate a reduced version of triangle.o.  The REDUCED symbol gets rid   */
/*  of all features that are primarily of research interest.  Specifically,  */
/*  the -DREDUCED switch eliminates Triangle's -i, -F, -s, and -C switches.  */
/*  The CDT_ONLY symbol gets rid of all meshing algorithms above and beyond  */
/*  constrained Delaunay triangulation.  Specifically, the -DCDT_ONLY switch */
/*  eliminates Triangle's -r, -q, -a, -u, -D, -Y, -S, and -s switches.       */                                                                          */
=#

type TriangulateOptions
    pslg::Bool #p
    regionattrib::Bool # A
    convex::Bool # c
    jettison::Bool # j
    firstnumberiszero::Bool # z
    edgesout::Bool # e
    voronoi::Bool # v
    neighbors::Bool # n
    nobound::Bool # B
    nopolywritten::Bool # P
    nonodewritten::Bool # N
    noelewritten::Bool # E
    noiterationnum::Bool # I
    noholes::Bool # O
    noexactaritmetic::Bool # X
    order::Bool # o
    orderHow::Int64 # 1...2...3
    dwyer::Bool # l
    quiet::Bool # Q
    verbose::Bool # V
    TriangulateOptions() = new(false, 
    false, false, false, false, false, false, false,
    # No_xyz_ selector(s)
    true, true, false, false, true, false, false, 
    # order
    false, 0, 
    false, 
    # Quiet Verbose
    true, false)
end

function getTriangulateStringOptions(self::TriangulateOptions)
    output_stri = ""

    if self.pslg
        output_stri = output_stri * "p"
    end

    if self.regionattrib
        output_stri = output_stri * "A"
    end
    
    if self.convex
        output_stri = output_stri * "c"
    end

    if self.jettison
        output_stri = output_stri * "j"
    end

    if self.firstnumberiszero
        output_stri = output_stri * "z"
    end

    if self.edgesout
        output_stri = output_stri * "e"
    end

    if self.voronoi
        output_stri = output_stri * "v"
    end

    if self.neighbors
        output_stri = output_stri * "n"
    end

    if self.nobound
        output_stri = output_stri * "B"
    end

    if self.nopolywritten
        output_stri = output_stri * "P"
    end

    if self.nonodewritten
        output_stri = output_stri * "N"
    end

    if self.noelewritten
        output_stri = output_stri * "E"
    end

    if self.noiterationnum
        output_stri = output_stri * "I"
    end

    if self.noholes
        output_stri = output_stri * "O"
    end

    if self.noexactaritmetic
        output_stri = output_stri * "X"                                                
    end

    if self.order && self.orderHow > 0
        output_stri = output_stri * "o" * string(self.orderHow) 
    end    

    if self.dwyer
        output_stri = output_stri * "l"
    end

    if self.quiet
        output_stri = output_stri * "Q"                                                
    end

    if self.verbose
        output_stri = output_stri * "V"                                                
    end

    return output_stri
end