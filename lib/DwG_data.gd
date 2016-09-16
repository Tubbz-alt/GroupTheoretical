################################################################################
##
#W DwG_data.gd      DwG Package
##
#W Paul Bruillard, Cesar Galindo, Siu-Hung Ng, Julia Plavnik, Eric Rowell,
#W Zhenghan Wang
##
## Declaration file for functions in the DwG_data portion of the DwG package
##
#Y Copyright (C) 2016, Battelle Memorial Institute
##
################################################################################


################################################################################
##
#F DwG_simples(<group>,<int>,<function)
##
## <#GAPDoc Label="DwG_simples">
## <ManSection>
## <Func Name="DwG_simples" Arg="G, n, w"/>
## 
## <Description>
## Computes the simples of D^w(G). n should be the Exp(G)*Exp(H_3(G,Z)). w
## should be a function giving a normalized 3-cocycle with coefficients in
## mu_Order(H_3(G,Z)), the finite subgroup of U(1) of order Order(H_3(G,Z)). 
## To do this we first compute representatives
## of conjugacy classes of G, CC. For each x in CC we compute its centralizer in G,
## Zx. We then compute the transgression beta_x in Z^2(Zx,U(1)) as
## beta_x(g,h)=w(g,h,x)*w(x,g,h)/w(g,x,h). The projective characters, chi_k, are
## then computed using the package function projective_characters. The simples are
## then tuples [x,chi_k,ConjugacyClass(G,x),Zx].
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
## </Example>
## </Description>
## </ManSection>
## <#/GAPDoc>
##
DeclareGlobalFunction("DwG_simples");

################################################################################
##
#F DwG_S_and_T(<list>,<group>)
##
## <#GAPDoc Label="DwG_S_and_T">
## <ManSection>
## <Func Name="DwG_S_and_T" Arg="Simples, G"/>
##
## <Description>
## Computes the S and T matrix using the formula in GANNON PAPER REFERENCE. G
## should be the same group given to compute_simples and Simples should be the
## output of compute_simples. This function returns [S,T] where S and T are
## lists of lists.
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
## </Example>
## </Description>
## </ManSection>
## <#/GAPDoc>
##
DeclareGlobalFunction("DwG_S_and_T");

################################################################################
##
#F DwG_data(<group>,<function>,<int>)
##
## <#GAPDoc Label="DwG_data">
## <ManSection>
## <Func Name="DwG_data" Arg="G, w, n"/>
##
## <Description>
## Compute the modular data for D^w(G). The data returned is
## [Simples,S,T,N,FPdim,FPdimC]. n should be Exponent(G)*Exponent(H^3(G,w)) or
## Exponent(G)*Order(w).
##
## <Example><![CDATA[gap>
## LoadPackage("HAP");
## G:=SymmetricGroup(3);
## H_and_coycles:=get_cohomology(G,3);
## H:=H_and_cocycles[1];
## cocycles:=H_and_cocycles[2];
## w:=cocycles[2];
## n:=Exponent(G)*Exponent(H);
## data:=DwG_data(G,w,n);
## Simples:=data[1];
## S:=data[2];
## T:=data[3];
## N:=data[4];
## FPdim:=data[5];
## FPdimC:=data[6];
## </Example>
## </Description>
## </ManSection>
## <#/GAPDoc>
##
DeclareGlobalFunction("DwG_data");

#

#E DwG_data.gd . . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
