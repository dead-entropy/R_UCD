# data frame, calculate stats for columns by factors:
by(frd$Tonnage, frd$Power, mean)

# by function
# The function by works a bit like tapply but is applied to objects rather than vectors.
# by(x, f, g) where x is a data object, f is a factor on which to split the data into
# groups and g is a function to be applied to each group.

# vector, calculate stats by factors:
tapply(weight, diet, mean)

# findinx higest/ lowest
which.max()
which.min()
#or
sort(dframe['rownname',])[1] # max of row

# APPLY FAMILY
# apply - use on matrix
# tapply - use on a vector to extract subgroups and apply a function to them (use on 
# factors)
# by - use on data frames
# lapply - apply function to elements of a list, can use on data frame
# sapply - a version of lapply. Can simplify the result so it's not presented as a list
# vapply - returns a vector
# replicate - runs a function several times

aggregate(birthwt$age, list(birthwt$race), mean)
# This is the mean age broken down by race. 
by(birthwt$age, list(birthwt$race), mean) # same but returns a list
aggregate(data$weight, list(diet = data$Diet), mean)

######
# getting max of a row (or column) in list or matrix
lapply(Weather, apply, 1, max)
sapply(Weather, apply, 1, max)

#sweep does similar thing to aplly but is used when we need to apply different values
# to each row/column

# 3/3 matrix, we add 1 to row 1, 4 to row 2, 7 to row 3:
m <- matrix(1:9, 3, 3, byrow= TRUE)
m
sweep(m, 1, c(1,4,7), '+')

##### USE SWEEP to standarise all values in df
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

########################
# number of rows:
nrow(amazon[PublicationYear == 2014,]) / nrow(amazon)

# Max and min values
sum[order(sum$Reviews)[1],]  #this
sum[order(sum$Price, decreasing = TRUE)[1],]   #this
sum[which.min(sum$Reviews),]  #this
sum[which.max(sum$Price),]   #this

which.max(Chicago[1,])
names(which.max(Chicago[1,]))