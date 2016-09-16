# Given any finite group G this program calculates the 
# S and T matrices associated to the quantum double D(G).

qd := function(n1, n2)

local G, g, elmsG, R, r, tbl, chi, Phi, x, y, l, S, s, T;

G := SmallGroup(n1, n2);
elmsG := Elements(G);

Print("\nG = ", StructureDescription(G), "              ", IdGroup(G), "\n");

R := List(ConjugacyClasses(G), Representative);

Phi := [];

for r in R
 do
  tbl := CharacterTable(Centralizer(G, r));
  for chi in Irr(tbl)
   do
    Add(Phi, [r, chi, ConjugacyClasses(tbl)]);
   od;
 od;

S := [];

for x in Phi
 do
  l := [];
  for y in Phi
   do
    s := 0;
    for g in elmsG
     do
      if x[1]*g*y[1]*Inverse(g) = g*y[1]*Inverse(g)*x[1] then
       s := s + ComplexConjugate(x[2][Position(x[3], 
                ConjugacyClass(Centralizer(G, x[1]), g*y[1]*Inverse(g)))])
              * ComplexConjugate(y[2][Position(y[3], 
                ConjugacyClass(Centralizer(G, y[1]), Inverse(g)*x[1]*g))]);
      fi;
     od;

    s := s * (1/(Size(Centralizer(G, x[1])) * Size(Centralizer(G, y[1])))) * Size(G);

    Add(l, s);
#    Print(".\c");
   od;
  Add(S, l);
 od;

T := [];

for x in Phi
 do
  Add(T, x[2][Position(x[3], ConjugacyClass(Centralizer(G, x[1]), x[1]))]/x[2][1]);
 od;

Print("\n The S-matrix is: \n\n");
Display(S);

Print("\n\n The T-matrix is: \n\n");
Print(T);
Print("\n\n");




end;
