################################################################################
##
#W verlinde.gd      GroupTheoretical Package
##
#W Paul Bruillard, Cesar Galindo, Siu-Hung Ng, Julia Plavnik, Eric Rowell,
#W Zhenghan Wang
##
## Declaration file for functions in the verlinde portion of the GroupTheoretical package
##
#Y Copyright (C) 2016, Battelle Memorial Institute
##
################################################################################

################################################################################
##
#F compute_fusion_rules(S,FPdimC)
##
## <#GAPDoc Label="compute_fusion_rules">
## <ManSection>
## <Func Name="compute_fusion_rules" Arg="S, FPdimC"/>
##
## <Description>
## Applies the Verlinde formula to compute the fusion rules. Returns a list of
## lists of lists of integers N so that N[i][j][k] is the mulitplicity of X_k in
## X_i \times X_j
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
## sorted_data:=sort_S_and_T(S,T,Simples);
## S:=sorted_data[1];
## T:=sorted_data[2];
## Simples:=sorted_data[3];
## FPdimC:=sorted_data[4];
## FPdim:=sorted_data[5];
## N:=compute_fusion_rules(S,FPdimC);
## display_fusion_rules(N);
## </Example>
## </Description>
## </ManSection>
## <#/GAPDoc>
##
DeclareGlobalFunction("compute_fusion_rules");

################################################################################
##
#F display_fusion_rules(N)
##
## <#GAPDoc Label="display_fusion_rules">
## <ManSection>
## <Func Name="display_fusion_rules" Arg="N"/>
##
## <Description>
## Displays the fusion rules.
DeclareGlobalFunction("display_fusion_rules");

#E verlinde.gd . . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
