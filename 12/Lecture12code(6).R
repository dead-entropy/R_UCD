# Lecture 12 code
################################
# Linking R with other languages
################################
# for mac download xcode
# for windows you have to download Rtools
#########################################
# Version 1

# Fast R version
set.seed(10)
X <- rnorm(100)
Y <- sum(X)

# Slow loop version
Y <- 0
for(i in 1:length(X)) Y <- Y + X[i]

system("R CMD SHLIB findsums.c")

# C code version (in findsums.c)

dyn.load("findsums.so") # in Windows use dyn.load("findsums.dll")

find.sum <- function(Z) {
  lenZ <- length(Z)
  out <- 0
  ans <- .C("findsum", as.double(Z),
            as.double(out), as.integer(lenZ))
  return(ans[[2]])
}

set.seed(19)
X <- rnorm(10000)
sum(X)
find.sum(X)

dyn.unload("findsums.so") # in Windows use dyn.unload("findsums.dll")

# inline version
library(inline)
findsuminline <- '
int i;
for(i = 0;i < *N; i++) {
*out = *out + data[i];
}
'

find.sum2 <- cfunction(signature(out = 'numeric', data = 'numeric', N = 'numeric'),
                       findsuminline, language = 'C', convention = '.C')
find.sum2(0, X, length(X))[[1]]
find.sum2(0, X, length(X))$out

# Speed test

SumVersion <- function(X) return(sum(X))

LoopVersion <- function(X) {
  Y <- 0
  for(i in 1:length(X)) Y <- Y + X[i]
  return(Y)
}

InlineVersion <- function(X) return(find.sum2(0, X, length(X))$out)

library(rbenchmark)
benchmark(SumVersion(X), LoopVersion(X), InlineVersion(X))[1:5]


################################
# Write your own R package
################################

# install.packages("devtools")
# install.packages("roxygen2")
library(devtools)

# check the system is ready
has_devel()

# create the setup for a new package called myRpackage
create_package("myRpackage") # <----

# copy the file findruns.R in the R folder

file.copy("findruns.R", "./myRpackage/R/findruns.R")

## Document workflow

# - Modify R comment

# - Load the package with (Cmd/Ctrl + Shift + L)

devtools::load_all()

# - Update Rd files (Cmd/Ctrl + Shift + D)

devtools::document()

?findruns

# - Install package Install & Restart (Cmd/Ctrl + Shift + B)

devtools::build()

?findruns

# - Automated Checking

devtools::check()

# share the package
install.packages("myRpackage", repos = NULL, type = "source")
library(myRpackage)
?findruns

