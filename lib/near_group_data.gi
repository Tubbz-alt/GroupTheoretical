################################################################################
##
#W TY_data.gi              DwG Package
##
#W Paul Bruillard, Cesar Galindo, Siu-Hung Ng, Julia Plavnik, Eric Rowell, 
#W Zhenghan Wang
##
## Installation file for near_group_data functions of the DwG Package
##
#Y Copyright (C) 2016, Battelle Memorial Institute
##
################################################################################


################################################################################
##
#F near_group_data(<group>,<int>). . . . . . compute the data
## . . . . . . . . . . . . . . . . . . . . . for a neargroup category k=0 is TY.
##
InstallGlobalFunction(near_group_data, function(G,k)
  local Simples,m,N,rank,x,FPdimC,FPdim,S,T,g_idx,h_idx,g,h;

  if k < 0 or not(IsInt(k)) then
    Error("k must be a non-negative integer\n");
  fi;

  if k > 0 then

    Error("k > 0 is not currently supported. We need to unravel Siehler's paper 'Near-group categories\n");

    if Order(G) > k+1 then
      Error("near group categories only admit monoidal structure for |G| <= k+1");
    fi;

    if Order(G) = k+1 and not(IsCyclic(G) and Size(Set(FactorsInt(Order(G)+1))) = 1) then
      Error("for |G| = k+1, the near group category only admits monoidal structure if G  is the multiplicative group of a finite field.");
    fi;

    if Order(G) = 1 and ( (k mod 4) = 2 or (k mod 4) = 3) then
      Error("For |G| = 1, the near group category does not admit  monoidal structure if k = 2 or 3 mod 4.");
    fi;
  fi;

  Simples := ShallowCopy(AsSet(G));
  m:="m";
  Add(Simples,m);
  rank:=Size(Simples);
  N:=List([1..rank],x->NullMat(rank,rank));
  # compute the fusion rules
  for g_idx in [1..rank] do
    g:=Simples[g_idx];
    for h_idx in [1..rank] do
      h:=Simples[h_idx];
      if g_idx = rank then
        if h_idx = rank then
          # m\otimes m = Sum_{k\in G}k+km
          N[g_idx][h_idx]:=List([1..rank],x->1);
          N[g_idx][h_idx][rank] := k;
        else
          N[g_idx][h_idx][rank] := 1; # m\otimes h = m
        fi;
      else
        if h_idx = rank then
          N[g_idx][h_idx][rank] := 1; # g\otimes m = m
        else 
          # g\otimes h = gh
          N[g_idx][h_idx][Position(Simples,g*h)] := 1;
        fi;
      fi;
    od;
  od;

  FPdimC := 2*Order(G);
  FPdim := List([1..rank],x->1);
  FPdim[rank] := Sqrt(Order(G));
  return [Simples, N, FPdim, FPdimC];
end);

################################################################################
##
#F TY_data(<group>,<bicharacter>,<num>,<list>,<sign>). . . . compute the data for TY(G,chi,tau,delta,Tsign)
##
InstallGlobalFunction(TY_data, function(G,chi,tau,delta,Tsign)
  local Simples,m,N,rank,x,FPdimC,FPdim,S,T,sigma1,sigma3_1,sigma3,sigma3_squared,sigma3_squared_trace,g_idx,h_idx,g,h;

  if not(IsInt(Tsign)) or Tsign^2 <> 1 then
    Error("Tsign must be +/-1");
  fi;

  if Size(delta)<>Order(G)+1 or false in List(delta,x->(IsInt(x) and x^2=1)) then
    Error("delta must be a list of length |G|+1 and consist entirely of +/- 1");
  fi;

  if (1/tau)^2 <> Order(G) then
    Error("tau must be a choice of squareroot of 1/|G|");
  fi;

  Simples := ShallowCopy(AsSet(G));
  m:="m";
  Add(Simples,m);
  rank:=Size(Simples);
  N:=List([1..rank],x->NullMat(rank,rank));
  # compute the fusion rules
  for g_idx in [1..rank] do
    g:=Simples[g_idx];
    for h_idx in [1..rank] do
      h:=Simples[h_idx];
      if g_idx = rank then
        if h_idx = rank then
          # m\otimes m = Sum_{k\in G}k+km
          N[g_idx][h_idx]:=List([1..rank],x->1);
          N[g_idx][h_idx][rank] := 0;
        else
          N[g_idx][h_idx][rank] := 1; # m\otimes h = m
        fi;
      else
        if h_idx = rank then
          N[g_idx][h_idx][rank] := 1; # g\otimes m = m
        else 
          # g\otimes h = gh
          N[g_idx][h_idx][Position(Simples,g*h)] := 1;
        fi;
      fi;
    od;
  od;

  FPdimC := 2*Order(G);
  FPdim := List([1..rank],x->1);
  FPdim[rank] := Sqrt(Order(G));

  if not(IsAbelian(G) and Exponent(G)=2) then
    # not braided. Return the fusion rules and simples (arxiv:math/0011037v1)
    Display("G is not an elementary abelian 2-group and so the associated category does not admit a braiding.");
    return [Simples, N, FPdim, FPdimC];
  else
    # the category admits a braiding.
    # 
    # need to compute the S-matrix and T-matrix
    #
    # First we compute T
    sigma1:=List([1..rank-1],x->delta[x]*Sqrt(chi[x][x]));
    sigma3_1:=delta[1]*Sqrt(tau*Sum(sigma1));
    T:=List([1..rank],x->0);
    for x in [1..rank-1] do
      T[x] := chi[x][x];
    od;
    T[rank]:=Tsign/sigma3_1;
    S:=NullMat(rank,rank);
    # sigma1 = sigma2 (Seihler section 2.3)
    # since delta[x] = pm1 we have sigma1[g]*sigma2[g] = chi[g][g]
    sigma3:=List([1..rank-1],x->sigma3_1*sigma1[x]*chi[x][x]);
    sigma3_squared:=List(sigma3,x->x^2);
    sigma3_squared_trace:=Sum(sigma3);
    for g in [1..rank-1] do
      for h in [1..rank-1] do
        # group elements are invertible
        #S[g][h] := chi[g][h]*chi[h][g]*FPdim[g]*FPdim[h];
        S[g][h] := chi[g][h]*chi[h][g];
      od;
      #S[g][m] := sigma1[g]*sigma2[g]*FPdim[g]*FPdim[rank];
      # group elements are invertible
      S[g][rank] := chi[g][g]*FPdim[rank];
      S[rank][g] := S[g][rank];
    od;
    S[rank][rank] := sigma3_squared_trace*FPdim[rank]*FPdim[rank];
    Display("VERIFY S and T\n");
    return [Simples,S,T,N,FPdim,FPdimC];
  fi;
end);
#E near_group_data.gi  . . . . . . . . . . . . . . . . . . . . . . . . ends here
