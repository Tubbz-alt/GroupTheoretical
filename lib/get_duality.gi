################################################################################
##
#W get_duality.gi              DwG Package
##
#W Paul Bruillard, Cesar Galindo, Siu-Hung Ng, Julia Plavnik, Eric Rowell, 
#W Zhenghan Wang
##
## Installation file for get_duality functions of the DwG Package
##
#Y Copyright (C) 2016, Battelle Memorial Institute
##
################################################################################

################################################################################
##
#F get_duality(<list>). . . . a helper function for computing duality
##
InstallGlobalFunction(get_duality, function(N)
  local dual_pairs, unpaired, x, x_dual,r;
  r:=Size(N);
  unpaired:=[1..r];
  while Size(unpaired) > 0 do
    x:=Remove(unpaired,1);
    Display(x);
    if Size(unpaired) > 0 then
      for x_dual in unpaired do
        if N[x][x_dual][1] = 1 then
          break;
        fi;
      od;
    else
      x_dual := x;
    fi;
    if N[x][x_dual][1] <> 1 then
      Error("corrupt fusion matrices.");
    fi;
    Add(dual_pairs,[x,x_dual]);
  od;
  return dual_pairs;
end);

#E get_duality.gi . . . . . . . . . . . . . . . . . . . . . . . ends here
