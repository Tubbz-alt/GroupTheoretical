################################################################################
##
#W DG_data.gd      DwG Package
##
#W Paul Bruillard, Cesar Galindo, Siu-Hung Ng, Julia Plavnik, Eric Rowell,
#W Zhenghan Wang
##
## Declaration file for functions in the DG_data portion of the DwG package
##
#Y Copyright (C) 2016, Battelle Memorial Institute
##
################################################################################

################################################################################
##
#F DG_S_and_T(<group>,<bool>)
##
## <#GAPDoc Label="DG_S_and_T">
## <ManSection>
## <Func Name="DG_S_and_T" Arg="G, display"/>
## 
## <Description>
## Computes Simples, S, T, FPdim(Xi), and FPdim(C) for D(G), the untwisted double of a finite group.
##
## <Example><![CDATA[gap>
## G:=SymmetricGroup(3);
## data:=DG_data(G);
## Simples:=data[1];
## S:=data[2];
## T:=data[3];
## FPdim:=data[4];
## FPdimC:=data[5];
## N:=compute_fusion_rules(S,FPdimC);
## </Example>
## </Description>
## </ManSection>
## <#/GAPDoc>
##
DeclareGlobalFunction("DG_S_and_T");

################################################################################
##
#F DG_data(<group>)
##
## <#GAPDoc Label="DG_data">
## <ManSection>
## <Func Name="DG_data" Arg="G"/>
## 
## <Description>
## Computes Simples, S, T, N, FPdim(Xi), and FPdim(C) for D(G), the untwisted double of a finite group.
##
## <Example><![CDATA[gap>
## G:=SymmetricGroup(3);
## data:=DG_data(G);
## Simples:=data[1];
## S:=data[2];
## T:=data[3];
## N:=data[4];
## FPdim:=data[5];
## FPdimC:=data[6];
## </Example>
## </Description>
## </ManSection>
## <#/GAPDoc>
##
DeclareGlobalFunction("DG_data");

#E DG_data.gd . . . . . . . . . . . . . . . . . . . . . . . . . . . . .ends here
