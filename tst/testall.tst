################################################################################
##
#A testall.tst               DwG Package
##
#A Paul Bruillard, Cesar Galindo, Siu-Hung Ng, Julia Plavnik, Eric Rowell
#A Zhenghan Wang
##
##
gap> START_TEST("DwG package: testall.tst");
gap> LoadPackage("HAP",false);
true
gap> LoadPackage("DwG",false);
true

################################################################################
## testing symmetric_data
gap> G:=CyclicGroup(2);;
gap> Z2_data:=symmetric_data(G,AsSet(G)[1]);;
gap> sVec_data:=symmetric_data(G,AsSet(G)[2]);;

################################################################################
## testing poitned_data
gap> Display("testing pointed data functions.");

testing pointed data functions.

gap> G:=ElementaryAbelianGroup(4);
gap> q:=function(g) return 1; end;
gap> chi:=Irr(G)[1];
gap> data:=pointed_data(G,q,chi);

gap> Simples:=data[1];
gap> S:=data[2];
gap> T:=data[3];
gap> N:=data[4];
gap> FPdim:=data[5];
gap> FPdimC:=data[6];

################################################################################
## testing D(G)
gap> Display("testing DG_data functions.");

testing DG_data functions.

gap> G:=SymmetricGroup(3);;
gap> data:=DG_S_and_T(G,false);;
gap> Simples:=data[1];;
gap> S:=data[2];;
gap> T:=data[3];;
gap> FPdim:=data[4];;
gap> FPdimC:=data[5];;

################################################################################
## testing verlinde
gap> Display("testing verlinde on DG data.")

testing verlinde on DG data.

gap> N:=compute_fusion_rules(S,FPdimC);;

################################################################################
## testing DwG_data
gap> Display("testing DwG_data functions.")

testing DwG_data functions.

gap> G:=SymmetricGroup(3);;
gap> H_and_cocycles:=get_cohomology(G,3);;
gap> H:=H_and_cocycles[1];;
gap> cocycles:=H_and_cocycles[2];;
gap> w:=cocycles[3];;
gap> n:=Exponent(G)*Exponent(H);; # can replace exp(H) by order(alpha)
gap> chi:=projective_reps(G,alpha,n);;

gap> Display("Computing simples");;

Computing simples

gap> Simples:=DwG_simples(G,n,w);;

gap> Display("Computing S and T");;

Computing S and T

gap> S_and_T:=DwG_S_and_T(Simples,G);;
gap> S:=S_and_T[1];;
gap> T:=S_and_T[2];;

gap> Display("Computing FP dimension");

Computing FP dimension

gap> S_and_T:=pseudounitary_sort(S,T,Simples);;
gap> Simples:=S_and_T[1];;
gap> S:=S_and_T[2];;
gap> T:=S_and_T[3];;
gap> FPdim:=S_and_T[4];;
gap> FPdimC:=S_and_T[5];;

gap> Display("Computing fusion rules");;

Computing fusion rules

gap> N:=compute_fusion_rules(S,FPdimC);;

gap> data:=DwG_data(G,w,n);;
gap> Simples:=data[1];
gap> S:=data[2];
gap> T:=data[3];
gap> N:=data[4];
gap> FPdim:=data[5];
gap> FPdimC:=data[6];

################################################################################
## testing DwG_rank
gap> Display("testing DwG_rank functions.");;

testing DwG_rank functions.

gap> ranks:=DwG_rank(G,false);;

################################################################################
## testing Projective_Representations
gap> Display("testing projective rep calculations");;

testing projective rep calculations

gap> # create a group G, a finite cyclic group A, and a 2-cocycle alpha of G with
gap> # coefficients in A. 
gap> G:=ElementaryAbelianGroup(4);;
gap> H_and_cocycles:=get_cohomology(G,2);;
gap> H:=H_and_cocycles[1];;
gap> cocycles:=H_and_cocycles[2];;

gap> # twisted group algebra always splits into matrix algebras over
gap> # R=cylcotomicfield(Exponent(G)*Exponent(H))
gap> n:=Exponent(G)*Exponent(H); # can replace exp(H) by order(alpha)
gap> for alpha in cocycles do
> chi:=projective_reps(G,alpha,n);
>od;
#gap> for class in classes do
#> c:=CH!.representativeCocycle(class);
#> alpha:=function(g,h) return E(s)^(Position(OrderedA,Mapping(c)(g,h))); end;;
#> chi:=projective_reps(G,alpha,n);
#> od;

gap> STOP_TEST("testall.tst",10000);
################################################################################
##
#E
