LoadPackage("HAP");
LoadPackage("DwG");
G:=ElementaryAbelianGroup(4);
IrrG:=Irr(G);
chi1:=IrrG[2];
chi2:=IrrG[3];
CC:=ConjugacyClasses(G);
chi:=List(AsSet(G),g->List(AsSet(G),h->chi1[Position(CC,ConjugacyClass(G,g))]*chi2[Position(CC,ConjugacyClass(G,h))]*chi2[Position(CC,ConjugacyClass(G,g))]*chi1[Position(CC,ConjugacyClass(G,h))]));
tau:=Sqrt(1/Order(G));
# braiding
delta:=List([1..Order(G)],x->1);
Add(delta,-1);
Tsign := 1;
data:=TY_data(G,chi,tau,delta,Tsign);
Simples:=data[1];
S:=data[2];
T:=data[3];
N:=data[4];
FPdim:=data[5];
FPdimC:=data[6];

Print("\n------------------------------------------------------------\n\n");
Print("D(G) data computed using DwG_data\n");
Print("FPdim(C) ", FPdimC, "\n");
Print("FPdim ", FPdim, "\n");
Print("S \n");
Display(S);
Print("T \n");
Display(T);
#display_fusion_rules(N);
Print("\n------------------------------------------------------------\n\n");

