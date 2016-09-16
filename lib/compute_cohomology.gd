################################################################################
##
#W compute_cohomology.gd      DwG Package
##
#W Paul Bruillard, Cesar Galindo, Siu-Hung Ng, Julia Plavnik, Eric Rowell,
#W Zhenghan Wang
##
## Declaration file for functions in the compute_cohomology
##   portion of the DwG package
##
#Y Copyright (C) 2016, Battelle Memorial Institute
##
################################################################################

################################################################################
##
#F get_cohomology(G,k)
##
## <#GAPDoc Label="get_cohomology">
## <ManSection>
## <Func Name="get_cohomology" Arg="G, k"/>
##
## <Description>
## Computes the H:=H^k(G,mu_s) where mu_s is the cyclic group of order s in U(1)
## and s = Lcm(GroupHomology(G,k)). Returns a pair (H,cocycles) where cocycles
## is a list of mu_s valued functions. Each function is a cocycle representative of
## a cohomology class in H.
##
## <Example><![CDATA[gap>
## LoadPackage("HAP");
## G:=SymmetricGroup(3);
## H_and_cocyles:=get_cohomology(G,3);
## H:=H_and_cocycles[1];
## cocycles:=H_and_cocycles[2];
## </Example>
## </Description>
## </ManSection>
## <#/GAPDoc>
##
DeclareGlobalFunction("get_cohomology");


#E compute_cohomology.gd . . . . . . . . . . . . . . . . . . . . . . . ends here
