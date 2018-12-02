# Lecture 8 code

# When you type the name of an object at the command prompt, 
# it just calls print on that object
x <- 3
x
print(x) # Exactly the same

# Print works differently for different objects

y <- list(tag1 = 2, tag2 = c(2, 3), tag3 = 1:10)
print(y)

# Now try an lm object
?lm
mod <- lm(Fertility ~ ., data = swiss)
print(mod)

# Look at class
class(y) # list
class(mod) # lm

# Compare the two print object
print
stats:::print.lm

# Compare two summary objects
summary(y)
summary(mod)

# Compare two plot objects
plot(y) # Only works if it has components x and y
plot(mod)

# Remove the class and print
unclass(mod)

# show the names of the tags in mod
names(mod)

# print using print.lm
stats:::print.lm(mod)

# Look at print methods
methods(print)

# Use a non-visible function
getAnywhere(print.acf)
stats:::print.acf

# Create an S3 object
j <- list(name = 'Joe', salary = 55000, union = TRUE)
class(j) <- 'employee'
j # or print(j)
attributes(j)



# Write a new print method
print.employee <- function(wkr) {
  cat(wkr$name, '\n')
  cat('salary', wkr$salary, '\n')
  cat('union member', wkr$union, '\n')
}
j # or print.employee(j) or print(j)

print.employee2 <- function(wkr) {
  cat(wkr$name, '\n')
  cat('salary:', wkr$salary, '\n')
  cat('union member:', wkr$union, '\n')
}

print.employee2(j)


# Create an object with two classes
k <- list(name = 'Kate', salary = 68000, union = F, hrs_this_month = 2)
class(k) <- c('hrly_employee', 'employee')
k
attributes(k) # has 2 classes

#####################################

# lm

mod <- lm(Fertility ~ Catholic, data = swiss)
mod
lm(Fertility ~ Education, data = swiss)
lm(bwt ~ age, data = birthwt)
lm(bwt ~ smoke, data = birthwt)

x <- c(1,2,3)
y <- c(1,3,8)
lmout <- lm(y ~ x)
lmout

require(graphics)
## Annette Dobson (1990) "An Introduction to Generalized Linear Models".
## Page 9: Plant Weight Data.
ctl <- c(4.17,5.58,5.18,6.11,4.50,4.61,5.17,4.53,5.33,5.14)
trt <- c(4.81,4.17,4.41,3.59,5.87,3.83,6.03,4.89,4.32,4.69)
group <- gl(2, 10, 20, labels = c("Ctl","Trt"))
weight <- c(ctl, trt)
lm.D9 <- lm(weight ~ group)
lm.D90 <- lm(weight ~ group - 1) # omitting intercept
anova(lm.D9)
summary(lm.D90)
opar <- par(mfrow = c(2,2), oma = c(0, 0, 1.1, 0))
plot(lm.D9, las = 1)      # Residuals, Fitted, ...
par(opar)

# Create a class for polynomial regression

# Run a polynomial regression
?lm

lv_one_out <- function(y, xmat) { # xmat matrix containing x, x^2,..., x^p
  n <- length(y) # number of observations
  predy <- vector(length = n) # initilise the vector of the predicted y
  for(i in 1:n) {
    lmo <- lm(y[-i] ~ xmat[-i,,drop = FALSE]) # apply the regression to all the observation but i
    betahat <- as.vector(lmo$coef) # store the coefficients in the vector beta
    predy[i] <- betahat %*% c(1, xmat[i,]) # predict y_i
}
  return(predy)
}

polyfit <- function(y, x, maxdeg) {
  n <- length(y)
  # create Xmat matrix containing x, x^2,..., x^maxdeg
  Xmat <- sweep(matrix(rep(x, maxdeg), nrow = n, ncol = maxdeg), 2, 1:maxdeg, '^')
  # create a list of class polyreg that will contain the output
  lmout <- list()
  class(lmout) <- 'polyreg'
  # fit different polynomial regressions, from degree 1 (linear regression) to degree maxdegree
  for(i in 1:maxdeg) { 
    lmo <- lm(y ~ Xmat[, 1:i, drop = FALSE])
    # add the results of the cross validation in a new tab of lmo
    lmo$cv.fitted.values <- lv_one_out(y, Xmat[, 1:i, drop = FALSE])
    lmout[[i]] <- lmo # store the results of this regression in a tab of lmout
  }
  # store also the data in the output
  lmout$x <- x
  lmout$y <- y
  return(lmout)
}

# Use the functions polyfit and lv_one_out
n <- 60
x <- (1:n) / n
y <- rnorm(n, sin(3 * pi / 2 * x) + x^2, sd = 0.5)
maxdeg <- 6
lmo <- polyfit(y, x, maxdeg)
summary(lmo)

summary.polyreg <- function(lmo.obj) {
    maxdeg <- length(lmo.obj) - 2 # lmo.obj contains the outputs and x and y 
    n <- length(lmo.obj$y) 
    tbl <- matrix(nrow = maxdeg, ncol = 1) # table for the summary
    colnames(tbl) <- 'MSPE'
    for(i in 1:maxdeg) {
      curr.obj <- lmo.obj[[i]]
      errs <- lmo.obj$y - curr.obj$cv.fitted.values # absolute error in predicting y
      spe <- crossprod(errs, errs) # sum of squares of the vector errs
      tbl[i, 1] <- spe / n
    }
    cat('Mean squared predictions errors, by degree \n')
    print(tbl)
}

## use all the functions
lmo <- polyfit(y, x, maxdeg)
summary(lmo)

#####################################

# An example of an S4 class
setClass('employee', 
  representation(name = 'character', salary = 'numeric', union = 'logical'))

joe <- new('employee', name = 'Joe', salary = 55000, union = TRUE)
?new

# Reference Joe
joe
joe@salary
slot(joe, 'union')

# Change Joe
joe@salary <- 65000 

# What happens if we try and break it
joe@salry = 55000
# No error message if we were in S3

joe$salary <- 55000

# Create a generic function
show(joe) # S4 equivalent of print

# Overide it
setMethod('show', 'employee', 
  function(object) {
  inorout <- ifelse(object@union, 'is', 'is not')
  cat(object@name, 'has a salary of', object@salary, 'and', 
    inorout, 'in the union \n')
  }
)
joe

#####################################

# Managing objects

ls()
# List all the objects with 'jo' in them somewhere
ls(pattern = 'jo') 
rm(joe, x, y)

# Remove everything
rm(list = ls())

# Save and load
z <- rnorm(1000)
hz <- hist(z)
# save the histogram
save(hz, file = 'hzfile.RData')
ls()
rm(hz)
ls()
# load the histogram
load('hzfile.RData')
ls()
plot(hz)

# Does it exist?
exists('hz')
exists(hz)



# LAB #

# 1
?density
faithful
z <- apply(faithful, 2, density)
z
plot(z)

# the below 4 are correct
xx <- density(faithful$eruptions)
xx
plot(xx)
class(xx)

# 2
methods(class = density)

# 3
unclass(xx)

# 4
# ???
xx.summary <- function(xx) {
  print(data.frame(xx$x, xx$y))
  a <- round(xx$y, 3)
  b <- table(a)
  print(b)
  plot(a)
  print(sort(b, decreasing = T)[1])
}

xx.summary(xx) # the table doesn't give the same mode as graph

# 5 #

?boot
library(boot)
head(motor)
n.motor <- data.frame(motor$times, motor$accel)
plot(n.motor)

g <- lm(formula = motor$accel ~ motor$times + I(motor$times^2) + I(motor$times^3))
?formula
?lm

unclass(g)
summary(g)
plot(g$fitted.values)
?lm

# 6 
c <- polyfit(motor$times, motor$accel, 3)
plot(c)
