# changing a vector into factors
x <- c(5, 12, 13, 12) 
xf <- factor(x)
xf
str(xf)

# sopecifying additional factors
xf2 <- factor(x, levels = c(5, 12, 13, 88))
xf2
?factor
# if we haven't specified a level then we can't use it in a factor:
xf[2] <- 100
xf

# functions for factors: tapply

# Let’s suppose we have a list 
# of chick weight at 21 days together with a diet the chick received:

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

# multidimenional tables
birthwt3 <- data.frame(birthwt$low, birthwt$race, birthwt$smoke) 
table(birthwt3)

# multidimensional table is just an array

# accessing table
tab1 <- table(birthwt2) 
tab1
tab1[1, 2]

# We can perform scalar multiplication on a table
tab1 / sum(tab1) # gives proportions

# finding marginal counts by using apply:
apply(tab1, 1, sum)
?apply

# can do same with 'addmargins'

# The aggregate function calls tapply for each variable in a group
aggregate(birthwt$age, list(birthwt$race), mean)
# This is the mean age broken down by race. 
# We can aggregate over multiple variables if required.


