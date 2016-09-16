################################################################################
##
#W pointed_data.gd              DwG Package
##
#W Paul Bruillard, Cesar Galindo, Siu-Hung Ng, Julia Plavnik, Eric Rowell, 
#W Zhenghan Wang
##
## Installation file for pointed_data functions of the DwG Package
##
#Y Copyright (C) 2016, Battelle Memorial Institute
##
################################################################################


################################################################################
##
#F pointed_data(<group>,<function>)
##
## <#GAPDoc Label="pointed_data">
## <ManSection>
## <Func Name="pointed_data" Arg="G, b"/>
##
## <Description>
## Computes the data for the premodular category (G,q,chi) where G is a finite
## abelian group q is a quadratic form, and chi is a character of G such that
## chi^2=1. In this case, by DGNO we define the bicharacter
## b(g,h)=q(gh)/(q(g)*q(h)). Then T[g] = q(g)*chi(g), S[g][h] = b(g,h)*chi(g)*chi(h)
##
## <Example><![CData[gap>
## LoadPackage("DwG");
## G:=ElementaryAbelianGroup(4);
## WHERE TO GET QUADRATIC FORM?
## chi:=Irr(G)[1];
## data:=pointed_data(G,q,chi);
## </Example>
## </Description>
## </ManSection>
## <#/GAPDoc>
##
DeclareGlobalFunction("pointed_data");
#E pointed_data.gd  . . . . . . . . . . . . . . . . . . . . . . . . ends here
