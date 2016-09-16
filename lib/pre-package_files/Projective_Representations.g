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
