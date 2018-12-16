# Declare a vector
y <- vector(length = 2)
y[1] <- 5
y[2] <- 12
y

# Using all and any
x <- 1:10
any(x < 8)
all(x < 8)

# NA and NULL values
x <- c(88, NA, 12, 168, 13)
mean(x)    # won't work
mean(x, na.rm = TRUE) #works now
x <- c(88, NULL, 12, 168, 13)
mean(x)  # works with NULL

# More on NULL (APPENDING A VECTOR)
z <- NULL
for(i in 1:5) z <- c(z, i)
z

z <- NA
for(i in 1:5) z <- c(z, i)
z

# Subset
x <- c(6, 1:3, NA, 12)
x
x[x > 5]
subset(x, x > 5)
subset(women, weight < 130)

# which
z <- c(5, 2, -3, 8)
z
which(z^2 > 8)
z[z^2 > 8]
z[which(z^2 > 8)]

# Filtering a matrix - using arr.ind 
M <- matrix(1:6, nrow = 3, ncol = 2)
M
which(M > 4)
which(M > 4,arr.ind=TRUE)

# Using ifelse
x <- 1:10
y <- ifelse(x %% 2 == 0, 'even', 'odd')
y
paste(x, 'is ', y)

# using apply
M <- matrix(1:4,2,2)
M
apply(M, 2, mean)
apply(M, 1, mean)
?apply

f <- function(x) x / max(x)
max(M)
apply(M, 2, f)
apply(M, 1, f) 

# Finding shape
length(M)
dim(M)

# Arrays
resting <- matrix(c(36.1, 36.0, 36.3, 68, 65, 85), nrow = 3, ncol = 2)
active <-  matrix(c(36.3, 36.5, 37.3, 98, 112, 135), nrow = 3, ncol = 2)
d1 <- array(data = c(resting, active), dim = c(3, 2, 2))
d1
d1[3, 1, 2]

crimes.2008 <- read.csv("EuroStatCrime2008.csv", row.names = 1)
crimes.2009 <- read.csv("EuroStatCrime2009.csv", row.names = 1)
crimes.2010 <- read.csv("EuroStatCrime2010.csv", row.names = 1)
crimes.2011 <- read.csv("EuroStatCrime2011.csv", row.names = 1)
crimes.2012 <- read.csv("EuroStatCrime2012.csv", row.names = 1)
crimes.2013 <- read.csv("EuroStatCrime2013.csv", row.names = 1)
crimes.2014 <- read.csv("EuroStatCrime2014.csv", row.names = 1)
crimes.2015 <- read.csv("EuroStatCrime2015.csv", row.names = 1)

a <- array(data = as.matrix(cbind(crimes.2008, crimes.2009, crimes.2010)), 
           dim=c(41,7,3), dimnames = list(rownames(crimes.2008), colnames(crimes.2008), 2008:2010))

a  
big.mat <- as.matrix(cbind(crimes.2008, crimes.2009, crimes.2010, crimes.2011,
                           crimes.2012, crimes.2013, crimes.2014, crimes.2015))
big.mat


A <- array(data = big.mat,
           dim = c(41, 7, 8), 
           dimnames = list(rownames(crimes.2008), colnames(crimes.2008), 2008:2015))

A['Ireland', c(3:6), 8]

# Create a list
j <- list(name = 'Joe', salary = 55000, union = T)
j

# list indexing (3 ways)
j$salary
j[['salary']]
j[[2]]
j[2] # without double square brackets it returns a list and not a number
j['salary'] # same as above
j[1:2] # this command works because R treats list as VECTORS

# list indexing (3 ways)
# extracting components of a list
# 3 ways
#[] - always returns a list
#[[]] - always returns the actual object
#$ - same as [[]] but prettier

# Add a new component
j$sales <- c(10400, 12300, 13700) 
j[[5]] <- 'Manager' 
j

# Delete it
j[[5]] <- NULL

# the function UNLIST will convert a list into a vector using the mode of the 
# lowest common denominator (here, char)
t <- unlist(j)
t
mode(t)
# by default, R will give names to unlisted objects taken from tags, 
# we can remove them via unname() command or through an extra argument
unlist(j, use.names=FALSE)
j
?unlist
l.ex <- list(a = list(1:5, LETTERS[1:5]), b = "Z", c = NA)
l.ex
unlist(l.ex, recursive = FALSE)
unlist(l.ex, recursive = TRUE)

# applying functions to lists
# lapply - version for lists
lapply(list(1:3, 25:29), median) #returns result as a list
?lapply()

sapply(list(1:3, 45:67), median) #returns result as vector (simple apply)
tt <- sapply(list(1:3, 25:29), median)
mode(tt)
tt*6
?sapply

# to access specific element of a vector that's part of the list
list_RL1$Stats[3]
list_RL1[[2]][3]

# naming components of a list
names(list_RL1)
names(list_RL1) <- c('Machine', 'Stats', 'LowThreshold')
list_RL1
## another way, like with data frames
rm(list_RL1)
list_RL1 <- list(Machine='RL1', Stats=util_stats_rl1, LowThreshold=util_under_90_flag)
list_RL1

# add and delete components
list_RL1
list_RL1[4] <- 'New information'
list_RL1

# subsetting a list
list_RL1[1]
list_RL1[1:2]
list_RL1[1:3]
list_RL1[c(1,4)]
list_RL1[c('Machine', 'Stats')]
# double square brackets are not for subsetting
# double square brackets are for accessing list elements 

# below 2 get the same result (access 1 eleement of list, first row, 1 column)
Weather[[1]][1,1]
Weather$Chicago[1,1]

# apply with []
lapply(Weather, '[', 1, 1) #gets 1st element, 1st row, 1st col
lapply(Weather, '[', 1, ) # gets 1st row + all cols of all list elements


# subsetting to remove NAs
women[complete.cases(women),]

# manipulating data frame
data(women) 
women2 <- cbind(women, letters[1:15])
women2
women3 <- rbind(women, c(73, 166))
women3
women4 <- cbind(women, women$height * 2.54, women$weight * 0.45)
names(women4) <- c('heightin', 'weightin', 'heightcm', 'weightkg')
women4

# Merging data frames
d1 <- data.frame(kids = c('Jack', 'Jill', 'Jillian', 'John'),
                 county = c('Dublin', 'Cork', 'Donegal', 'Kerry'))
d1
d2 <- data.frame(ages = c(10, 7, 12), 
                 kids = c('Jill', 'Lillian', 'Jack'))
d <- merge(d1, d2)
d

# Matching with different variable names
d3 <- data.frame(age = c(10, 7, 12), 
                 names = c('Jill', 'Lillian', 'Jack'))

merge(d1, d3, by.x = 'kids', by.y = 'names')

# Using lapply on a data frame
d
lapply(d, sort)  # it seems to jumble things???
data.frame(lapply(d, sort))  # it seems to jumble things???

# apply working on data frame (adds elements from 1st and last col)
dat <- data.frame(x=c(1,2,7), y=c(3,4,9), z=c(5,6,2))
dat
apply(dat[,c('x','z')], 1, function(x) sum(x) )
apply(dat, 1, function(x) sum(x) ) # adds elements from all rows
rowSums(dat) # same result
rowSums(dat[-2]) #same as above
apply(dat, 2, function(x) sum(x) )
colSums(dat)

#####
# saving graphs to files
# better to save through command, not export button
pdf("myfilename.pdf", width = 10, height = 8) 
# Plotting commands go here
dev.off()

# changing a vector into factors
x <- c(5, 12, 13, 12) 
xf <- factor(x)

# specifying additional factors
xf2 <- factor(x, levels = c(5, 12, 13, 88))

# functions for factors: tapply
# Let’s suppose we have a list of chick weight at 21 days together with a diet the chick received:
weight <- c(205, 331, 175, 117, 272, 251)
diet <- c('Diet_A', 'Diet_B', 'Diet_B', 'Diet_A', 'Diet_C', 'Diet_B')
# calculating the mean within each diet group
# tapply(x, f, g) with x= vector, f = factor and g = function)
tapply(weight, diet, mean)

# split function splits things into groups and returns a list
split(weight, diet)

# by function
# The function by works a bit like tapply but is applied to objects rather than vectors.
# by(x, f, g) where x is a data object, f is a factor on which to split the data into
# groups and g is a function to be applied to each group.
library(MASS)
by(birthwt, birthwt$race, function(m) glm(m[,1] ~ m[,2], family = binomial))
# Replacing by with tapply will give an error as tapply works on a vector, not a data frame.

# TABLES
# create a table using table function:
birthwt2 <- data.frame(birthwt$low, birthwt$race) 
head(birthwt2)
table(birthwt2)
# The table function will take a data frame of 2 (or more) columns 
# and turn them into a contingency table

# If we just wanted counts on one of the variables we could use, for example:
table(birthwt$low)

# accessing table
tab1 <- table(birthwt2) 
tab1
tab1[1, 2]

# We can perform scalar multiplication on a table
tab1 / sum(tab1) # gives proportions !!!!!!!!!!!!!!!!

# finding marginal counts by using apply:
apply(tab1, 1, sum)
?apply
?addmargins
# can do same with 'addmargins'
addmargins(tab1)

# The aggregate function calls tapply for each variable in a group
aggregate(birthwt$age, list(birthwt$race), mean)
# This is the mean age broken down by race. 
# We can aggregate over multiple variables if required.

# One handy use of aggregate is getting the number of appearances 
# of the various values:
values <- data.frame(variable = c("a", "a", "a", "a", "a", 
                               "b", "b", "b", 
                               "c", "c", "c", "c"))
values
nr.of.appearances <- aggregate(x = values, 
                               by = list(unique.values = values$variable), 
                               FUN = length)
nr.of.appearances 

# find the mean weight depending on diet
data <- ChickWeight
data
aggregate(data$weight, list(diet = data$Diet), mean)

#aggregate on time
aggregate(data$weight, list(time=data$Time), mean)

#we could also aggregate on time and diet
aggregate(data$weight, list(time=data$Time, diet=data$Diet), mean)

# function to create sums of matrix columns
mycolsum2 <- function(i, M) {
  return(sum(M[,i]))
}
mycolsum2(1, M)
M
mycolsum2(2, M)

# A for loop over matrix objects
u <- matrix(1:6, 3, 2)
v <- matrix(7:12, 3, 2)
for(i in c('u', 'v')) {
  print(i) # print the value of i
  z <- get(i) # get the object with the name given by the current value of i
  print(colMeans(z)) # print the values of the column means
}

# if-else
r <- 3
if(r == 4) {
  x <- 2
} else { # if( r != 4)
  x <- 3
  y <- 4
}
# Exponentiation and modular arithmetic
x <- 13
y <- 5

x^y
x %% y

# Integer division
x %/% y

# function output examples
fun2 <- function(x, printx = TRUE, printy = TRUE) {
  y <- x^2
  if(printx) print(x)
  if(printy) print(y)
  return(list(input = x, output = y))
}
fun2(9)

#
fun3 <- function(x, printy = TRUE) {
  y <- x^2
  if(printy) print(y)
  invisible(y) # do not print the value returned by the function if that's not assigned to an object
}

# The function function
fun4 <- function(x = 7){
  return(x^2)
}
formals(fun4) # get the arguments of the function fun4
body(fun4) # get the body of the function fun4

# Giving extra arguments to functions
fun5 <- function(x,...) {
  return(mean(x,...))
}

# If you look at ?mean it has extra arguments trim and na.rm
fun5(c(1:10))
fun5(c(1:10, NA))
fun5(c(1:10, NA), na.rm = TRUE)

# The environment function
environment() # show the current environment
ls() # give the list the objects in the current environment
ls.str() # give the list the objects in the current environment and their structure

# Objects can only exist inside functions
d <- 5
f <- function() {
  d <- 8
  return(d)
}
f()
d

# The "<<-" operator
d <- 5
f <- function() {
  d <<- 8
  return(d)
}
f()
d

# Write your own function operator
"%a2b%" <- function(a, b) return(a + 2 * b) 
3 %a2b% 5

# Anonymous functions - from lecture 3
M <- matrix(1:6, nrow = 3, ncol = 2)
f <- function(x) x / max(x)
apply(M, 1, f)

# Alternative with an anonymous function
apply(M, 1, function(x) x / max(x))

# Some examples of various maths functions
exp(1) # The value of e
exp(2)
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
round(3.88) # Round to nearest integer
floor(3.21) # Round to lowest nearest integer
ceiling(3.21) # Round to highest nearest integer
signif(12332, digits = 3) # Rounds to specified number of significant digits

##############################

a <- c(1,4,9)
b <- c(2,2,7)
pmin(a, b) # parallel minimum

# getting max of a row in list or matrix
lapply(Weather, function(x) apply(x, 1, max))
lapply(Weather, apply, 1, max)
sapply(Weather, apply, 1, max)
sapply(Weather, apply, 1, min)

##############################

# Calculus
D(expression(exp(x^2)), 'x') # derivative
# to do second derivative use D function within D function:
D(D(expression(exp(x^2)), 'x'), 'x')

x <- 3
eval(exp(x^2))
exp(9)

# integration
integrate(function(x) x^2, 0, 1)

############################

# subset
library(MASS)
Cars93

?subset
# Select the model name for cars that can 
# exceed 30 miles per gallon (MPG) in the city

subset(Cars93, select=Model, subset=(MPG.city > 30))

#Select the model name and price range for 
# four-cylinder cars made in the United States

subset(Cars93, select=c(Model, Min.Price, Max.Price), 
       subset=(Cylinders == 4 & Origin == 'USA'))

# calculating z-score
Cars93
z <- (Cars93$Price - mean(Cars93$Price)) / sd(Cars93$Price)
z
# or better, shorter way with 'with
z <- with(Cars93, (Price - mean(Price)) / sd(Price))
z
?with

# Plot the pdf (probability density function) of a standard normal distribution
curve(dnorm, from = -4, to = 4)
curve(pnorm, from = -4, to = 4)
curve(qnorm, from = 0, to = 1)
?curve

# Sorting
x <- c(5, 13, 12, 5)
sort(x)
order(x) # 1st item is 1st in order, 2nd item (13) is 4th in order etc
rank(x) # ranks elements, for example here the second element
# 13 is the fourth from the bottom so it was marked as 4
# repeated values are replaced by their mean (5+5)/2

# Sorting a matrix
d <- data.frame(kids = c('Jack', 'Jill', 'Billy'), ages = c(12, 10, 13))
d
d[order(d$kids),]
d[order(d$ages),]

# sorting a data frame using one column as the sort key
dfrm <- dfrm[order(dfrm$key),] # sort doesn' work on data frames

# sorting data frame by 2 columns
dfrm <- dfrm[order(dfrm$key1,dfrm$key2),]

# Set operations
x <- 1:5
y <- 4:8
union(x, y) # Creates the union set of x and y
intersect(x, y) # Creates the intersection of x and y
setdiff(x, y) # Creates the set of all objects in x that are not in y
setdiff(y, x) 
setequal(x, y) # Determines if x and y are equal
4 %in% y # Tests whether 4 is an element of y

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

# centre the variables around their mean:
mean.swiss <- apply(swiss, 2, mean) # calculate the column means. Same as colMeans(swiss)
mean.swiss
str(mean.swiss)
head(swiss)
swiss.mean0 <- sweep(swiss, 2, mean.swiss)
head(swiss.mean0, 3)

# standardise the variables z = (x - mean) / sd
sd.swiss <- apply(swiss, 2, sd) # # calculate the column standard deviations
swiss.standardised <- sweep(sweep(swiss, 2, mean.swiss), 2, sd.swiss, "/") 
head(swiss.standardised, 3)

# 3/3 matrix, we add 1 to row 1, 4 to row 2, 7 to row 3:
m <- matrix(1:9, 3, 3, byrow= TRUE)
m
sweep(m, 1, c(1,4,7), '+')

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

# APPLY FAMILY
# apply - use on matrix
# tapply - use on a vector to extract subgroups and apply a function to them (use on 
# factors)
# by - use on data frames
# lapply - apply function to elements of a list, can use on data frame
# sapply - a version of lapply. Can simplify the result so it's not presented as a list
# vapply - returns a vector
# replicate - runs a function several times

#########################

# calculate correlation between each variable and resp:
cors <- sapply(pred, cor, y=resp) # returns a vector of correlations, one for 
# each column

########################
# number of rows:
nrow(amazon[PublicationYear == 2014,]) / nrow(amazon)

# Max and min values
sum[order(sum$Reviews)[1],]  #this
sum[order(sum$Price, decreasing = TRUE)[1],]   #this
sum[which.min(sum$Reviews),]  #this
sum[which.max(sum$Price),]   #this

##############
# function, graph of function, graph of its derivative
f4 <- function(x) x+sin(x)-log(x)*exp(x)+7
curve(f4, 0, 10)
curve(eval(D(expression(x+sin(x)-log(x)*exp(x)+7), 'x')))

eval(D(expression(exp(x^2)), 'x')) # this needs variable supplied
x <- 4:9

# NOTE from UCD:
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

# multiple regerssion
library(MASS)
lm(birthwt$bwt ~ birthwt$age + birthwt$smoke + birthwt$lwt)

## REGRESSION TRICKS

require(graphics)
## Annette Dobson (1990) "An Introduction to Generalized Linear Models".
## Page 9: Plant Weight Data.
ctl <- c(4.17,5.58,5.18,6.11,4.50,4.61,5.17,4.53,5.33,5.14)
trt <- c(4.81,4.17,4.41,3.59,5.87,3.83,6.03,4.89,4.32,4.69)
group <- gl(2, 10, 20, labels = c("Ctl","Trt"))
?gl
weight <- c(ctl, trt)
lm.D9 <- lm(weight ~ group)
lm.D9
lm.D90 <- lm(weight ~ group - 1) # omitting intercept
lm.D90 
anova(lm.D9)
summary(lm.D90)
opar <- par(mfrow = c(2,2), oma = c(0, 0, 1.1, 0))
plot(lm.D9, las = 1)      # Residuals, Fitted, ...
par(opar)

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

# 1 Produce a density plot of the eruptions lengths with the function density (see lecture 5 for instructions)
# What command did you use?
plot(density(faithful$eruptions))
density(faithful$eruptions)

# Create an object z which stores the output of the density function. What class is it?
z <- density(faithful$eruptions)
class(z) # class density

# 2 Use the methods function to find which methods are available for class density (hint: use the second argument of methods only)
methods(class = 'density')
# Which methods are available for objects of class density?
# [1] plot.density  print.density YES
# summary.density predict.density NO

# 3 Use unclass on your object z. How many tags are there in the resulting list?
length(unclass(z)) # 7

# 4 Included in the object z are elements are a grid x containing the eruption lengths and a vector y of the same length containing the estimated probability density. Write a summary method which outputs the x and y parts of the list in a 2-column matrix, as well as outputting the modal value. What is the modal eruption time (to 3 d.p.) for the old faithful data?
summary.density <- function(obj) {
  cat('The first column are the x values and the second the y values: \n')
  print(cbind(obj$x, obj$y))
  cat('The modal x value is: \n')
  print(obj$x[which.max(obj$y)])
}
summary(z) # 4.369

# 5 In the boot package there is a data set called motor which details the head acceleration of a motorcyclist after an accident. The first two columns of motor are the time and acceleration. You can ignore the third and fourth column. Create a plot of time (x-axis) against acceleration (y-axis). Use the lm function to fit a cubic regression model (hint: use lm(y ~ x + I(x^2) + I(x^3))) and plot the fitted line
library(boot)
data(motor)
plot(motor$times,motor$accel)
# cubic (polynomial) regression:
mod <- lm(motor$accel ~ motor$times + I(motor$times^2) + I(motor$times^3))
lines(motor$times,mod$fitted.values,col='red')
# How would you describe the fit? 
# Good or Poor? POOR!

####################################################
# Note on eval() and D()
####################################################

# D() is used to differentiate mathematical expressions:
D(expression(x^2), 'x')

# This returns a symbolic object (an expression)
# R doesn't see this as a function, and can't,
# for example, substitute x into it

# D() won't work without the expression function:
D(2 * x^2 + 3 * x - 5, 'x')

x <- 2
D(2 * x^2 + 3 * x - 5, 'x')
# Now D() thinks I want to differentiate
# 2 * 2^2 + 3 * 2 - 5, which is of course 0

####################################################

# If we use the eval() function,
# we're telling R to see the result from D() as a function
# with unknowns that can be filled in and evaluated:
x <- 5
eval(D(expression(x^2), 'x'))

# This returns 10, as it should
# The derivative of x^2 is 2 * x
# Then 2 * x is 10 since x is 5

# I can then use curve() to draw the original function:
curve(x^2, from=0, to=5)

# And also to draw the derivative:
# (add=TRUE means that I add the line on
# top of the existing plot)
curve(eval(D(expression(x^2), 'x')),
      from=0, to=5, add=TRUE)

#######

# Use the scan function to read the files
scan('z1.txt')
scan('z2.txt')
scan('z3.txt')
scan('z3.txt', what = '')
scan('z3.txt', what = 'character')
scan('z4.txt', what = '')

# Return it to an object
x1 <- scan('z3.txt', what = '')
x2 <- scan('z3.txt', what = '', sep = '\n')
x1
x2
?scan

# Use of readline
z <- readline()
z

inits <- readline('Type your initials: ')
inits

# Use of write.table
kids <- c('Jack', 'Jill')
ages <- c(12, 10)
d <- data.frame(kids, ages, stringsAsFactors = FALSE)
write.table(d, file = 'd1.txt')
write.table(d, file = 'd2.txt', quote = FALSE, row.names = FALSE)
write.csv # similar

# Use of cat
x <- 2:4
cat('abc\n ', x, file = 'd3.txt', sep = '')
cat(x, 'de\n', x, file = 'd4.txt', append = TRUE)

########################################

#  String manipulation

# Use of grep
grep('Pole', c('Equator', 'North Pole', 'South Pole'))
grep('pole', c('Equator', 'North Pole', 'South Pole'))
grep('pole', c('Equator', 'North Pole', 'South Pole'), ignore.case = TRUE)
?grep

grep("a+", c("abc", "def", "cba a", "aa"), perl=TRUE, value=FALSE)
# returns positions of elements that have 'regex'
grep("a+", c("abc", "def", "cba a", "aa"), perl=TRUE, value=TRUE)
# returns the values of elements that have 'regex'

# gsub
x <- 'South Pole'
gsub('South', 'North', x)
x
?gsub

# nchar
nchar('South Pole')
nchar('SouthPole')

# substr
substr('Equator', 1, 2)
substr('Equator', 3, 5)
?substr

# strsplit
strsplit('October-17', split = '-')
d <- strsplit('October-17', split = '-')
d

# paste
paste('North', 'Pole')
paste('North', 'Pole', sep = '')
x <- 'and'
paste('North', x, 'South', 'Pole')

# regexpr
regexpr('an','Banana')
?regexpr

# gregexpr
gregexpr('an','Banana')

########################################

# Example regular expressions

# Find 'a' or 'u' in a vector
grep('[au]', c('Equator', 'North Pole', 'South Pole'))

# Find places where 'o' is followed by a character and then an 'e'
grep('o.e', c('Equator', 'North Pole', 'South Pole'))

# Find places where 'N' is separated by two characters from 't'
grep('N..t', c('Equator', 'North Pole', 'South Pole'))

# What if you want to search for a .?
grep('.', c('abc', 'de', 'f.g'))

# The way it's done
grep('\\.', c('abc', 'de', 'f.g'))

# More examples - states ending in 'ana'
state.name[grep('ana$', state.name)]

# States beginning with 'South'
state.name[grep('^South', state.name)]

# More on regular expressions
?regexp

# It doesn't have to be single characters
words <- c('cat','bat','dog','rabbit','rat')
grep('bat|cat', words)

# bat or cat
words[grep('(b|c)at', words)]

# At least zero of b or c
words[grep('(b*|c*)at', words)]

# Example 1: forming file names
for(i in 1:5) { 
  fname <- paste('N(0,', i, ').pdf', sep = '')
  pdf(fname)
  hist(rnorm(100, sd = i))
  dev.off()
}

# the files has been saved in your working directory

# Example 2: find files in a directory ending in a certain type
list.files(getwd(), '\\.txt$')
list.files(getwd(), '\\.pdf$')

# antibugging
x <- 5
if(length(x) != 3) stop("x is supposed to be of length 3!")
stopifnot(x < 0)

?browser

# Use of debug
debug(neglikfun) # run the function in browser mode

neglikfun(c(1,-0.1))
undebug(neglikfun) # run the function normally

# Use of debugonce
debugonce(neglikfun)
neglikfun(c(1,-0.1))

# Use of trace
trace(neglikfun, browser)
neglikfun(c(1,-0.1))
untrace(neglikfun)

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

# REGRESSION
# 2 regression models for same data
reg <- lm(wines$Tasting ~ wines$View)
reg
plot(reg, which=1)

reg2 <- lm(wines$Tasting ~ poly(wines$View,2,raw=TRUE))
reg2
plot(reg2, which=1)

#same result as above
reg3 <- lm(wines$Tasting ~ wines$View + I(wines$View^2))
reg3
plot(reg3, which=1)

summary(reg)
summary(reg2)
summary(reg3)

# plotting data values with fitted values
plot(wines$View, wines$Tasting)
lines(reg$fitted.values ~ wines$View)

# PLOTTING
# the plot function
plot(x, y)  # x and y are vectors

x <- c(1, 2, 3)
y <- c(1, 2, 4) 
plot(x, y)

plot(x, y, 
     xlab='x-axis', ylab='y-axis', # specifies the axes
     type='l',  # specifies the plot type to be a line
     main='My graph') #  specifies the main title

# adding to graphs
plot(x, y, type='n')  # blank graph
lines(x, y, col='red', lty=2, lwd=3)  # add red line
points(x, y, col='blue', pch=17, cex=2) # add blue points to line

# lty specifies the line type. lwd specifies the line width
help(lines)
# pch specifies the plotting character. cex specifies the point size 
help(points)

# adding text with text function
plot(x, y, type='b', pch=4)
text(1.5, 2.5, 'Text here') # the numbers refer to axes!
# the first 2 arguments specifythe x,y locations of the text
# the 3rd element gives text itself
# useful extra argument is pos which allows you to put the text:
# below (pos=1), left (pos=2), above (pos=3), right (pos=4) in repect
# of the chosen location

# adding text with mtext function
# if you want add text in the margin (outside the plotting region), 
# use the mtext function
mtext('Margin text', side=4, line=1)
# the side argument indicates which margin to write beside (1= bottom,
# 2= left, 3= top, 4= right)
# line tells R how far away from the margin the text should be
mtext('Margin text', side=3, line=2)

# changing colours
colours()
# colours case be used with the following:
par(bg= 'yellow')  # yellow background (have to re-run graph)
plot(x, y, type= 'n')
lines(x, y, col='blue')
points(x, y, pch=4, col= 'red')  # red points
# par controls persistent graphical parameters

par(bg= 'white')

# adding a legend with legend function
# the default usage is legend(x, y, legend, pch, lty, col) 
# where x, y is the location where you want the legend to be, 
# legend is a vector of names, pch are the plotting characters, 
# lty are the line formats, and col are the colours.

plot(x, y, type='p', pch=4, col='red')
lines(x, y, lty=2, col= 'red')
legend(1, 4, legend= c('My points', 'My lines'), 
       pch= c(4, -1), lty= c(-1, 2), col= 'red') # pch and lty here must
# match the entries in plot() and lines()
# 1, 4 are coordinates for the legend
# legend vector contains the legen text

# NOTE: here -1 produces a blank (no point or line)
# you can replace x, y with topleft, bottomleft etc
# if you want to get rid of the box use bty='n'

# customisation
# sizes: cex (character expansion) and is given relative to the standard size

plot(x, y, type= 'b', cex=1.5)
text(1.5, 2.5, 'Text here', cex=1.5)

# cex=1.5 will give text that's 1.5 the usual size
# the same argument works in plot, points, main, mtext

# putting maths in legend
# using Greek letter or other symbols in a plot title of axis
help(plotmath)
?expression
?paste

# example:
plot(x, y, xlab = expression(paste(x[1],"=", phi)),
     main = expression(paste(y^2 + 2 %->% infinity)), col.main = "red")
text(2, 3, expression(paste(frac(1, sigma * sqrt(2 * pi)), " ", 
                            plain(e)^{frac(-(x - mu)^2, 2 * sigma^2)})))

# many of the usual arguments (e'g' cex, col) can be applied here

# Axes
plot(x, y, type= 'b', pch=4, col= 'red', lty=2, xlim= c(0, 10), ylim= c(-2, 5))
plot(x, y, type= 'b', pch=4, col= 'red', lty=2, xlim= c(10, 0), ylim= c(-2, 5))

# axis function to create own specialist axis
plot(x, y, type= 'b', pch=4, col= 'red', xaxt= 'n')
axis(side=1, at= seq(1, 3, by= 0.1), label= TRUE)

# useful arguments for par():
# mar and mgp - default margins and plotting regions
# usr - gets the current plot limits
# mfrow/mfcol - plots an array of graphs
# las - rotates the axis label
# bg - set the background colour

# useful command at start of a function to produce a plot is:
par(mar = c(3, 3, 2, 1), mgp = c(2, 0.7, 0), las = 1)
# ?????

# brilliant resource: http://gastonsanchez.com/r-graphical-parameters-cheatsheet.pdf

# BAR CHARTS
stores <- factor(rep(c("Tesco", "Supervalu", "M&S", "Dunnes Stores"), c(100, 30, 25, 85))) 
par(mar = c(5, 7, 1, 2)) # Adjust the margins on the four sides of the plot
barplot(height = table(stores), main = "Stores in Ireland", xlab = "Number of stores", col = 1:4, horiz = TRUE, las = 1)

?barplot
?factor

# HISTOGRAMS
library(MASS) 
hist(birthwt$bwt)

# to spice it up:
hist(birthwt$bwt, breaks = 30, xlab = "Birth weight (grams)", 
     main = "Histogram of birth weight", col = "lightblue")

hist(birthwt$bwt, breaks = 10, xlab = "Birth weight (grams)", 
     main = "Histogram of birth weight", col = "lightblue")

#DENSITY PLOTS (continuous line version of a histogram)
# the density function is not a plotting fucntion but can be 
# called directly by plot

plot(density(birthwt$bwt))

# better version:
plot(density(birthwt$bwt), xlab = "Birth weight (grams)", 
     main = "Histogram of birth weight", col = "green", lwd = 4)

# BOXPLOTS
boxplot(birthwt$bwt ~ birthwt$race, ylab = "Birth weight (grams)", xlab = "Race")

# better:
boxplot(birthwt$bwt ~ birthwt$race, xaxt = "n", # xaxt = "n" removes the x axis 
        main = "Birth weight by race", col = 2:4, ylab = "Birth weight (grams)")
# Add the x axis with new labels:
axis(1, at = 1:3, labels = c("White", "Black", "Other"))

# PIE CHARTS (NOT IDEAL!!!)
pie(table(stores))

# multiple panels (through par)
par(mfrow = c(2, 2)) # creates a 2 by 2 plotting matrix which is then filled in by row
hist(birthwt$bwt, breaks = 30, xlab = "Birth weight (grams)",
     main = "Histogram of birth weight", col = "lightblue")
plot(density(birthwt$bwt), xlab = "Birth weight (grams)",
     main = "Histogram of birth weight", col = "green", lwd = 2)
boxplot(birthwt$bwt ~ birthwt$race, xaxt = "n", 
        main = "Birth weight by race", col = 2:4) 
pie(table(stores))

#####################
# Extended example - plot of fitted models for birth weight data

# Make it easier to access the data
birthwt
x <- birthwt$age
y <- birthwt$low

# Basic plot we're going to improve
plot(x, y)

# Set up the plot frame
par(mar = c(3, 3, 2, 1), mgp = c(2, 0.7, 0), las = 1)
plot(x, y, type = "n", xaxt = "n", yaxt = "n", 
     xlab = "Mother's age", ylab = "Low birth weight (probability)")
title("Risk factors associated with low infant birth weight")
axis(1, at = pretty(x, n = 10))
axis(2, at = pretty(y, n = 10))
grid()

# Add in the data
points(jitter(x, amount = 0.5), y, col = "blue", pch = 20)

# Add in the fitted line
mod <- glm(y ~ x, family = binomial)
xgrid <- seq(min(x), max(x), by = 1) 
ypred <- predict(mod, data.frame(x = xgrid), se.fit = TRUE, type = "response")
lines(xgrid, ypred$fit, col = "red", lwd = 2)

# Create a polygon with uncertainties in a translucent colour
newcol <- rgb(1, 0, 0, 0.2)
ypred.lower <- ypred$fit - 1.96 * ypred$se.fit
ypred.upper <- ypred$fit + 1.96 * ypred$se.fit
polygon(c(xgrid, rev(xgrid)), c(ypred.lower, rev(ypred.upper)), 
        col = newcol, border = NA)

# Add in the legend
legend("topright", legend = c("Data", "Fitted line", "95% CI"), pch = c(20, -1, 15), 
       lty = c(-1, 1, -1), lwd = c(-1, 2, -1), col = c("blue", "red", newcol))

# (f) Expand your plot so that each species is a different colour and include a legend. Include suitable command so that repeated points at the same location do not overlap . How does this plot help explain the answers you obtained in parts (c) and (d)?
plot(iris[,1],iris[,2],xlab='Sepal length',ylab='Sepal Width',
     main='Scatter plot of sepal length versus sepal width',las=1,type='n')
sep.setosa = as.matrix(subset(iris[,1:2],iris$Species=='setosa'))
sep.versicolor = as.matrix(subset(iris[,1:2],iris$Species=='versicolor'))
sep.virginica = as.matrix(subset(iris[,1:2],iris$Species=='virginica'))
points(jitter(sep.setosa),col='red')
points(jitter(sep.versicolor),col='blue')
points(jitter(sep.virginica),col='green')
legend('topright',legend=c('Setosa','Versicolor','Virginica'),col=c('red','blue','green'),pch=1)
# For each species each sepal petal/width pair has positive correlation but when combined together they have negative correlations
# This is Simpson's paradox!

# how maximums in lists

apply(Chicago, 1, max) # treat this is own function and put inside lapply
lapply(Weather, function(x) apply(x, 1, max))
lapply(Weather, apply, 1, max)
lapply(Weather, apply, 1, min)
sapply(Weather, apply, 1, max)
sapply(Weather, apply, 1, min)
