################################################################################
##
#W symmetric_data.gi              GroupTheoretical Package
##
#W Paul Bruillard, Cesar Galindo, Siu-Hung Ng, Julia Plavnik, Eric Rowell, 
#W Zhenghan Wang
##
## Installation file for symmetric_data functions of the GroupTheoretical Package
##
#Y Copyright (C) 2016, Battelle Memorial Institute
##
################################################################################


################################################################################
##
#F symmetric_data(<group>,<group_element>). . . . compute the symmetric data for Rep(G,z)
##
InstallGlobalFunction(symmetric_data, function(G,z)
  local tbl, cc_sizes, order, chi, rank, n, m, k, chim_times_chin, N, FPdim, FPdimC, S, T;
  # first verify that z is central in G
  if not(z in Center(G)) then
    Error("z is not central in G\n");
  fi;

  # verify that z has order <= 2
  if Order(z) > 2 then
    Error("z has order > 2\n");
  fi;

  # first coompute the fusion matrices
  tbl:=CharacterTable(G);
  cc_sizes:=SizesConjugacyClasses(tbl);
  chi:=Irr(tbl);
  order:=Size(G);
  rank:=Size(cc_sizes);

  N:=List([1..rank], n->NullMat(rank,rank));

  for n in [1..rank] do
    for m in [n..rank] do
      chim_times_chin:=ComplexConjugate(chi[m]*chi[n]);
      for k in [1..rank] do
        N[n][m][k]:= Sum([1..rank],i->cc_sizes[i]*chi[k][i]*chim_times_chin[i])/order;
        N[m][n][k]:=N[n][m][k];
      od;
    od;
  od;

  # get the dimensions and form the S-matrix
  FPdim := List(chi,x->x[1]);
  FPdimC := Sum(List(FPdim,x->x^2));
  S:=List(FPdim,x->List(FPdim,y->x*y));

  if z = Identity(G) then
    T:=List(FPdim,x->1);
  else
    # VERIFY THIS
    Display("VERIFY THAT THIS IS CORRECT\n");
    n := Position(ConjugacyClasses(tbl),ConjugacyClass(G,z));
    T:=ShallowCopy(chi[n]);
  fi;

  return [chi,S,T,N,FPdim,FPdimC];
end);
#E symmetric_data.gi  . . . . . . . . . . . . . . . . . . . . . . . . ends here
