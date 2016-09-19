################################################################################
##
## PackageInfo.g for the package `GroupTheoretical'
## Authors: Paul Bruillard
##          Cesar Galindo
##          Siu-Hung Ng
##          Julia Plavnik
##          Eric Rowell
##          Zhenghan Wang
##
## (created from Frank Luebeck's PackageInfo.g template file)
##
## 
SetPackageInfo( rec (

## package name and banner subtitlte
PackageName := "GroupTheoretical",
Subtitle := "Twisted Double of a Finite Group",

## Version numbering scheme is <major>.<minor>[.<build>[.<revision>]]
## for build:
##   0 = alpha
##   1 = beta
##   2 = release candidate
##   3 = for (final) release
##
Version := "0.0.1.2",

## Date in format dd/mm/yyyy
##
Date := "19/09/2016",

PackageWWWHome := Concatenation("https://github.com/pnnl/",LowercaseString(~.PackageName),".git/"),

## archive url without extensions
##
## ArchiveURL := ~.PackageWWWHome,
## 
## all possible extneions, recognized formats are .tar.gz .tar.bz2, -win.zip
## ArchiveFormats:=".tar.gz .tar.bz2 -win.zip",

## Text and binary files so that GAP can produce archives
##
##TextFile:=["init.g","PackageInfo.g","configure","Makefile.ini","lib/DwG_data.g","lib/DwG_rank.g","lib/Projective_Representations.g"],
BinaryFiles:=["doc/manual.pdf"],

## author and maintainer information
Persons := [
  rec(
    LastName      := "Bruillard",
    FirstNames    := "Paul",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "paul.bruillard@pnnl.gov",
    WWWHome       := "N/A",
    PostalAddress := "N/A",
    Place         := "Richland, Washington, USA",
    Institution   := "Pacific Northwest National Laboratory"
  ),
  rec(
    LastName      := "Galindo",
    FirstNames    := "Cesar",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "cn.galindo1116@uniandes.edu.co",
    WWWHome       := "N/A",
    PostalAddress := "N/A",
    Place         := "Bogota, Columbia",
    Institution   := "Universidad de Los Andes"
  ),
  rec(
    LastName      := "Ng",
    FirstNames    := "Siu-Hung",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "rng@math.lsu.edu",
    WWWHome       := "math.lsu.edu/~rng/",
    PostalAddress := "N/A",
    Place         := "Baton Rouge, Louisiana",
    Institution   := "Louisiana State University"
  ),
  rec(
    LastName      := "Plavnik",
    FirstNames    := "Julia",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "juliap@math.tamu.edu",
    WWWHome       := "math.tamu.edu/~julia",
    PostalAddress := "N/A",
    Place         := "College Station, Texas, USA",
    Institution   := "Texas A&M University"
  ),
  rec(
    LastName      := "Rowell",
    FirstNames    := "Eric",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "rowell@math.tamu.edu",
    WWWHome       := "math.tamu.edu/~rowell/",
    PostalAddress := "N/A",
    Place         := "College Station, Texas, USA",
    Institution   := "Texas A&M University"
  ),
  rec(
    LastName      := "Wang",
    FirstNames    := "Zhenghan",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "zhenghwa@microsoft.com",
    WWWHome       := "stationq.ucsb.edu/~wang/",
    PostalAddress := "N/A",
    Place         := "Santa Barbara, California, USA",
    Institution   := "Microsoft Research Station Q"
  )
],

## Status information:
##  "accepted"  for successfully refereed packages
##  "submitted" for packages submitted for refereeing
##  "deposited" for packages for which the GAP developers have agreed to
##              distribute them with the core GAP system
##  "dev"       for development versions of packages
##  "other"     for all other packages
##
Status := "dev",

## provide the next two if and only if the status is accepted
## CommunicatedBy := "",
##
## format: mm/yyyy
## AccptedDate := "",

## readme and packageinfo must be provided via urls
README_URL := Concatenation(~.PackageWWWHome,"README"),
PackageInfoURL := Concatenation(~.PackageWWWHome,"PackageInfo.g"),

## provide a short abstract explaining the package content in HTML format and a
## URL of a webpage with more detailed information.
##
AbstractHTML := "This package provides a collection of functions for computing\
  alpha-projective representations of a finite group and the modular datum of a\
  the twisted double of a finite group.",

## Package documentation information
##
PackageDoc := rec(
  ## same name as in GAP
  BookName := "GroupTheoretical",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/main.html",
  PDFStart := "doc/output.pdf",
  # the path to the .six file used by GAPs help system
  SixFile := "doc/manual.six",
  # a longer title
  LongTitle := "GroupTheoretical GAP Package Documentation",
),

## Restrications and dependencies
##
Dependencies := rec(
  # GAP version
  GAP:=">=4.4",
  NeededOtherPackages := [["GAPDoc","1.5"],["HAP","1.11.13"]],
  SuggestedOtherPackages := [],
  OtherPackagesLoadedInAdvance:=[],
  ExternalConditions:=[]
),

## Provide a test function for the availability of this package (just say
## ReturnTrue if the package only includes GAP code).
AvailabilityTest := ReturnTrue,

## Banner String
BannerString := Concatenation(
  "--------------------------------------------------------------------------------\n",
  " Loading GroupTheoretical ", ~.Version, "\n",
  " by ",
  JoinStringsWithSeparator(List(Filtered(~.Persons,r->r.IsAuthor),r->Concatenation(" ",r.FirstNames,
  " ", r.LastName))),
  "\n",
  "For help, type ?GroupTheoretical \n",
  "--------------------------------------------------------------------------------\n"),

## relative path to the package root to a file which contains tests
TestFile := "tst/testall.tst",
Keywords := ["modular category", "ribbon category", "fusion category", "twisted double", "quantum double", "projective representation"]
));

