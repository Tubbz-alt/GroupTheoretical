################################################################################
##
#W symmetric_data.gd              GroupTheoretical Package
##
#W Paul Bruillard, Cesar Galindo, Siu-Hung Ng, Julia Plavnik, Eric Rowell, 
#W Zhenghan Wang
##
## Installation file for symmetric_data functions of the GroupTheoretical Package
##
#Y Copyright (C) 2016, Battelle Memorial Institute
##
################################################################################


################################################################################
##
#F symmetric_data(<group>,<group element>)
##
## <#GAPDoc Label="symmetric_data">
## <ManSection>
## <Func Name="symmetric_data" Arg="G, z"/>
##
## <Description>
## Computes S, T, FPdim, FPdimC, and N for Rep(G,z) where z is a central
## of order at most 2 (for z=e the Tannakian category Rep(G) is computed).
## Here z should be a central element of order at most 2 in G.
##
## <Example><![CData[gap>
## LoadPackage("GroupTheoretical");
## G:=CyclicGroup(2);
## Z2_data:=symmetric_data(G,AsSet(G)[1]);
## sVec_data:=symmetric_data(G,AsSet(G)[2]);
## </Example>
## </Description>
## </ManSection>
## <#/GAPDoc>
##
DeclareGlobalFunction("symmetric_data");
#E symmetric_data.gd  . . . . . . . . . . . . . . . . . . . . . . . . ends here
