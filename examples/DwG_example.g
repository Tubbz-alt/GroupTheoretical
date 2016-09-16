LoadPackage("HAP");
LoadPackage("DwG");
G:=SymmetricGroup(3);
H_and_cocycles:=get_cohomology(G,3);
H:=H_and_cocycles[1];
cocycles:=H_and_cocycles[2];
n:=Exponent(G)*Exponent(H);

w:=cocycles[1];
untwisted_data:=DwG_data(G,w,n);
untwisted_Simples:=untwisted_data[1];
untwisted_S:=untwisted_data[2];
untwisted_T:=untwisted_data[3];
untwisted_N:=untwisted_data[4];
untwisted_FPdim:=untwisted_data[5];
untwisted_FPdimC:=untwisted_data[6];

w:=cocycles[3];
twisted_data:=DwG_data(G,w,n);
twisted_Simples:=twisted_data[1];
twisted_S:=twisted_data[2];
twisted_T:=twisted_data[3];
twisted_N:=twisted_data[4];
twisted_FPdim:=twisted_data[5];
twisted_FPdimC:=twisted_data[6];

Print("\n------------------------------------------------------------\n\n");
Print("D(G) data computed using DwG_data\n");
Print("FPdim(C) ", untwisted_FPdimC, "\n");
Print("FPdim ", untwisted_FPdim, "\n");
Print("S \n");
Display(untwisted_S);
Print("T \n");
Display(untwisted_T);
#display_fusion_rules(untwisted_N);

Print("\n------------------------------------------------------------\n\n");
Print("D^{w}(G) data computed using DwG_data\n");
Print("FPdim(C) ", twisted_FPdimC, "\n");
Print("FPdim ", twisted_FPdim, "\n");
Print("S \n");
Display(twisted_S);
Print("T \n");
Display(twisted_T);
#display_fusion_rules(twisted_N);
Print("\n------------------------------------------------------------\n\n");
