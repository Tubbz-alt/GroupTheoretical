## This builds the documentation of the GroupTheoretical package
## Needs: GAPDoc package, latex, pdflatex, mkindex
##
LoadPackage("GAPDoc");
MakeGAPDocDoc("doc", # path to the directory containing the main file
              "main", # the name of the main file (without extension)
                      #
                      # list including relative path to source files
                      # containing pieces of documentation
              ["../PackageInfo.g","../lib/DwG_data.gd","../lib/DwG_rank.gd","../lib/Projective_Represenations.gd","../lib/symmetric_data.gd","../lib/DG_data.gd","../lib/verlinde.gd","../lib/compute_cohomology.gd","../lib/pseudounitary_sort.gd","../lib/pointed_data.gd","../lib/near_group_data.gd","../lib/get_duality.gd"],
              "GroupTheoretical",  # name of the book used by GAPs online help
              "../../../", # relative path to GAP root
              "MathJax",   # use MathJax as needed in HTML
              );;

## copy the *.css and *.js files from the styles directory of GAPDoc into the
## directory containing the manual
CopyHTMLStyleFiles("doc");

## Create the manual.lab file which is needed if the main manuals or another
## package is referring to your package
GAPDocManualLab("GroupTheoretical");;
