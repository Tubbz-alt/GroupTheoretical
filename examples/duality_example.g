LoadPackage("HAP");
LoadPackage("GroupTheoretical");
G:=SymmetricGroup(3);
data:=DG_data(G);;
N:=data[4];;
duality:=get_duality(N);
Display(duality);
