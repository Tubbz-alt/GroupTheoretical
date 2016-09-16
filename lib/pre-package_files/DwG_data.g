projective_reps := function(G,alpha,n) 
  local chi, chi_i, rho_i, Mi, g, x, rho, component_bases, Degrees, algebra_basis_vectors, algebra_basis, twisted_group_alg, dd, lst, i, j, k, h, GSet, T, F;

  F:=CF(n);;

  # cosntruct the twisted group algebra according to the multiplication rule:
  #  g*h=alpha(g,h)gh
  T:=EmptySCTable(Order(G),0);;
  GSet:=AsSet(G);;
  for i in [1..Order(G)] do
    g:=GSet[i];;
    for j in [1..Order(G)] do
      h:=GSet[j];;
      k:=Position(GSet,g*h);;
      # we need to convert alpha(g,h) from an abstract cyclic group element to a
      # complex, so we assign the generator of the cyclic group Z_s to E(s), a
      # primitive s-th root of unity
      #lst:=[E(s)^Position(OrderedA,alpha(g,h)),k];;
      lst:=[alpha(g,h),k];;
      SetEntrySCTable(T,i,j,lst);;
    od;;
  od;;
  twisted_group_alg:=AlgebraByStructureConstants(F,T);;

  # verify that the algebra is associative and then compute its decomposition
  Display(IsAssociative(twisted_group_alg));
  dd:=DirectSumDecomposition(twisted_group_alg);

  # compute a basis for the algebra and a basis for each of the decomposition
  # components
  algebra_basis:=Basis(twisted_group_alg);
  algebra_basis_vectors:=BasisVectors(algebra_basis);
  component_bases:=List(dd,Basis);
  Degrees:=List(List(component_bases, Size), Sqrt);# check whether the degrees are squares otherwise extends the field.

  # compute the represenations and characters
  rho:=[];
  chi:=[];
  for Mi in component_bases do
    # compute the representation corresponding to component Mi
    #
    # for each g (basis vector for the twisted group algebra) compute the matrix
    # rho_i(g)_{a,b} according to rho_i(g)(v_a) = Sum_{b}rho_i(g)_{a,b}v_b where
    # {v_{a}} is the basis Mi for the ith component.
    rho_i:=List(algebra_basis_vectors,g->List(Mi,x->Coefficients(Mi,g*x)));
    Append(rho,[rho_i]);
    # for each g, compute chi_i(g)=Tr(rho_i(g))/sqrt(dim of the ideal)
    chi_i:=List(rho_i,x->Trace(x))/Sqrt(Size(Mi));
    Append(chi,[chi_i]);
  od;
  return chi;
end;;

compute_simples:=function(G,n,w)
  local x,Zx,wx,CC,SimpleObjects,projective_characters;
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
end;;

compute_S_and_T:=function(Simples,G)
  local r,S,T,i,simple1,x,chi,Kx,betax,Zx,x_idx,Zx_Transversal,j,simple2,y,chi_prime,Ky,betay,Zy,Zy_Transversal,a,g,Zg,b,g_prime,h_prime,h,h_idx,h_prime_idx;

  r:=Length(Simples);
  S:=List([1..r],i->List([1..r],j->0));;
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
end;;

sort_S_and_T:=function(S,T,Simples)
  local FPdim,FPdimC,x;
  # should sort to move FPdimension to first row/col
  # IMPLEMENT THIS
  FPdim:=S[1];
  FPdimC:=Sum(List(FPdim,x->x^2));
  return [S,T,Simples,FPdimC,FPdim];
end;;

compute_fusion_rules:=function(S,FPdimC)
  local N,r,i,j,k,m;
  r:=Length(S[1]);
  N:=List([1..r],i->List([1..r],j->List([1..r],k->0)));
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
end;;



LoadPackage("HAP");
if(false) then
G:=SymmetricGroup(3);
H3G:=GroupHomology(G,3);
if Size(H3G)=0 then
  s:=2;
else
  s:=Lcm(H3G);
fi;
InitialA:=CyclicGroup(s);
a:=MinimalGeneratingSet(InitialA)[1];
OrderedA:=List([1..s],x->a^x);
A:=TrivialGModuleAsGOuterGroup(G,InitialA);
R:=ResolutionFiniteGroup(G,4);
C:=HomToGModule(R,A);
CH:=CohomologyModule(C,3);
H:=ActedGroup(CH);
classes:=Elements(H);
#c:=CH!.representativeCocycle(classes[1]);
c:=CH!.representativeCocycle(classes[3]);
abstract_w:=Mapping(c);
w:=function(x,y,z)
  return E(s)^(Position(OrderedA,abstract_w(x,y,z)));
end;;
n:=Exponent(G)*Exponent(H); # can replace exp(H) by order(alpha)
chi:=projective_reps(G,alpha,n);

Display("Computing simples");
Simples:=compute_simples(G,n,w);;

Display("Computing S and T");
S_and_T:=compute_S_and_T(Simples,G);
S:=S_and_T[1];
T:=S_and_T[2];

Display("Computing FP dimension");
S_and_T:=sort_S_and_T(S,T,Simples);
S:=S_and_T[1];
T:=S_and_T[2];
Simples:=S_and_T[3];
FPdimC:=S_and_T[4];
FPdim:=S_and_T[5];

Display("Computing fusion rules");
N:=compute_fusion_rules(S,FPdimC);
fi;

if (true) then

# create a group G, a finite cyclic group A, and a 2-cocycle alpha of G with
# coefficients in A. 

#G:=SymmetricGroup(3);;
#G:=DihedralGroup(12);;
G:=ElementaryAbelianGroup(4);;
H2G:=GroupHomology(G,2);
if Size(H2G)=0 then
  s:=2;
else 
  s:=Lcm(H2G);
fi;
InitialA:=CyclicGroup(s);
a:=MinimalGeneratingSet(InitialA)[1];
OrderedA:=List([1..s],x->a^x);
A:=TrivialGModuleAsGOuterGroup(G,InitialA);
R:=ResolutionFiniteGroup(G,3);
C:=HomToGModule(R,A);
CH:=CohomologyModule(C,2);
H:=ActedGroup(CH);
classes:=Elements(H);
#c:=CH!.representativeCocycle(classes[4]);
for class in classes do
c:=CH!.representativeCocycle(class);
alpha:=function(g,h) return E(s)^(Position(OrderedA,Mapping(c)(g,h))); end;;

# twisted group algebra always splits into matrix algebras over
# R=cylcotomicfield(Exponent(G)*Exponent(H))
n:=Exponent(G)*Exponent(H); # can replace exp(H) by order(alpha)

chi:=projective_reps(G,alpha,n);
Display("alpha-projectives");
Display(chi);
#Display("\nCharacter table");
#Display(CharacterTable(G));
od;
fi;
