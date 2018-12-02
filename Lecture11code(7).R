# Lecture 11 code

rm(list=ls())

# Calculate timing of some functions.
# Version 1
fun1 <- function(x, y) z <- x + y
# Version 2
fun2 <- function(x, y) {
  z <- vector(length = length(x))
  for(i in 1:length(x)) z[i] <- x[i] + y[i]
}
x <- y <- 1:1000000

# Check the speeds
system.time(fun1(x, y))
system.time(fun2(x, y))

# Compare the speeds using benckmark
library(rbenchmark)
benchmark(fun1(x, y), fun2(x, y), replications = 10)

################################
## SNAP!

# Version 1
snap1 <- function(numhands) {
  snaptimes <- vector(length = numhands)
  for(i in 1:numhands) {
    p1hand <- sample(cards)
    p2hand <- sample(cards)
    snaptimes[i] <- which(p1hand - p2hand == 0)[1]
  }
  table(snaptimes, useNA = 'always')
}

# Version 2

snap2 <- function(numhands) {
  snap <- function(handdiff) which(handdiff == 0)[1]
  bighand1 <- apply(matrix(rep(cards, numhands), 52, numhands), 2, sample)
  bighand2 <- apply(matrix(rep(cards, numhands), 52, numhands), 2, sample)
  snaptimes2 <- apply(bighand1 - bighand2, 2, snap)
  table(snaptimes2, useNA = 'always')
}

# Create the pack of cards
cards <- 1:52
# Check timings
benchmark(snap1(10000), snap2(10000), replications = 10, 
  columns = c("test", "replications", "elapsed", "relative", 
    "user.self", "sys.self"))

# snap2 is slower! But it uses apply?

# What happened? - Let's look at finding the the mean of a vector
n <- 100000
M <- matrix(rnorm(n*2), ncol = n, nrow = 2)

v <- vector(length = n)
f1 <- function(){
  for(i in 1:ncol(M)) v[i] <- mean(M[,i])
  return(v)
}

f2 <- function() apply(M, 2, 'mean') 

f3 <- function() colMeans(M)
# Check timings
benchmark(f1(), f2(), f3(), replications = 10, 
  columns = c("test", "replications", "elapsed", "relative", 
    "user.self", "sys.self")) 

# f1 and f2 takes almost the same time to run
# f3 is way faster

# Generating powers of a matrix

# Version 1
powers1 <- function(x, deg) {
  pw <- matrix(x, nrow = length(x))
  prod <- x
  for(i in 2:deg) {
    prod <- prod * x
    pw <- cbind(pw, prod)
  }
  return(pw) 
}

# Version 2
powers2 <- function(x, deg) {
  pw <- matrix(nrow = length(x), ncol = deg)
  prod <- x
  pw[,1] <- prod
  for(i in 2:deg) {
    prod <- prod * x
    pw[,i] <- prod
  }
  return(pw) 
}

# Version 3

powers3 <- function(x, deg) {
  Xmat <- sweep(matrix(rep(x, deg), ncol = deg, nrow = length(x)), 2, 1:deg, '^')
}

x <- runif(1000000)
benchmark(powers1(x, 8), powers2(x, 8), powers3(x, 8), replications = 10)

# powers1 is Slow
# powers2 is Fast
# powers3 is Slow
###############################################################
###############################################################

# Memory issues

z <- 1:3
z[3] <- 8

z <- '[<-'(z, 3, 8)

# Tracing memory
y <- z

tracemem(z)
untracemem(z)
tracemem(y)
y[1] <- 2
tracemem(z)
tracemem(y) # It's moved 
untracemem(y)

# Profiling
Rprof()
invisible(powers1(x, 8))
Rprof(NULL)
summaryRprof()

# Profile powers2
Rprof()
invisible(powers2(x, 8))
Rprof(NULL)
summaryRprof()

# Profile powers3
Rprof()
invisible(powers3(x, 8))
Rprof(NULL)
summaryRprof()

################################

# Parallel processing

rm(list=ls())

# Find the number of cores
library(parallel)
detectCores()

# Create a big matrix
n <- 5000000 # Number of rows
m <- 5 # Number of columns
M <- matrix(rnorm(n * m), nrow = n, ncol = m) 
mycolsum <- function(i) {
  return(sum(M[,i]))
}

# A simple way of finding the average of the column sums
try1 <- sum(sapply(1:m, mycolsum)) / m
try1

# Find the average of the column sums using foreach 
library(doParallel)
registerDoParallel(cores = 2)
library(foreach)
try2 <- sum(unlist(foreach(j = 1:m) %dopar% mycolsum(j))) / m
try2

# Find the column sums using parallel
try3 <- sum(unlist(mclapply(1:m, mycolsum, mc.cores = 2))) / m
try3

# Now do it using snow
library(snow)
cl <- makeCluster(type = 'SOCK', rep('localhost', 2))
num.cores <- length(cl)
mycolsum2 <- function(i, M) {
  return(sum(M[,i]))
}
chunks <- split(1:m, 1:num.cores)
try4 <- sum(unlist(clusterApply(cl, chunks, mycolsum2, M))) / m

# Create functions for each method
ftry1 <- function(m) sum(sapply(1:m, mycolsum)) / m
ftry2 <- function(m) sum(unlist(foreach(j = 1:m) %dopar% mycolsum(j))) / m
ftry3 <- function(m) sum(unlist(mclapply(1:m, mycolsum, mc.cores = 2))) / m
ftry4 <- function(m) sum(unlist(clusterApply(cl, chunks, mycolsum2, M))) / m

# Compare the times
benchmark(ftry1(m), ftry2(m), ftry3(m), ftry4(m), replications = 3)

