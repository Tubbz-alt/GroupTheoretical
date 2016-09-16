LoadPackage("HAP");
LoadPackage("GroupTheoretical");
G:=ElementaryAbelianGroup(4);
q:=function(g) return 1; end;
chi:=Irr(G)[1];
data:=pointed_data(G,q,chi);

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

