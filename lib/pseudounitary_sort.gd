################################################################################
##
#W pseudounitary_sort.gd      GroupTheoretical Package
##
#W Paul Bruillard, Cesar Galindo, Siu-Hung Ng, Julia Plavnik, Eric Rowell,
#W Zhenghan Wang
##
## Declaration file for functions in the pseudounitary_sort portion of the GroupTheoretical 
##   package
##
#Y Copyright (C) 2016, Battelle Memorial Institute
##
################################################################################

################################################################################
##
#F pseudounitary_sort(<list>,<list>,<list>)
##
## <#GAPDoc Label="pseudounitary_sort">
## <ManSection>
## <Func Name="pseudounitary_sort" Arg="S, T, Simples"/>
##
## <Description>
## Sorts the S and T matrices so that the FPdim is the first row/col of the
## S-matrix. The simples are similarly reordered. The FPdimension of the
## category is computed. The function returns [Simples,S,T,FPdim,FPdimC]
##
## <Example><![CDATA[gap>
## LoadPackage("HAP");
## G:=SymmetricGroup(3);
## H3G:=GroupHomology(G,3);
## if Size(H3G)=0 then
##   s:=2;
## else
##   s:=Lcm(L3G);
## fi;
## InitialA:=CyclicGroup(s);
## a:=MinimalGeneratingSet(InitialA)[1];
## OrderedA:=List([1..s],x->a^x);
## A:=TrivialGModuleAsGOuterGroup(G,InitialA);
## R:=ResolutionFiniteGroup(G,4);
## C:=HomToGModule(R,A);
## CH:=CohomologyModule(C,3);
## H:=ActedGroup(CH);
## classes:=Elements(H);
## c:=CH!.representativeCocycle(classes[3]);
## abstract_w:=Mapping(c);
## w:=function(x,y,z) return E(s)^(Position(OrderedA,abstract_w(x,y,z))); end;
## n:=Exponent(G)*Exponent(H);
## Simples:=DwG_simples(G,n,w);
## S_and_T:=DwG_S_and_T(Simples,G);
## S:=S_and_T[1];
## T:=S_and_T[2];
## sorted_data:=pseudounitary_sort(S,T,Simples);
## Simples:=sorted_data[1];
## S:=sorted_data[2];
## T:=sorted_data[3];
## FPdim:=sorted_data[4];
## FPdimC:=sorted_data[5];
## </Example>
## </Description>
## </ManSection>
## <#/GAPDoc>
##
DeclareGlobalFunction("pseudounitary_sort");

################################################################################
##
#F dimension_sort(<list>,<list>,<list>,<list>) . . . . sorts data by increasing
#                                               dimension.
##
## <#GAPDoc Label="pseudounitary_sort">
## <ManSection>
## <Func Name="pseudounitary_sort" Arg="S, T, Simples"/>
##
## <Description>
## Sorts Simples, S, T, and FPdim by increasing FPdim. If two simples share the
## same FPdim, then their relative order remains unchanged.
## </Description>
##
DeclareGlobalFunction("dimension_sort");

#E pseudounitary_sort.gd . . . . . . . . . . . . . . . . . . . . . . . ends here
