################################################################################
##
#W compute_cohomology.gi              GroupTheoretical Package
##
#W Paul Bruillard, Cesar Galindo, Siu-Hung Ng, Julia Plavnik, Eric Rowell, 
#W Zhenghan Wang
##
## Installation file for compute_cohomology functions of the GroupTheoretical Package
##
#Y Copyright (C) 2016, Battelle Memorial Institute
##
################################################################################

################################################################################
##
#F get_cohomology(<group>,<int>). . . . a helper function for computing cocycles
##
InstallGlobalFunction(get_cohomology, function(G,k)
  local HkG, s, InitialA, a, OrderedA, A, R, C, CH, H, classes, cocycles, w;

  HkG:=GroupHomology(G,k);;
  if Size(HkG)=0 then s:=2; else s:=Lcm(HkG); fi;;
  InitialA:=CyclicGroup(s);;
  a:=MinimalGeneratingSet(InitialA)[1];;
  OrderedA:=List([1..s],x->a^x);;
  A:=TrivialGModuleAsGOuterGroup(G,InitialA);;
  R:=ResolutionFiniteGroup(G,k+1);;
  C:=HomToGModule(R,A);;
  CH:=CohomologyModule(C,k);;
  H:=ActedGroup(CH);;
  classes:=Elements(H);;
  cocycles:=List(classes,x->Mapping(CH!.representativeCocycle(x)));;
  cocycles:=List(cocycles,x->function(g,h,k) return E(s)^(Position(OrderedA,x(g,h,k))); end);;
  return [H,cocycles];;
end);

#E compute_cohomology.gi . . . . . . . . . . . . . . . . . . . . . . . ends here
