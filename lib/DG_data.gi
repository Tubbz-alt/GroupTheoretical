################################################################################
##
#W DwG_data.gi      DwG Package
##
#W Paul Bruillard, Cesar Galindo, Siu-Hung Ng, Julia Plavnik, Eric Rowell,
#W Zhenghan Wang
##
## Installation file for functions in the DwG_data portion of the DwG package
##
#Y Copyright (C) 2016, Battelle Memorial Institute
##
################################################################################


################################################################################
##
#F DG_S_and_T(<group>,<bool>) Computes Simples, S, T, FPdim(Xi), FPdimC for D(G)
##
InstallGlobalFunction(DG_S_and_T, function(G,display)
  local g, elmsG, R, r, tbl, chi, Simples, x, y, S, s, T, rank, x_idx, y_idx, FPdim, FPdimC,l,pseudounitary_data,sorted_data;
  elmsG := Elements(G);
  if display then 
    Print("\nG = ", StructureDescription(G), "              ", IdGroup(G), "\n");
  fi;

  # compute the simples
  R := List(ConjugacyClasses(G), Representative);
  Simples := [];
  for r in R do
    tbl := CharacterTable(Centralizer(G, r));
    for chi in Irr(tbl) do
      Add(Simples, [r, chi, ConjugacyClasses(tbl)]);
    od;
  od;
  rank:=Size(Simples);

  if display then
    Print("Rank is\n\n");
    Display(rank);
    Print("Computing S matrix\n");
  fi;

  # compute the S-matrix
  # since s is symmetric we can half the size of the inner loop
  #S := NullMat(rank,rank);
  S:=[];
#  for x_idx in [1..rank] do
#    x:=Simples[x_idx];
  for x in Simples do
    l:=[];
    #for y_idx in [x_idx..rank] do
#    for y_idx in [1..rank] do
#      y:=Simples[y_idx];
    for y in Simples do
      s := 0;
      for g in elmsG do
        if x[1]*g*y[1]*Inverse(g) = g*y[1]*Inverse(g)*x[1] then
         s := s + ComplexConjugate(x[2][Position(x[3], 
                  ConjugacyClass(Centralizer(G, x[1]), g*y[1]*Inverse(g)))])
                * ComplexConjugate(y[2][Position(y[3], 
                  ConjugacyClass(Centralizer(G, y[1]), Inverse(g)*x[1]*g))]);
        fi;
      od;
      s := s * (1/(Size(Centralizer(G, x[1])) * Size(Centralizer(G, y[1])))) * Size(G);
      #S[x_idx][y_idx] := s;
      #S[y_idx][x_idx] := s;
      Add(l,s);
     od;
     Add(S,l);
  od;

  # compute the T-matrix
  T := [];
  for x in Simples do
    Add(T, x[2][Position(x[3], ConjugacyClass(Centralizer(G, x[1]), x[1]))]/x[2][1]);
  od;

  if display then
    Print("\n The S-matrix is: \n\n");
    Print(S);
    Print("\n\n The T-matrix is: \n\n");
    Print(T);
    Print("\n\n");
  fi;

  pseudounitary_data := pseudounitary_sort(S,T,Simples);
  Simples := pseudounitary_data[1];
  S := pseudounitary_data[2];
  T := pseudounitary_data[3];
  FPdim := pseudounitary_data[4];
  FPdimC := pseudounitary_data[5];

  # sort by dimensions (if two objects have the same dimension, their
  # relative order is unchanged).
  sorted_data := dimension_sort(S,T,Simples,FPdim);
  Simples:=sorted_data[1];
  S:=sorted_data[2];
  T:=sorted_data[3];
  FPdim:=sorted_data[4];

  return [Simples, S, T, FPdim, FPdimC];
end);

################################################################################
##
#F DG_data(<group>) . . . . . . . . . . . . . . .Computes modular data for D(G).
InstallGlobalFunction(DG_data, function(G)
  local Simples, S, T, FPdim, FPdimC, N, data;
  data:=DG_S_and_T(G,false);
  Simples:=data[1];
  S:=data[2];
  T:=data[3];
  FPdim:=data[4];
  FPdimC:=data[5];
  N:=compute_fusion_rules(S,FPdimC);
  return [Simples,S,T,N,FPdim,FPdimC];
end);

#E DG_data.gi . . . . . . . . . . . . . . . . . . . . . . . . . . . . .ends here
