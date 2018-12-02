# Lecture 10 

rm(list=ls())

# antibugging
x <- 5
if(length(x) != 3) stop("x is supposed to be of length 3!")
stopifnot(x < 0)

?browser
########################################
# A wrong example
# Consider the likelihood function for lecture 6 - there's a stupid mistake in this somewhere? How can I find it?

neglikfun <- function(parameters) {
  beta0 <- parameters[1]
  beta1 <- parameters[2]
  daty0 <- y == 0
  daty1 <- y == 1
  loglikelihood <- sum(log(1 / (1 + exp(-beta0 - beta1*x[daty1])))) + 
    sum(log( - (1 / (1 + exp(-beta0 - beta1*x[daty0])))))
    return(-loglikelihood)
}

neglikfun(c(1, -0,1))

# use the birthwt data to test the function
library(MASS) 
data(birthwt)
x <- birthwt$age
y <- birthwt$low

neglikfun(c(1,-0.1)) # Not working!

# Let's try adding a browser into it

neglikfun2 <- function(parameters) {
  browser() # function browser
  beta0 <- parameters[1]
  beta1 <- parameters[2]
  daty0 <- y == 0
  daty1 <- y == 1
  loglikelihood <- sum(log(1 / (1 + exp(-beta0 - beta1*x[daty1])))) +
    sum(log( - (1 / (1 + exp(-beta0 - beta1*x[daty0])))))
    return(-loglikelihood)
}

neglikfun2(c(1,-0.1))

neglikfun2 <- function(parameters) {
  beta0 <- parameters[1]
  beta1 <- parameters[2]
  daty0 <- y == 0
  daty1 <- y == 1
  loglikelihood <- sum(log(1 / (1 + exp(-beta0 - beta1*x[daty1])))) +
    sum(log(1 - (1 / (1 + exp(-beta0 - beta1*x[daty0])))))
  return(-loglikelihood)
}

# Use of debug
debug(neglikfun) # run the function in browser mode
neglikfun(c(1,-0.1))
undebug(neglikfun) # run the function normally

# Use of debugonce
debugonce(neglikfun)
neglikfun(c(1,-0.1))

########################################

# Use of trace
trace(neglikfun, browser)
neglikfun(c(1,-0.1))
untrace(neglikfun)

########################################
# set working directory as first step!!

rm(list=ls())

# Debugging example

source('findruns.R')

# Does it work?
y <- c(1, 0, 0, 1, 1, 1, 0, 1, 1)
findruns(y, 2)
# No!

# Let's try debug
debug(findruns)
findruns(y, 2)

# Fixed it to produce findruns2
source('findruns2.R')
findruns(y,2)

# Set a breakpoint
setBreakpoint('findruns2.R', 5)
findruns(y, 2)
# It should be 4 5 8 but is giving just 4 and 5 

# Let's set a conditional breakpoint when i = 8
source('findruns3.R')
findruns(y, 2)
# Didn't call browser?

# Finally fixed
source('findruns4.R')
findruns(y, 2)

