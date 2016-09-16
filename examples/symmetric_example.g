LoadPackage("HAP");
LoadPackage("GroupTheoretical");
G:=CyclicGroup(2);
Z2_data:=symmetric_data(G,AsSet(G)[1]);
sVec_data:=symmetric_data(G,AsSet(G)[2]);

Z2_S:=Z2_data[2];
Z2_T:=Z2_data[3];
Z2_N:=Z2_data[4];
Z2_FPdim:=Z2_data[5];
Z2_FPdimC:=Z2_data[6];

Print("\n--------------------------------------------------\n\n");
Display("Rep(Z/2Z) data:");
Print("FPdim(C) = ", Z2_FPdimC,"\n");
Print("FPdim(X_i) = ", Z2_FPdim,"\n");
Print("S = \n");
Display(Z2_S);
Print("T = ",Z2_T,"\n");
display_fusion_rules(Z2_N);
Print("\n--------------------------------------------------\n\n");

sVec_S:=sVec_data[2];
sVec_T:=sVec_data[3];
sVec_N:=sVec_data[4];
sVec_FPdim:=sVec_data[5];
sVec_FPdimC:=sVec_data[6];

Display("sVec data:");
Print("FPdim(C) = ", sVec_FPdimC,"\n");
Print("FPdim(X_i) = ", sVec_FPdim,"\n");
Print("S = \n");
Display(sVec_S);
Print("T = ",sVec_T,"\n");
display_fusion_rules(sVec_N);
Print("\n--------------------------------------------------\n");
