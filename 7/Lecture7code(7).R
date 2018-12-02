# R code for lecture 7

# Some examples of various maths functions
exp(1) # The value of e
log(10) # Natural log
log(2.718282)
log10(10) # Log to base 10
log(10, base = 2) # Choosing the base
log(8, base=2)
sqrt(64) # Square root
abs(c(-5, 2)) # Absolute value
sin(pi/2) # Sin, cos, etc
cos(pi/2)
asin(0)
min(1:5) # min and max (pmin and pmax later)
max(1:5)
sum(1:10) # Sum and product
prod(1:10)  # effectively same as factorial 10!
cumsum(1:10) # Cumulative sum and product
cumprod(1:10)
round(3.21) # Round to nearest integer
floor(3.21) # Round to lowest nearest integer
ceiling(3.21) # Round to highest nearest integer
signif(12332, digits = 3) # Rounds to specified number of significant digits

# Look at difference between min, max and pmin and pmax
z <- matrix(c(1, 5, 6, 2, 3, 2), nrow = 3, ncol = 2)
z
min(z)
z1 <- z[, 1]
z1
z2 <- z[, 2]
z2
min(z1, z2)
pmin(z1, z2)
?pmin

# Calculus
D(expression(exp(x^2)), 'x') # derivative
# to do second derivative use D function within D function (HOW???)
integrate(function(x) x^2, 0, 1)

?D
?integrate

# Plot the pdf (probability density function) of a standard normal distribution

# Slow way
x <- seq(-4, 4, length = 100)
x
plot(x, dnorm(x), type = 'l')

?dnorm

# Add in a 1000 simulations
lines(density(rnorm(1000)), col = 'red')
?density

# Plot the cdf
plot(x, pnorm(x), type = 'l')


# Now the quick way
curve(dnorm, from = -4, to = 4)
curve(pnorm, from = -4, to = 4)
curve(qnorm, from = 0, to = 1)
?curve

# Look at help files for individual distributions
?dt
?qnorm
?rf

# Sorting
x <- c(5, 13, 12, 5)
sort(x)
order(x) # 1st item is 1st in order, 2nd item is (13) is 4th in order etc
rank(x) # ranks elements, for example here the second element
        # 13 is the fourth from the bottom so it was marked as 4
        # repeated values are replaced by their mean (5+5)/2

?order
?rank

# Sorting a matrix
d <- data.frame(kids = c('Jack', 'Jill', 'Billy'), ages = c(12, 10, 13))
d[order(d$kids),]
d[order(d$ages),]
d[sort(d$kids),]  # doesn't work with sort!!!!

# Set operations
x <- 1:5
y <- 4:8
union(x, y) # Creates the union set of x and y
intersect(x, y) # Creates the intersection of x and y
setdiff(x, y) # Creates the set of all objects in x that are not in y
setdiff(y, x) 
setequal(x, y) # Determines if x and y are equal
4 %in% y # Tests whether 4 is an element of y


####################################

# Linear algebra
A <- matrix(c(1, -1, 1, 1), 2, 2) 
A
b <- c(2, 4)
b
x <- solve(A, b)
x
?solve
# Check that Ax=b
A %*% x
# Slower version is:
x2 <- solve(A) %*% b # multiplying by A inverse, gives same result
# x = A^-1 * b
x2

# get inverse of matrix
solve(A)

# QR decomposition
M <- matrix(c(4, 1, 2, 3), 2, 2)
M
?qr
qrM <- qr(M)
qrM
Q <- qr.Q(qrM)
?qr.Q
Q
R <- qr.R(qrM)
R
# Check that it works
Q %*% R

det(M) # finds determinant 

# Cholesky decomposition - needs to be a symmetric matrix
M2 <- matrix(c(3, 1, 1, 3), 2, 2)
M2
U <- chol(M2) # upper triangular matrix
U
# check it works
t(U) %*% U

# Eigen decomposition
eigenM2 <- eigen(M2)
eigenM2
D <- diag(eigenM2$values)
D
V <- eigenM2$vectors
V
# check it works
V %*% D %*% solve(V) # here solve() gives the inverse

# Use of diag 
M <- matrix(1:9, 3, 3)
M
diag(M)

diag(M) <- 7
M

M <- diag(c(3, 1))
M

N <- diag(c(3, 1, -3))
N

# use of parenthesis to speed up calculations
n <- 2500
m <- 10
A <- matrix(n * n, nrow = n, ncol = n) 
B <- matrix(n * n, nrow = n, ncol = n) 
C <- matrix(n * m, nrow = n, ncol = m)
C # is huge
system.time(A %*% B %*% C)
system.time(A %*% (B %*% C))


# Use of sweep - use the swiss data on fertility
?sweep
help(swiss)
head(swiss) # Swiss Fertility and Socioeconomic Indicators (1888) Data

# centre the variables around their mean:
mean.swiss <- apply(swiss, 2, mean) # calculate the column means. Same as colMeans(swiss)
mean.swiss
str(mean.swiss)
head(swiss)
swiss.mean0 <- sweep(swiss, 2, mean.swiss)
head(swiss.mean0, 3)
swiss.mean1 <- sweep(swiss, 2, mean())

# standardise the variables z = (x - mean) / sd
sd.swiss <- apply(swiss, 2, sd) # # calculate the column standard deviations
swiss.standardised <- sweep(sweep(swiss, 2, mean.swiss), 2, sd.swiss, "/") 
head(swiss.standardised, 3)

# 3/3 matrix, we add 1 to row 1, 4 to row 2, 7 to row 3:
m <- matrix(1:9, 3, 3, byrow= TRUE)
m
sweep(m, 1, c(1,4,7), '+')

####################################

# Statistics

# Correlation
cor(swiss[,1:3])
# Better to round it
round(cor(swiss), 3) # Strongest correlation between Education and Examination (unsurprisingly)
# Another version
cor(swiss, method = "spearman")
# And a test
cor.test(swiss[,1], swiss[,2]) # p-value small - highly significant correlation between fertility and agriculture

# t-tests - use sleep data
?sleep
head(sleep)
str(sleep)
t.test(extra ~ group, data = sleep, paired = TRUE)
# 2 vectors (can be different lengths) where you want to test whether
# or not they have the same mean

# Do a 1-sample t-test on fake data
x <- rnorm(100, mean = 30, sd = 1)
x
t.test(x, mu = 30) # Shouldn't reject this

# Do a 2-sample t-test on fake data
x <- rnorm(100, mean = 30, sd = 1)
y <- rnorm(150, mean = 32, sd = 1)
t.test(x, y) # Should reject this given enough data

# Linear regression
mod <- lm(Fertility ~ ., data = swiss)
# here y=fertility, x=all other variables (dot)
summary(mod)

# Probabiliy of getting at least 4 heads from 5 tosses of a coin
# Exact value
1 - pbinom(3, 5, 0.5) # Pr(X >= 4) = 1 - Pr(X <= 3)
?pbinom
# alternatively, we can ask R for probabilility 
# that success is strictly greater than 3:
pbinom(3, 5, 0.5, lower.tail = FALSE) # same result as above

# prob of getting exactly 4:
prob <- pbinom(4, 5, 0.5) - pbinom(3, 5, 0.5)
prob

# Use simulations
large <- 100000
x <- rbinom(large, 5, 0.5) # simulating random values
mean(x >= 4)
x
mean(x)

# Expected value of the maximum of two N(0,1) variables
nreps <- 100000
sum <- 0
for(i in 1:nreps) {
  xy <- rnorm(2)
  sum <- sum + max(xy)
  } 
print(sum / nreps) # About 0.56

# Better version without a loop
x <- rnorm(nreps)
head(x)
y <- rnorm(nreps)
head(y)
maxxy <- pmax(x, y)
head(maxxy)
mean(maxxy) # Again about 0.56 - and way faster

# plot the pdf of standard normal distribution

# slow way:
x <- seq(-4,4, length = 100)
?plot
plot(x, dnorm(x), type = 'l')
dnorm(x) # this gives probability density evaluations at each point
dnorm(1)  #?????
pnorm(0)  # this is the TABLE!
pnorm(1.70)
pnorm(1.70, lower.tail = FALSE)
qnorm(0.98956)

set.seed(3000)
xseq<-seq(-4,4,.01)
densities<-dnorm(xseq, 0,1)
densities
cumulative<-pnorm(xseq, 0, 1)
cumulative
randomdeviates<-rnorm(1000,0,1)

help(Distributions)

# repeat plot
x <- seq(-4,4, length = 100)
plot(x, dnorm(x), type = 'l')

# add in a 1000 simulations
lines(density(rnorm(100)), col= 'blue')
lines(density(rnorm(1000)), col= 'red')
lines(density(rnorm(100000)), col= 'green')
?density

# plot the cdf 
plot(x, pnorm(x), type = 'l')
abline(h= 0.5, col = 'red')
abline(v= 0, col = 'red')

# now the quick way:
curve(dnorm, from = -4, to = 4)
curve(pnorm, from = -4, to = 4)
curve(qnorm, from = 0, to = 1)  #range is probabilties
# last curve y axis shows value of quantiles
# so at 0.5 prop, we get quantile value of 0 which is the mean
# (50th quantiles)

?curve

# other distributions:
?dt
?rf

####################################

# Snap!

# Let's first number the cards
cards <- 1:52

# A snap occurs the first time when both players draw the same card
# Let's draw some hands
p1hand <- sample(cards)
p2hand <- sample(cards)
p1hand
?sample

# Find out when they both intersect
print(snaptime <- which((p1hand - p2hand == 0) == TRUE)[1])
print(snaptime <- which((p2hand - p1hand == 0) == TRUE)[1])

# Now let's try working out the value with a loop
numhands <- 1000
snaptimes <- vector(length = numhands)
for(i in 1:numhands) {
  p1hand <- sample(cards)
  p2hand <- sample(cards)  
  snaptimes[i] <- which(p1hand - p2hand == 0)[1]
}

table(snaptimes, useNA = "always")

# Can we do this without a loop?
snap <- function(handdiff) which((handdiff == 0) == TRUE)[1]
snap # ????
# Create lots of hands and then run lots of applys
numhands <- 100000
bighand1 <- apply(matrix(rep(cards, numhands), 52, numhands), 2, sample)
bighand2 <- apply(matrix(rep(cards, numhands), 52, numhands), 2, sample)
snaptimes2 <- apply(bighand1 - bighand2, 2, snap)
table(snaptimes2, useNA = "always")

barplot(table(snaptimes2)) # Probably need to do your own axes here to make it neater

# What's the best estimate of the number of hands before we reach snap?
# How about 
mean(snaptimes2, na.rm = TRUE) # About 22
# WRONG! What about all those times when we never hit snap?

# A better estimate is the number of times it took divided by the number of times you got snap
(sum(snaptimes2, na.rm = TRUE) + sum(52 * is.na(snaptimes2))) / sum(!is.na(snaptimes2))  # Nearer to 53!

#############################
# Extended example - fitting logistic regression models

# This is the model we fitted back in lecture 3 (with very slight changes)
library(MASS)
data(birthwt)

# For a given value of beta0 and beta1, calculate the likelihood
x <- birthwt$age
y <- birthwt$low

# Function to calculate the negative log likelihood

neglikfun <- function(parameters) {
    beta0 <- parameters[1]
    beta1 <- parameters[2]
    # separate data in 0s and 1s
    daty0 <- y == 0
    daty1 <- y == 1
    # calculate the log-likelihood
    loglikelihood <- sum(log(1 / (1 + exp(- beta0 - beta1 * x[daty1])))) +
    sum(log(1 - (1 / (1 + exp(- beta0 - beta1 * x[daty0])))))
    # return the negative of the log-likelihood
    return(-loglikelihood)
}

library(MASS) 
data(birthwt)
x <- birthwt$age
y <- birthwt$low 
neglikfun(c(1, -0.1))

# Call the function with example values
neglikfun(c(1, -0.1))

# Now run optim
res <- optim(c(0, 0), neglikfun)
res

# Check with the usual version
mod <- glm(low ~ age, family = binomial, data = birthwt)
mod
mod$coefficients
logLik(mod) # Function to extract the Log-Likelihood from a "glm" object
?logLik

# Our results:
res$par
res$value

# LAB 7 #######

# 1
D(expression(exp(x^2)), 'x') # example

# a)
f <- function(x) x^2 * sin(x) # works
curve(f, 0, 10) #graphs the above
D(expression(x^2 * sin(x)), 'x') #derivative of the above

# next 3 lines need to be done together to work
g <- function(x) body(g) <- D(body(f), 'x')
eval(body(g))  # works if run this line, doesn;t without
curve(g, 0, 10) 

# below works as graph of derivative on its own:
curve(eval(D(expression(x^2 * sin(x)), 'x')), 0, 10) # works


# b)
# don't quite understand the below:
f2 <- function(x) a^x
curve(f2, a=0.5, 0, 10)
curve(f2, 0, 10)
f3 <- function(a) a^x
curve(f3, 0, 10)
curve(f3, a=0.5, 0, 10)

D(expression(a^x), 'a')
D(expression(a^x), 'x')

curve(eval(D(expression(a^x), 'x'))) # works?

# the below is same as above but doesn't work
g2 <- function(x) body(g2) <- D(body(f2), 'x')
eval(body(g2))
curve(g2, 0, 10)

D(expression(x+sin(x)-log(x)*exp(x)+7), 'x')
curve(eval(D(expression(x+sin(x)-log(x)*exp(x)+7), 'x')), 0, 10) # ??

f4 <- function(x) x+sin(x)-log(x)*exp(x)+7
curve(f4, 0, 10)
curve(eval(D(expression(x+sin(x)-log(x)*exp(x)+7), 'x')))

# again don't think it works
g3 <- function(x) body(g3) <- D(body(f4), 'x')
eval(body(g3))
curve(g3, 0, 10)

# 2
?curve
?eval
curve(exp(x^2))
curve(exp(x^2), from= 0, to = 10)
curve(dvv, 0, 10)
eval(D(expression(exp(x^2)), 'x'))
curve(eval(D(expression(exp(x^2)), 'x')))

# 1 and 2 done as per NOTE from UCD:
# a)
function(x) x^2 * sin(x)
D(expression(x^2 * sin(x)), 'x') # derivative
x <- 5 # we want to substitute 5 for x, to evaluate at this value, use eval()
eval(D(expression(x^2 * sin(x)), 'x'))
curve(x^2 * sin(x), from= 0, to= 10) # graph of function
curve(eval(D(expression(x^2 * sin(x)), 'x')), from=0, to= 10, add=T)
# graph the derivative

# b)
function(x) a^x
D(expression(a^x), 'x')
a <- 0.5
eval(D(expression(a^x), 'x')) # for a=0.5 and x=5
curve(a^x, from= 0, to= 10)
curve(eval(D(expression(a^x), 'x')), from=0, to= 10, add=T)

# c)
function(x) x+sin(x)-log(x)*exp(x)+7
curve(x+sin(x)-log(x)*exp(x)+7, rom= 0, to= 10)
D(expression(x+sin(x)-log(x)*exp(x)+7), 'x')
curve(eval(D(expression(x+sin(x)-log(x)*exp(x)+7), 'x')), 
      from=0, to= 10, add=T)

# 3)
# example:
integrate(function(x) x^2, 0, 1)

# a) 
?dnorm
integrate(dnorm, -1.96, 1.96, mean=2, sd=1) 

# b)
integrate(dnorm, -Inf, 2, mean=0, sd=1) 
pnorm(2)

integrate(dt, -1, Inf, df=5)

# 4 #

library(MASS)
data(MASS)
head(birthwt)
head(birthwt[order(birthwt$age),],3)
head(birthwt[order(birthwt$bwt, decreasing=T),],1)

# 5 #

A <- matrix(c(2,0,1,1,1,3,-1,-2,2), 3,3)
A
b <- c(7,-9,11)
x <- solve(A, b)
x

# 6 #

sd.swiss <- apply(swiss, 2, sd) # # calculate the column standard deviations
swiss.standardised <- sweep(sweep(swiss, 2, mean.swiss), 2, sd.swiss, "/") 
head(swiss.standardised, 3)


  
library(MASS)
birthwt.part <- data.frame(birthwt$age, birthwt$lwt, birthwt$bwt)
birthwt.part

b.iqr <- apply(birthwt.part, 2, IQR)
b.m <- apply(birthwt.part, 2, median)
b.iqr
b.m
?sweep
b.sweep <- sweep(sweep(birthwt.part, 2, b.m), 2, b.iqr, "/")
b.sweep # I think this is it

# 7 # 
?lm
lm(birthwt$bwt ~ birthwt$age, birthwt$smoke, birthwt$lwt)

lm(birthwt$bwt ~ birthwt$age)
lm(birthwt$bwt ~ birthwt$smoke)
lm(birthwt$bwt ~ birthwt$lwt)
