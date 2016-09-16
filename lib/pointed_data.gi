################################################################################
##
#W pointed_data.gi              DwG Package
##
#W Paul Bruillard, Cesar Galindo, Siu-Hung Ng, Julia Plavnik, Eric Rowell, 
#W Zhenghan Wang
##
## Installation file for pointed_data functions of the DwG Package
##
#Y Copyright (C) 2016, Battelle Memorial Institute
##
################################################################################


################################################################################
##
#F pointed_data(<group>,<function>,<function>). . . . compute the data of C(G,q,chi)
##
InstallGlobalFunction(pointed_data, function(G,q,chi)
  local S, T, FPdim, FPdimC, GSet, N, g,h,r,g_idx,h_idx,CC,g_cc,h_cc;
  GSet := AsSet(G);
  r:=Size(GSet);
  CC:=ConjugacyClasses(G);
  T:=List(GSet,g->0);
  S:=NullMat(r,r);
  for g_idx in [1..r] do
    g:=GSet[g_idx];
    g_cc:=Position(CC,ConjugacyClass(G,g));
    T[g_idx]:=chi[g_cc]*q(g);
    for h_idx in [g_idx..r] do
      h:=GSet[h_idx];
      h_cc:=Position(CC,ConjugacyClass(G,h));
      S[g_idx][h_idx]:=chi[g_cc]*chi[h_cc]*q(g*h)/(q(g)*q(h));
      S[h_idx][g_idx]:=S[g_idx][h_idx];
    od;
  od;
  FPdimC:=Order(G);
  FPdim:=List(GSet,g->1);
  if S[1] <> FPdim then
    Error("First row of S is not FPdimension\n");
  fi;

  N:=compute_fusion_rules(S,FPdimC);
  return [GSet,S,T,N,FPdim,FPdimC];
end);
#E pointed_data.gi  . . . . . . . . . . . . . . . . . . . . . . . . ends here
