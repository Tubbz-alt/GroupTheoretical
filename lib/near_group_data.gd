################################################################################
##
#W TY_data.gd              DwG Package
##
#W Paul Bruillard, Cesar Galindo, Siu-Hung Ng, Julia Plavnik, Eric Rowell, 
#W Zhenghan Wang
##
## Installation file for TY_data functions of the DwG Package
##
#Y Copyright (C) 2016, Battelle Memorial Institute
##
################################################################################

################################################################################
##
#F near_group_data(<group>,<int>)
##
## <#GAPDoc Label="TY_data">
## <ManSection>
## <Func Name="TY_data" Arg="G, k"/>
##
## <Description>
## Computes WHAT for the near group category (G,k)
##
## <Example><![CData[gap>
## LoadPackage("DwG");
## G:=ElementaryAbelianGroup(4);
## k:=5;
## data:=near_group_data(G,k);
## </Example>
## </Description>
## </ManSection>
## <#/GAPDoc>
##
DeclareGlobalFunction("near_group_data");

################################################################################
##
#F TY_data(<group>,<function>,<function>,<list>,<int>)
##
## <#GAPDoc Label="TY_data">
## <ManSection>
## <Func Name="TY_data" Arg="G, chi, tau, delta, Tsign"/>
##
## <Description>
## Computes WHAT for TY(G,chi,nu)
## Is is **assumed** that chi is a symmetric nondegenerate bicharacter. i.e. a
## a symmetric root of unity matrix of size |G|x|G| indexed according to AsSet(G), and
## such that chi[g][h]!=1 unless g=e or h=e
##
## <Example><![CData[gap>
## LoadPackage("DwG");
## G:=ElementaryAbelianGroup(4);
## IrrG:=Irr(G);
## chi1:=IrrG[2];
## chi2:=IrrG[3];
## CC:=ConjugacyClasses(G);
## chi:=List(AsSet(G),g->List(AsSet(G),h->chi1[Position(CC,ConjugacyClass(G,g))]*chi2[Position(CC,ConjugacyClass(G,h))]*chi2[Position(CC,ConjugacyClass(G,g))]*chi1[Position(CC,ConjugacyClass(G,h))]));
## tau:=Sqrt(1/Order(G));
## # braiding
## delta:=List([1..Order(G)],x->1);
## Add(delta,-1);
## Tsign := 1;
## data:=TY_data(G,chi,tau,delta,Tsign);
## </Example>
## </Description>
## </ManSection>
## <#/GAPDoc>
##
DeclareGlobalFunction("TY_data");
#E TY_data.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . .ends here
