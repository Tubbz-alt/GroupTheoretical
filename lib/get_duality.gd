################################################################################
##
#W get_duality.gd      DwG Package
##
#W Paul Bruillard, Cesar Galindo, Siu-Hung Ng, Julia Plavnik, Eric Rowell,
#W Zhenghan Wang
##
## Declaration file for functions in the get_duality
##   portion of the DwG package
##
#Y Copyright (C) 2016, Battelle Memorial Institute
##
################################################################################

################################################################################
##
#F get_cohomology(G,k)
##
## <#GAPDoc Label="get_duality">
## <ManSection>
## <Func Name="get_duality" Arg="N"/>
##
## <Description>
## From the fusion matrices, N, a list of dual pairs are returned.
##
## <Example><![CDATA[gap>
## LoadPackage("HAP");
## G:=SymmetricGroup(3);
## data:=DG_data(G);
## N:=data[4];
## duality:=get_duality(N);
## </Example>
## </Description>
## </ManSection>
## <#/GAPDoc>
##
DeclareGlobalFunction("get_duality");


#E get_duality.gd . . . . . . . . . . . . . . . . . . . . . . . ends here
