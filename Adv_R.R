# fin <- read.csv('Future-500.csv')
fin <- read.csv('Future-500.csv', na.strings = c(''))
head(fin)
tail(fin)
str(fin)
summary(fin)

# changing from non-factor to factor

fin$ID <- factor(fin$ID)
fin$Inception <- factor(fin$Inception)
str(fin)

# factor variable trap
# converting from factor to non-factor

# example with characters
a <- c('12', '13', '14', '12', '12')
a

b <- as.numeric(a)
b
typeof(b)

# example with factors (factor to numeric)

z <- factor(c('12', '13', '14', '12', '12')) # it's a factor
typeof(z) # integer is the factorization, not the actual numbers!!
y <- as.numeric(z) # WRONG!!!
y # we get numerics assigned to categories
typeof(y)

# HOW TO DO IT CORRECLTY:
# first convert to char, then to numeric

x <- as.numeric(as.character(z)) #!|!!!!!!!!!
x

# demo of how to deal with factors (shown on a non-factor)

fin$Profit <- factor(fin$Profit)
str(fin)
head(fin)

# now convert it back
fin$Profit <- as.character(fin$Profit)
head(fin)
fin$Profit <- as.numeric(fin$Profit)
head(fin)
str(fin)

# converting factors which should be numerical into those with
# sub() and gsub()

# sub() replaces first instance
# gsub() replaces all 

fin$Expenses <- gsub(' Dollars', '', fin$Expenses)
fin$Expenses <- gsub(',', '', fin$Expenses)
str(fin) # changes from factor into character!!!

fin$Profit <- as.character(fin$Profit)
fin$Profit <- as.character(fin$Profit)

fin$Revenue <- gsub('$', '', fin$Revenue)
# doesn't work because $ is a special char in R
fin$Revenue <- gsub('\\$', '', fin$Revenue)
fin$Revenue <- gsub(',', '', fin$Revenue)

fin$Growth <- gsub('%', '', fin$Growth)
head(fin)
str(fin)

fin$Revenue <- as.numeric(fin$Revenue)
fin$Growth <- as.numeric(fin$Growth)
fin$Expenses <- as.numeric(fin$Expenses)
str(fin)
summary(fin)

# footnote on selecting columns
fin[[2]] # returns columns as a vector
fin[2] # returns column as a data frame with one column
head(fin[c(2, 4, 6)])

# dealing with missing data
?NA
# NA is a logical constant, it means we don't know if false of true
TRUE == FALSE
TRUE == 5
TRUE == 1
FALSE == 0
NA == TRUE
NA == FALSE
NA == NA
NA == 15
# na means a value we don't know

# elegant way to locate missing data
head(fin, 24)
fin[is.na(fin) == TRUE,]  ## ehhh not really
complete.cases(fin)
fin[complete.cases(fin),] # gives only rows without NA
# to get the opposite 
fin[complete.cases(fin) == F,]
# OR
fin[!complete.cases(fin),]
# BUT that doesn't give all of them!!!
# because some rows are empty, not NA and R doesn't find them in this function
# to do this, when we import data, we change empties to NA
fin <- read.csv('Future-500.csv', na.strings = c(''))
fin[complete.cases(fin) == F,] # more rows now
# some NA have brackets because they are factors

# using which() for non-missing data - filtering
head(fin)
fin$Revenue == 9746272
fin[fin$Revenue == 9746272,]  # NA messing it up
fin[which(fin$Revenue == 9746272),]  # correct way to do it
?which
fin[fin$Employees == 45,] # adds NA rows
fin[which(fin$Employees == 45),]  #correct

# filtering: is.na() for missing data
fin$Expenses == NA
fin[fin$Expenses == NA,]  # doens't make sense
fin[is.na(fin$Expenses) == T,] # also wrong
fin[is.na(fin$Expenses),] # rows with NA in expenses column
fin[is.na(fin$State),] 
fin[is.na(fin$Inception),] 
fin[is.na(fin$Industry),] 

# removing records with missing data
fin_backup <- fin
# want to remove rows with empty industry
fin[!complete.cases(fin),]
fin[is.na(fin$Industry),]
fin[!is.na(fin$Industry),] # create filtered version of what we want
fin <- fin[!is.na(fin$Industry),] # replace old frame with the above subset
head(fin, 20)

# resetting the dataframe index (row names)
rownames(fin) <- 1:nrow(fin)
head(fin, 20)
tail(fin)
# or we could do with same result
rownames(fin) <- NULL

save(fin, file='fin.RData')
load('fin.RData', envir = parent.frame())

# replacinf missing data: factual analysis
#state column
fin[!complete.cases(fin),]
fin[is.na(fin$State),]

# CORRECTING COLUMN BASED ON ROW FILERING !!!!!!
fin[is.na(fin$State) & fin$City =='New York', 'State'] <- 'NY'
fin[fin$City == 'New York', ] # checking

fin[!complete.cases(fin),]

fin[is.na(fin$State) & fin$City =='San Francisco', 'State'] <- 'CA'
fin[fin$City == 'San Francisco', ] # checking

fin[!complete.cases(fin),]

# median imputation
fin[fin$Industry == 'Retail',]
med_empl_retail <- median(fin[fin$Industry == 'Retail', 'Employees'], na.rm =T)
fin[is.na(fin$Employees),]
fin[is.na(fin$Employees) & fin$Industry == 'Retail',]
fin[is.na(fin$Employees) & fin$Industry == 'Retail', 'Employees'] <- med_empl_retail
fin[3,] # checking

med_empl_services <- median(fin[fin$Industry == 'Financial Services', 'Employees'], na.rm =T)
med_empl_services
fin[is.na(fin$Employees) & fin$Industry == 'Financial Services',]
fin[is.na(fin$Employees) & fin$Industry == 'Financial Services', 'Employees'] <- med_empl_services
fin[330,]


save(fin, file='fin.RData')
fin[!complete.cases(fin),]

save(fin, file='fin.RData')

fin[is.na(fin$Growth) & fin$Industry == 'Construction',]
med_growth_constr <- median(fin[fin$Industry == 'Construction', 'Growth'], na.rm = T)
med_growth_constr
median(fin[fin$Industry == 'Construction', 'Growth'], na.rm = T)
fin[is.na(fin$Growth) & fin$Industry == 'Construction', 'Growth'] <- med_growth_constr
fin[8,]
fin[!complete.cases(fin),]
save(fin, file='fin.RData')

fin[is.na(fin$Revenue),]
fin$Revenue
med_rev.constr <- median(fin[fin$Industry == 'Construction', 'Revenue'], na.rm = T)
med_rev.constr
fin[is.na(fin$Revenue) & fin$Industry == 'Construction', 'Revenue'] <- med_rev.constr
fin[8,]
fin[42,]

fin[is.na(fin$Expenses),]
med_exp_constr <- median(fin[fin$Industry == 'Construction', 'Expenses'], na.rm = T)
med_exp_constr
fin[is.na(fin$Expenses) & fin$Industry == 'Construction', 'Expenses'] <- med_exp_constr
fin[8,]
fin[42,]
save(fin, file='fin.RData')
fin[!complete.cases(fin),]

# deriving values
# Revenue - Expenses = Profit
# Expenses = Revenue - Profit

fin[is.na(fin$Profit),]
fin[is.na(fin$Profit), 'Revenue']
fin[is.na(fin$Profit), 'Expenses']
profit.calc <- fin[is.na(fin$Profit), 'Revenue'] - fin[is.na(fin$Profit), 'Expenses']
profit.calc
fin[is.na(fin$Profit), 'Profit'] <- profit.calc
fin[8,]
fin[42,]
fin_backup <- fin
fin[!complete.cases(fin),]

fin[is.na(fin$Expenses),]
fin[is.na(fin$Expenses), 'Expenses'] <- fin[is.na(fin$Expenses), 'Revenue'] - fin[is.na(fin$Expenses), 'Profit']
fin[!complete.cases(fin),]

# vusualisation
library(ggplot2)
p <- ggplot(data=fin)
p + geom_point(aes(x=Revenue, y=Expenses, colour=Industry, size=Profit))

d <- ggplot(data=fin, aes(x=Revenue, y=Expenses, colour=Industry))
d + geom_point() +
  geom_smooth(fill=NA, size=1.2)

f <- ggplot(data=fin, aes(x=Industry, y=Growth, colour=Industry))
f + geom_boxplot(size = 1)

f + geom_jitter() +
  geom_boxplot(size = 1, alpha=0.5, outlier.colour=NA)

save(fin, file='fin.RData')

################################################

util <- read.csv('Machine-Utilization.csv')
util
head(util)
str(util)
summary(util)

#drvie utilisation column
util$utilisation = 1- util$Percent.Idle
save(util, file='util.RData')

# handling date-time 
tail(util)
?POSIXct
# convert time data to POSIXct
util$PosixTime <- as.POSIXct(util$Timestamp, format = '%d/%m/%Y %H:%M')
head(util)
summary(util)

# TIP: rearranging columns
util$Timestamp <- NULL
util <- util[,c(4,1,2,3)] # changing order of columns
head(util, 20)

# subsetting
RL1 <- util[util$Machine=='RL1',]
summary(RL1)
RL1$Machine <- factor(RL1$Machine) # getting rid of legacy factors
summary(RL1)

save(RL1, file='RL1.RData')

# construct list:
# machine name
# vector of utilisation (min, mean, max)
# logical: has utilisation fallen below 90%

util_stats_rl1 <- c(min(RL1$utilisation, na.rm=T),
                    mean(RL1$utilisation, na.rm=T),
                    max(RL1$utilisation, na.rm=T))

util_stats_rl1
RL1$utilisation < 0.90
length(which(RL1$utilisation < 0.90))
any(which(RL1$utilisation < 0.90))

util_under_90_flag <- any(which(RL1$utilisation < 0.90)) # which ignores NAs
util_under_90_flag 

list_RL1 <- list('RL1', util_stats_rl1, util_under_90_flag)
list_RL1

load('RL1.RData', envir = parent.frame())
save(list_RL1, file='list_RL1.RData')

# naming components of a list
names(list_RL1)
names(list_RL1) <- c('Machine', 'Stats', 'LowThreshold')
list_RL1
## another way, like with data frames
rm(list_RL1)
list_RL1 <- list(Machine='RL1', Stats=util_stats_rl1, LowThreshold=util_under_90_flag)
list_RL1

# extracting components of a list
# 3 ways
#[] - always returns a list
#[[]] - always returns the actual object
#$ - same as [[]] but prettier

list_RL1[2]
list_RL1[[2]]
list_RL1$Stats
typeof(list_RL1[2])
typeof(list_RL1[[2]]) # vector of doubles
typeof(list_RL1$Stats)

# to access specific element of a vector that's part of the list
list_RL1$Stats[3]
list_RL1[[2]][3]

# add and delete components
list_RL1
list_RL1[4] <- 'New information'
list_RL1
# another way:
list_RL1$UnknownHours <-RL1[is.na(RL1$utilisation), 'PosixTime']
list_RL1

list_RL1[11] <- 'New information2'
list_RL1

list_RL1[4] <- NULL
list_RL1

list_RL1[5:10] <- NULL
list_RL1

# add another component
list_RL1$Data <- RL1
list_RL1
summary(list_RL1)
str(list_RL1)
list_RL1$UnknownHours[1]
list_RL1[[4]][1]

# subsetting a list (use single brackets) - creating a subset list
list_RL1[1]
list_RL1[1:2]
list_RL1[1:3]
list_RL1[c(1,4)]
list_RL1[c('Machine', 'Stats')]
# double square brackets are not for subsetting
# double square brackets are for accessing list elements 
save(list_RL1, file='list_RL1.RData')
load('list_RL1.RData', envir = parent.frame())

# time series plot
library(ggplot2)
p <- ggplot(data=util)
p + geom_line(aes(x=PosixTime, y=utilisation, colour=Machine), size=1.2) +
facet_grid(Machine~.) +
  geom_hline(yintercept=0.90, colour='Gray', size=1.2,
             linetype=3)
myplot <- p + geom_line(aes(x=PosixTime, y=utilisation, colour=Machine), size=1.2) +
  facet_grid(Machine~.) +
  geom_hline(yintercept=0.90, colour='Gray', size=1.2,
             linetype=3)

list_RL1$Plot <- myplot

list_RL1


######### apply family

Chicago <- read.csv('Chicago-F.csv', row.names=1)
Chicago
NewYork <- read.csv('NewYork-F.csv', row.names=1)
Houston <- read.csv('Houston-F.csv', row.names=1)
SanFrancisco <- read.csv('SanFrancisco-F.csv', row.names=1)
NewYork
Houston
SanFrancisco

is.data.frame(Chicago)

# convert to matrix, all elements are the same
Chicago <- as.matrix(Chicago)
NewYork <- as.matrix(NewYork)
Houston <- as.matrix(Houston)
SanFrancisco <- as.matrix(SanFrancisco)

is.matrix(Chicago)

save(Chicago, file='Chicago.RData')
save(NewYork, file='NewYork.RData')
save(Houston, file='Houston.RData')
save(SanFrancisco, file='SanFrancisco.RData')

# place in a list

Weather <- list(Chicago=Chicago, NewYork=NewYork, Houston=Houston, SanFrancisco=SanFrancisco)
Weather
Weather[[3]]
Weather[3]
Weather[[3]][,1]
Weather[[3]][1,]
Weather[[3]][1,11]
Weather[[3]][1, 'Nov']
save(Weather, file='Weather.RData')

# APPLY FAMILY
# apply - use on matrix
# tapply - use on a vector to extract subgroups and apply a function to them (use on 
# factors)
# by - use on data frames
# lapply - apply function to elements of a list
# sapply - a version of lapply. Can simplify the result so it's not presented as a list
# vapply - returns a vector
# replicate - runs a function several times

Weather
Chicago
apply(Chicago, 1, mean)
mean(Chicago['DaysWithPrecip',])

apply(Chicago, 1 , max)
apply(Chicago, 1 , min)
t(Chicago)

# compare cities
apply(Chicago, 1, mean)
apply(NewYork, 1, mean)
apply(Houston, 1, mean)
apply(SanFrancisco, 1, mean)

load('Chicago.RData', envir = parent.frame())
load('NewYork.RData', envir = parent.frame())
load('Houston.RData', envir = parent.frame())
load('SanFrancisco.RData', envir = parent.frame())

# recreate with loops
Chicago

# find mean of each row
# via loop

output <- NULL
for(i in 1:5){
  output[i] <- mean(Chicago[i,])
}
output
names(output) <- rownames(Chicago)
output

# via apply
apply(Chicago, 1, mean)

# using lappy
?lapply
t(Chicago)
Weather
lapply(Weather, t)
mynewlist <- lapply(Weather, t)

# example 2

rbind(Chicago, NewRow=1:12)
lapply(Weather, rbind, NewRow=1:12) # with optional parameter

# example 3
?rowMeans
lapply(Weather, rowMeans)
apply(Weather, rowMeans)

# combining lapply with [] operator
  Weather
Weather[[1]][1,1]
Weather$Chicago[1,1]

lapply(Weather, '[', 1, 1) # [ is a function; 1 ,1 are optional parameters for it
lapply(Weather, '[', 1, )
lapply(Weather, '[', ,'Mar')

# adding your own functions
lapply(Weather, rowMeans)
lapply(Weather, mean) # not useful stat

lapply(Weather, function(x) x[1,])
lapply(Weather, function(x) x[5,])
lapply(Weather, function(x) x[,12])

lapply(Weather, function(z) z[1,] - z[2,]) # difference between high and low temperature

lapply(Weather, function(z) round((z[1,] - z[2,]) / z[2,],2))

# sapply
# avg high for July:
lapply(Weather, '[', 1, 'Jul')
sapply(Weather, '[', 1, 'Jul')

# average high for Q4:
lapply(Weather, '[', 1, c(10, 11, 12))
sapply(Weather, '[', 1, c(10, 11, 12))    

# another example:
lapply(Weather, rowMeans)
round(sapply(Weather, rowMeans),2)

# 
lapply(Weather, function(z) round((z[1,] - z[2,]) / z[2,],2))
sapply(Weather, function(z) round((z[1,] - z[2,]) / z[2,],2))

# 
sapply(Weather, rowMeans, simplify=F)

# nesting apply functions
lapply(Weather, rowMeans)

# how to get row maximums
Chicago
apply(Chicago, 1, max) # treat this is own function and put inside lapply
lapply(Weather, function(x) apply(x, 1, max))
lapply(Weather, apply, 1, max)
lapply(Weather, apply, 1, min)

sapply(Weather, apply, 1, max)
sapply(Weather, apply, 1, min)


# which.max
# when we want to get months with highest/lowest
load('Weather.RData', envir = parent.frame())

which.max(Chicago[1,])
names(which.max(Chicago[1,]))

apply(Chicago, 1, function(x) names(which.max(x)))
lapply(Weather, function(y) apply(y, 1, function(x) names(which.max(x))))
sapply(Weather, function(y) apply(y, 1, function(x) names(which.max(x))))


sapply(Weather, apply, 1, which.max)
sapply(Weather, apply, 1, which.min)

#