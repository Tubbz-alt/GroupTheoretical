################################################################################
##
#W Projective_Representations.gd      DwG Package
##
#W Paul Bruillard, Cesar Galindo, Siu-Hung Ng, Julia Plavnik, Eric Rowell,
#W Zhenghan Wang
##
## Declaration file for functions in the Projective Representations
## portion of the DwG package
##
#Y Copyright (C) 2016, Battelle Memorial Institute
##
################################################################################


################################################################################
##
#F projective_reps(<group>,<function>,<int>)
##
## <#GAPDoc Label="projective_reps">
## <ManSection>
## <Func Name="projective_reps" Arg="G, alpha, n"/>
## 
## <Description>
## Computes the alpha-projective characters of G.
## Here G is a finite group, alpha is a 2-cocycle of G valuesd in mu_s, the
## cyclic group of order s in the complex numbers (here s=Lcm(Homology(G,2))). n
## is given by Exponent(G)*Exponent(H^2(G,mu_s)) or Exponent(G)*Order(alpha).
## The characters are returned as a list of lists, chi, so that chi[i] is the
## i-th character and chi[i][j] is the value of the character on the group
## element AsSet(G)[j].
##
## <Example><![CDATA[gap>
## LoadPackage("HAP");
## G:=ElementaryAbelianGroup(4);;
## H2G:=GroupHomology(G,2);
## if Size(H2G)=0 then
##   s:=2;
## else 
##   s:=Lcm(H2G);
## fi;
## InitialA:=CyclicGroup(s);
## a:=MinimalGeneratingSet(InitialA)[1];
## OrderedA:=List([1..s],x->a^x);
## A:=TrivialGModuleAsGOuterGroup(G,InitialA);
## R:=ResolutionFiniteGroup(G,3);
## C:=HomToGModule(R,A);
## CH:=CohomologyModule(C,2);
## H:=ActedGroup(CH);
## classes:=Elements(H);
## # twisted group algebra always splits into matrix algebras over
## # R=cylcotomicfield(Exponent(G)*Exponent(H))
## n:=Exponent(G)*Exponent(H); # can replace exp(H) by order(alpha)
## 
## for class in classes do
##   c:=CH!.representativeCocycle(class);
##   alpha:=function(g,h) return E(s)^(Position(OrderedA,Mapping(c)(g,h))); end;;
## 
##   chi:=projective_reps(G,alpha,n);
##   Display("alpha-projectives");
##   Display(chi);
## od;
## </Example>
## </Description>
## </ManSection>
## <#/GAPDoc>
##
DeclareGlobalFunction("projective_reps");

#E Projective_Representations.gd . . . . . . . . . . . . . . . . . . . ends here
