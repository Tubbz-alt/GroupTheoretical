################################################################################
##
#W verlinde.gi              DwG Package
##
#W Paul Bruillard, Cesar Galindo, Siu-Hung Ng, Julia Plavnik, Eric Rowell, 
#W Zhenghan Wang
##
## Installation file for verlinde functions of the DwG Package
##
#Y Copyright (C) 2016, Battelle Memorial Institute
##
################################################################################

################################################################################
##
#F compute_fusion_rules(<list>,<number>). . . . . . . .use verlinde to compute N
##
InstallGlobalFunction(compute_fusion_rules, function(S,FPdimC)
  local N,r,i,j,k,m;
  r:=Length(S[1]);
  N:=List([1..r],i->NullMat(r,r));
  for i in [1..r] do
    for j in [1..r] do
      for k in [1..r] do
        for m in [1..r] do
          N[i][j][k]:=N[i][j][k]+S[i][m]*S[j][m]*ComplexConjugate(S[k][m])/S[1][m];
        od;
        N[i][j][k]:=N[i][j][k]/FPdimC;
      od;
    od;
  od;
  return N;
end);

################################################################################
##
#F display_fusion_rules(<list>). . . . . . . . . display the fusion rules
##
InstallGlobalFunction(display_fusion_rules, function(N)
  local x;
  for x in [1..Size(N)] do
    Print("\nN_",x,"\n");
    Display(N[x]);
  od;
  Print("\n");
end);

#E verlinde.gi . . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
