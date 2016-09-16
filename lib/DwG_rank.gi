################################################################################
##
#W DwG_rank.gi              GroupTheoretical Package
##
#W Paul Bruillard, Cesar Galindo, Siu-Hung Ng, Julia Plavnik, Eric Rowell, 
#W Zhenghan Wang
##
## Installation file for DwG_rank functions of the GroupTheoretical Package
##
#Y Copyright (C) 2016, Battelle Memorial Institute
##
################################################################################


###############################################################################
##
#F DwG_rank(<group>,<bool>). . . . . . . .compute rank of D^w(G)
##
InstallGlobalFunction(DwG_rank, function(G,display)
  local A,R,C,CH,H,classes,cs,fs,CC,Counter,f,DwG_rank,x,Zx,ZxReps,alpha_regular,g,is_alpha_regular,Zg_in_Zx,h,alpha_g_h,alpha_h_g,DwG_ranks,last_rank,H3G;

  # compute H_3(G,Z)
  H3G:=GroupHomology(G,3);;
  A:=CyclicGroup(Lcm(H3G));;
  #A:=CyclicGroup(Order(G));
  A:=TrivialGModuleAsGOuterGroup(G,A);;
  R:=ResolutionFiniteGroup(G,4);;
  C:=HomToGModule(R,A);;
  CH:=CohomologyModule(C,3);;
  H:=ActedGroup(CH);
  classes:=Elements(ActedGroup(CH));;
  Print(Length(classes));;
  Print("\n Cohomology group:");;
  Print(StructureDescription(H));;
  Print("\n");

  # get the 3-cocycle rerpresenting the second cohomology classes
  cs:=List(classes,x->CH!.representativeCocycle(x));

  # get a cocycle f:GxGxG->A corresponding to this cohomology class
  fs:=List(cs,x->Mapping(x));

  # get group conjugacy class represenatives
  CC:=List(ConjugacyClasses(G),Representative);;

  # for each cocycle f and each conjugacy class x compute alpha the 2-cocycle on
  # the centralizer
  Counter:=0;
  DwG_ranks:=[];
  for f in fs
  do
    Counter:=Counter+1;
    DwG_rank:=0;
    for x in CC
    do
      # compute the centralizer of X
      Zx:=Centralizer(G,x);;
      ZxReps:=List(ConjugacyClasses(Zx),Representative); # compute the alpha-regular elements of Zx
      alpha_regular:=[];;
      for g in ZxReps
      do
        is_alpha_regular:=true;;
        Zg_in_Zx:=Centralizer(Zx,g);
        for h in Zg_in_Zx
        do
          alpha_g_h:=f(g,h,x)*f(x,g,h)*(f(g,x,h)^-1);;
          alpha_h_g:=f(h,g,x)*f(x,h,g)*(f(h,x,g)^-1);;
          if not(alpha_g_h=alpha_h_g) then
            is_alpha_regular:=false;;
            break;;
          fi;
        od;
        if is_alpha_regular=true then
          Append(alpha_regular,[g]);
          DwG_rank:=DwG_rank+1;
        fi;
      od;
    od;
    if display then
      Print("\nThe cohomology class is: ");
      Print(classes[Counter]);
      Print("\nRank is: ");
      Print(DwG_rank);
    else
      Print(".");
    fi;
    Append(DwG_ranks,[[classes[Counter],DwG_rank]]);
    if Counter=1 then
      last_rank:=DwG_rank;
    fi;
  od;
  Print("\n");

  return DwG_ranks;;
end);

#E DwG_rank.gi . . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
