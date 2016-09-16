################################################################################
##
#W DwG_data.gi              DwG Package
##
#W Paul Bruillard, Cesar Galindo, Siu-Hung Ng, Julia Plavnik, Eric Rowell, 
#W Zhenghan Wang
##
## Installation file for DwG_data functions of the DwG Package
##
#Y Copyright (C) 2016, Battelle Memorial Institute
##
################################################################################

################################################################################
##
#F DwG_simples(<group>,<int>,<function>) . . . . . compute simples in D^w(G)
##
InstallGlobalFunction( DwG_simples, function(G,n,w)
  local x,Zx,wx,CC,SimpleObjects,projective_characters,chi;
  CC:=List(ConjugacyClasses(G),Representative);;
  SimpleObjects:=[];
  for x in CC do
    Zx:=Centralizer(G,x);
    wx:=function(g,h) return w(g,h,x)*w(x,g,h)*(w(g,x,h)^-1); end;;
    projective_characters:=projective_reps(Zx,wx,n);
    if not(Sum(List(projective_characters,chi->chi[1]^2))=Order(Zx)) then
      Display("ERROR");
    fi;
    for chi in projective_characters do
      Append(SimpleObjects,[[x,chi,ConjugacyClass(G,x),wx,Zx]]);
    od;
  od;
  return SimpleObjects;
end );

################################################################################
##
#F DwG_S_and_T(<list>,<group>) . . . . . . . . . .compute S and T for D^w(G)
##
InstallGlobalFunction(DwG_S_and_T, function(Simples,G)
  local r,S,T,i,simple1,x,chi,Kx,betax,Zx,x_idx,Zx_Transversal,j,simple2,y,chi_prime,Ky,betay,Zy,Zy_Transversal,a,g,Zg,b,g_prime,h_prime,h,h_idx,h_prime_idx;

  r:=Length(Simples);
  S:=NullMat(r,r);;
  T:=List([1..r],i->0);
  for i in [1..r] do
    simple1:=Simples[i];
    x:=simple1[1];
    chi:=simple1[2];
    Kx:=simple1[3];
    betax:=simple1[4];
    Zx:=simple1[5];
    #x_idx:=Position(GSet,x);
    x_idx:=Position(AsSet(Zx),x);
    T[i]:=chi[x_idx]/chi[Position(AsSet(Zx),Identity(Zx))];
    Zx_Transversal:=RightTransversal(G,Zx);
    for j in [i..r] do
      simple2:=Simples[j];
      y:=simple2[1];
      chi_prime:=simple2[2];
      Ky:=simple2[3];
      betay:=simple2[4];
      Zy:=simple2[5];
      #y_idx:=Position(GSet,y);
      Zy_Transversal:=RightTransversal(G,Zy);
      for a in Zx_Transversal do
        g:=(a^-1)*x*a;
        if not(g in Kx) then
          continue;
        fi;
        Zg:=Centralizer(G,g);
        for b in Zy_Transversal do
          g_prime:=(b^-1)*y*b;
          if not((g_prime in Ky) and (g_prime in Zg)) then
            continue;
          fi;
          h_prime:=b*g*(b^-1);
          h:=a*g_prime*(a^-1);
          h_idx:=Position(AsSet(Zx),h);
          h_prime_idx:=Position(AsSet(Zy),h_prime);
          S[i][j]:=S[i][j]+betax(a,g_prime)*betax(a*g_prime,a^-1)*betay(b,g)*betay(b*g,b^-1)*(betax(a,a^-1)^-1)*(betay(b,b^-1)^-1)*chi[h_idx]*chi_prime[h_prime_idx];
        od;
      od;
      S[j][i]:=S[i][j];
    od;
  od;

  return [S,T];
end);

################################################################################
##
#F DwG_data(<group>,<function>,<int>) . . . . . compute data of D^w(G)
InstallGlobalFunction(DwG_data,function(G,w,n)
  local Simples, S_and_T, pseudounitary_data, S, T, N, FPdimC, FPdim,sorted_data;
  Simples := DwG_simples(G,n,w);;
  S_and_T := DwG_S_and_T(Simples,G);;
  S := S_and_T[1];
  T := S_and_T[2];
  pseudounitary_data := pseudounitary_sort(S,T,Simples);
  Simples := pseudounitary_data[1];
  S := pseudounitary_data[2];
  T := pseudounitary_data[3];
  FPdim := pseudounitary_data[4];
  FPdimC := pseudounitary_data[5];
  sorted_data := dimension_sort(S,T,Simples,FPdim);
  Simples := sorted_data[1];
  S := sorted_data[2];
  T := sorted_data[3];
  FPdim := sorted_data[4];
  N:=compute_fusion_rules(S,FPdimC);;
  return [Simples, S, T, N, FPdim, FPdimC];;
end);

#E DwG_data.gi . . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
