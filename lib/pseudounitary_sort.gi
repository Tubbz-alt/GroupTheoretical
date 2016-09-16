################################################################################
##
#W pseudounitary_sort.gi              GroupTheoretical Package
##
#W Paul Bruillard, Cesar Galindo, Siu-Hung Ng, Julia Plavnik, Eric Rowell, 
#W Zhenghan Wang
##
## Installation file for pseudounitary_sort functions of the GroupTheoretical Package
##
#Y Copyright (C) 2016, Battelle Memorial Institute
##
################################################################################

################################################################################
##
#F pseudounitary_sort(<list>,<list>,<list>) . . . . sorts S and T to give pseudo
##. . . . . . . . . . . . . . .  . . . . . . .unitary data. FPdims are computed.
##
InstallGlobalFunction(pseudounitary_sort, function(S,T,Simples)
  local FPdim,FPdimC,x,r,i,FPRow,FPRow_idx,j,is_real,is_pos;
  #
  # look along the diagonal for 1's and check that the corresponding row is real
  # and positive
  FPRow:=[];
  r := Size(Simples);
  for i in [1..r] do
    if S[i][i] = 1 then
      is_real := true;
      is_pos := true;
      for j in [1..r] do
        if ImaginaryPart(S[i][j]) <> 0 then
          is_real := false;
          break;
        fi;
        if S[i][j] <= 0 then
          is_pos := false;
          break;
        fi;
      od;
      if is_real and is_pos then
        Add(FPRow,ShallowCopy(S[i]));
      fi;;
    fi;
  od;

  # find out which row is largest
  Sort(FPRow);
  FPRow:=Reversed(FPRow);
  FPRow_idx:=Position(S,FPRow[1]);

  # switch 1 with FPRow_idx
  if FPRow_idx <> 1 then
    S{[1,FPRow_idx]}:=S{[FPRow_idx,1]};
    S:=TransposedMatMutable(S);
    S{[1,FPRow_idx]}:=S{[FPRow_idx,1]};
    S:=TransposedMatMutable(S);
    Simples{[1,FPRow_idx]}:=Simples{[FPRow_idx,1]};
    T{[1,FPRow_idx]}:=T{[FPRow_idx,1]};
  fi;

  # get the FPdimension
  FPdim:=ShallowCopy(S[1]);
  FPdimC:=Sum(List(FPdim,x->x^2));

  return [Simples,S,T,FPdim,FPdimC];
end);

################################################################################
##
#F dimension_sort(<list>,<list>,<list>,<list>) . . . . sorts data by increasing
#                                               dimension.
##
InstallGlobalFunction(dimension_sort, function(S,T,Simples,FPdim)
  local made_switch, x, r;
  made_switch := true;
  r:=Size(FPdim);
  while made_switch do
    made_switch := false;
    for x in [3..r] do
      if FPdim[x] < FPdim[x-1] then
        S{[x,x-1]} := S{[x-1,x]};
        S:=TransposedMatMutable(S);
        S{[x,x-1]} := S{[x-1,x]};
        S:=TransposedMatMutable(S);
        T{[x,x-1]} := T{[x-1,x]};
        FPdim{[x,x-1]} := FPdim{[x-1,x]};
        Simples{[x,x-1]} := Simples{[x-1,x]};
        made_switch := true;
      fi;
    od;
  od;
  return [Simples,S,T,FPdim];
end);
#E pseudounitary_sort.gi . . . . . . . . . . . . . . . . . . . . . . . ends here
