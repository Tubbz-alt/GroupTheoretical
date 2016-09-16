################################################################################
##
#W DwG_rank.gd      DwG Package
##
#W Paul Bruillard, Cesar Galindo, Siu-Hung Ng, Julia Plavnik, Eric Rowell,
#W Zhenghan Wang
##
## Declaration file for functions in the DwG_rank portion of the DwG package
##
#Y Copyright (C) 2016, Battelle Memorial Institute
##
################################################################################


################################################################################
##
#F DwG_rank(<group>,<int>,<function)
##
## <#GAPDoc Label="DwG_rank">
## <ManSection>
## <Func Name="DwG_rank" Arg="G, display"/>
## 
## <Description>
## Compute the rank of D^w(G) for all w\in H^3(G,A) where A is a cyclic group of
## order Lcm(HomologyGroup(G,3)). A list of pairs is returned where the first
## element of tha pair is the cohomology class of w and the second is the rank.
## display is a boolean value indicating if information about the rank and the
## cohomology class of w are output to the screen as they are comptued.
##
## <Example><![CDATA[gap>
## LoadPackage("HAP");
## G:=SymmetricGroup(3);
## Display(DwG_rank(G,true));
## </Example>
## </Description>
## </ManSection>
## <#/GAPDoc>
##
DeclareGlobalFunction("DwG_rank");

#E DwG_rank.gd . . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
