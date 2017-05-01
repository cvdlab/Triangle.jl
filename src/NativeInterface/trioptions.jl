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
/*                                                                           */
=#

@enum TriangulateOptionsArea noarea=0 fixedarea=1 vararea=2
@enum TriangulateOptionsWeight noweight=0 oneweigth=1 twoweight=2
@enum TriangulateOptionsSteinerPoints nospoints=0 #= Y =# nospointsmesh=1 #= YY =# spointsforbidden=2 #= S =# usespoints=3

type TriangulateOptions
    refine::Bool # r
    quality::Bool # q
    qualityMinAngle::Float64
    vararea::TriangulateOptionsArea # a
    varareaOptionalmaxarea::Float64
    usertest::Bool # u
    regionattrib::Bool # A
    convex::Bool # c
    conformingdelaunay::Bool # D
    weighted::TriangulateOptionsWeight
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
    steiner::TriangulateOptionsSteinerPoints # Y or YY or S
    steinerQty::Int64
    incrementaldelaunay::Bool # i
    sweepline::Bool # F
    dwyer::Bool # l
    splitseg::Bool # s
    docheck::Bool # C
    quiet::Bool # Q
    verbose::Bool # V
    TriangulateOptions() = new(false, false, 0., noarea, 0., false, 
    false, false, false, noweight, false, false, false, false, false, 
    false, false, false, false, false, false, false, false, 0, 
    nospoints, 0, false, false, false, false, false, false, false)
end

function toNativeString(self::TriangulateOptions)

end