student.height <- c(100, 106, 121, 111, 109, 111, 103, 117, 114)
student.height1 <- c(100, 106, 121, 111, 109, 111, 103, 117, 114, NA, 1047) 
mean(student.height1)
mean(student.height1, na.rm = T)
# what about the large value? 1047?
# remove extreme values. Trim() can remove specified amount of data
mean(student.height1, na.rm = T, trim= 0.1)
# trim = 0.1 removes 10% from top and bottom

# median
median(student.height)

# mode: can find mode with table (no separate finction for mode)
table(student.height)

plot(student.height)

sort(a, decreasing = T)
sort(a, decreasing = T)[1]  # getting just the first element!!

range(student.height) # gives lowest and highest value

quantile(student.height) # gives min, max and quartiles

IQR(student.height) # interquartile range

sd(student.height) # sample standard population  / (n-1)

# figuring out population SD:
n <- length(student.height)
sd(student.height) * sqrt((n-1)/n)

# ASS 1
m1 <- c(151.2, 150.5, 149.2, 147.5, 152.9, 152.0, 151.3, 149.7, 149.4, 150.7)
m2 <- c(151.9, 151.4, 150.3, 151.2, 151.0, 150.2, 151.2, 151.4, 150.4, 151.7)

mean(m1)
mean(m2)
sd(m1)
sd(m2)
par(mfrow=c(1,2))
hist(m1, main="Machine 1", xlim = c(145, 155))
hist(m2, main="Machine 2", xlim = c(149, 153))

#############

class(m1)
d <- c(TRUE, TRUE, FALSE)
as.numeric(d)

e <- c(0, 1, 33, 78)
as.logical(e)

num.d <- c(seq(1,10))
num.d
num.e <- c(seq(1,10, by= 3))
num.e
num.e[2]
num.e[-1]
num.a <- c(1,2,4,6,7)
names(num.a) <- c("a", "b", "c", "d", "e")
num.a
num.a['d']

# factors
student.height <- c(100, 106, 121, 111, 109, 111, 103, 117, 114) 
summary(student.height)
airports <- c('DEL', 'CAL', 'NYC', 'CAL', 'DEL', 'DEL') 
summary(airports)
airport.fact <- factor(airports)  # factor changes characters into categories
table(airport.fact)
summary(airport.fact)
?factor

birth.month = c("March","April","January","November","January",
                "September","October","September","November",
                "August", "January","November","November","February",
                "May","August", "July","December","August","August",
                "September","November", "February","April")
summary(birth.month)

# what if our data is ordinal and we want to have ordered factors
birth.month.fact <- factor(birth.month)
summary(birth.month.fact) # not in order

birth.month.fact <- factor(birth.month, ordered = TRUE, 
  levels = c("January","February","March","April", 
             "May","June", "July","August", "September", "October", 
             "November", "December"))

summary(birth.month.fact) 

# list
a <- c(1,4,6)
b <- c('Red', 'Green') 
c <- "Welcome"

# list can bundle all of the above
my.list <- list(a,b,c)
my.list
my.list.n <- list(Pieces = a, Colors = b, Message = c) # adding names to list
my.list.n
my.list.n['Pieces']
my.list.n[2]
my.list.n$Message

# matrix
# matrix is two dimensional data (all data must agree in type)

stu.hours <- c(20,24,46,62,22,37,45,27,65,23) 
stu.marks <- c(40,55,69,83,27,44,61,33,71,37)
stu.data <- c(stu.hours,stu.marks) 
stu.data
stu.matrix <- matrix(stu.data)
stu.matrix
# Add the argument nrows to create 10 rwos
stu.matrix <- matrix(stu.data, byrow = FALSE, nrow = 10)
stu.matrix
table(stu.hours, stu.marks) #????
table(stu.hours)
table(stu.marks)
stu.matrix <- matrix(stu.data, nrow = 10) # same result as this is default way
stu.matrix
colnames(stu.matrix) <- c('Hours', 'Marks')
rownames(stu.matrix) <- c(1:10)
stu.matrix
stu.matrix[1,1]
stu.matrix[3:6,2]

# data frame

stu.name <- c('Mr1', 'Ms2', 'Ms3', 'Mr4', 'Ms5', 'Ms6', 'Mr7', 'Ms8', 'Mr9', 'Mr10')
stu.hours <- c(20,24,46,62,22,37,45,27,65,23)
stu.marks <- c(40,55,69,83,27,44,61,33,71,37)
stu.male <- c(T,F,F,T,F,F,T,F,T,T)

stu.data <- data.frame(stu.name, stu.hours, stu.marks, stu.male) 
stu.data
summary(stu.data)
mean(stu.data$stu.marks)
mean(stu.data$stu.hours)
stu.data[3,1]
stu.data[3,]
stu.data[stu.data$stu.hours > 30,]
stu.data[stu.data$stu.male ==F,2:3]
stu.data[,2]
data()

# ASS 2

d <- c(151.2, 150.5, 149.2, 147.5, 152.9, 152.0, 151.3, 149.7, 149.4, 150.7)
mean(d)
?seq
df <- seq(5,499, 2)
df
stu.hours <- c(20,24,46,62,22,37,45,27,65,23)
stu.marks <- c(40,55,69,83,27,44,61,33,71,37)
pp <- data.frame(stu.hours, stu.marks)
pp

# visualisation
a <- c(10,13,14,10,12,17) 
b <- c(15,17,19,13,13,19)
par(mfrow = c(1, 1))
plot(a,b, pch= 17)

install.packages("nycflights13")
library(nycflights13)
nycflights13::flights
nycflights13::planes
attach(nycflights13::flights) # simplifies references
plot(arr_delay, dep_delay, main = 'Arrival vs Departure Delay',
     xlab = 'arrival delay in mins', ylab = 'departure delay in mins') 
# large data, plot takes long

# adding trend lines
plot(arr_delay, dep_delay, main = 'Arrival vs Departure Delay',
     xlab = 'arrival delay in mins', ylab = 'departure delay in mins', pch=3) 
abline(0, 1)

?abline

# different pch for different group!!
# to do this, we need to filter data

plot(arr_delay[carrier == 'UA'], dep_delay[carrier == 'UA'], main = 'Arrival vs Departure Delay',
     xlab = 'arrival delay in mins', ylab = 'departure delay in mins', col = 'dark red') 
points(arr_delay[carrier == 'AA'], dep_delay[carrier == 'AA'], pch = 5, col = 'blue')

summary(flights)

# partitioning the window for two plots + changing scales

par(mfrow = c(1, 2))
plot(arr_delay[carrier == 'UA'], dep_delay[carrier == 'UA'], main = 'UA',
     xlab = 'arrival delay in mins', ylab = 'departure delay in mins', xlim = c(0,1000), ylim = c(0,1000),
     col = 'dark red') 
plot(arr_delay[carrier == 'AA'], dep_delay[carrier == 'AA'], main = 'AA',
     xlab = 'arrival delay in mins', ylab = 'departure delay in mins', 
     xlim = c(0,1000), ylim = c(0,1000), col = 'dark green') 

# adding text

par(mfrow = c(1, 1))

plot(arr_delay[carrier == 'UA'], dep_delay[carrier == 'UA'], main = 'Arrivals vs Departure Delay',
     xlab = 'arrival delay in mins', ylab = 'departure delay', 
      col = 'dark red') 
text(x = 100, y = 400, label = 'United Airways')
text(x = 100, y = 300, label = 'United Airways', adj= 1)
text(x = 400, y = 5, label = "Jo's graph", adj= 1)
mtext(text="UA = United Airways", side=3) 
mtext(text="in minutes", side=2, adj=1)
abline(h=250) 
abline(v=250)
abline(h=0)
abline(v=0)

#editing sizes 
par(mfrow = c(1, 1))
plot(arr_delay[carrier == 'UA'], dep_delay[carrier == 'UA'], main = 'Arrivals vs Departure Delay',
     col = 'red', cex = 1.5) 
plot(arr_delay[carrier == 'UA'], dep_delay[carrier == 'UA'], main = 'Arrivals vs Departure Delay',
     col = 'red', cex = 0.5, col.main = 'dark red', font.main = 3, col.lab = 'green', font.lab = 4) 
points(arr_delay[carrier == 'AA'], dep_delay[carrier == 'AA'], pch = 5, cex = 0.5, col = 'green')

library(nycflights13)
attach(nycflights13::flights) 

# multiple scatterplots together
pairs(~ arr_delay + dep_delay)
pairs(~ distance + dep_delay + arr_delay + air_time) # very slow

# time series
# in time series, x is the time so we only define y variable
# so DONT give variable containing time, R does it automatically 
library(nycflights13)
weather
plot(weather$year, weather$avg_temp) # wrong
plot(weather$temp)


# histogram

library(nycflights13)
nycflights13::flights
attach(nycflights13::flights) 

hist(distance)
hist(distance, breaks = 10)
hist(distance[carrier == 'UA'])
hist(distance[carrier == 'AA'])

head(swiss)
hist(swiss$Fertility) 
hist(swiss$Fertility[swiss$Catholic]) # does this make sense??

# box plot
nycflights13::flights
attach(nycflights13::flights)
# boxplot for distance:
boxplot(distance)

par(mfrow = c(1, 2))
boxplot(distance[carrier == 'UA'], main = 'UA')
boxplot(distance[carrier == 'AA'], main = 'AA')

boxplot(distance[carrier == 'UA'], main = 'UA', ylim = c(0, 5000))
boxplot(distance[carrier == 'AA'], main = 'AA', ylim = c(0, 5000))

par(mfrow = c(2, 2))
boxplot(distance[carrier == 'UA'], main = 'UA', ylim = c(0, 5000))
boxplot(distance[carrier == 'AA'], main = 'AA', ylim = c(0, 5000))
hist(distance[carrier == "UA"], main="UA",
     breaks = c(0, 1000, 2000, 3000, 4000, 5000), xlim = c(0,5000), ylim = c(0,25000),
     xlab= 'distance')
hist(distance[carrier == "AA"], main="AA",
     breaks = c(0, 1000, 2000, 3000, 4000, 5000), xlim = c(0,5000), ylim = c(0,25000),
     xlab= 'distance')

# boxplot of distance by carrier:
par(mfrow = c(1, 1))
boxplot(distance ~ carrier)
# after tilda we put categorical data by which we want to split


# Practice
Nile
plot(Nile, main = 'Nile River Annual Flow', xlab = 'Year', ylab = 'Flow')
abline(h=mean(Nile))
text(x = 1930, y= 1200, adj =0, paste('Average flow:', mean(Nile)))

# DESCRIPTIVE STATS
library(psych)
?psych
library(nycflights13)
attach(nycflights13::flights) 

mean(distance) # for 300,000 flights from nycflights13
summary(distance) #can use summary on one column!!!
describe(distance)

# we want describe for 3 colums:
demo <- cbind(arr_delay, dep_delay, distance)
head(demo)
describe(demo)
colnames(demo) <- c('Arrival delay', 'Departure Delay', 
                    'Distance Travelled') 
describe(demo)

# describe by:
describeBy(distance, group =carrier)

0.039 < 0.05
0.25 > 0.05
0.135 > 0.10

# central limit theorem
r <- runif(10000)
r
plot(r)  #???
hist(r)
meanr <- mean(r)
sdr <- sd(r)

sample(r, 4)
cl4 <- mean(sample(r, 4))
cl4

# drawing more samples and plotting the mean of those (sampling distribution
# of the mean)


cl4 <- mean(sample(r, 4)) # mean of one sample
for (i in 1:100){
  cl4 <- c(cl4, mean(sample(r, 4)))
} 
for (i in 1:100){
  cl4 <- c(cl4, mean(sample(r, 4)))
} # drawing 1000 samples and appending their means to the vector
print(cl4)
hist(cl4)


cl9 <- mean(sample(r, 9)) # mean of one sample
cl9
for (i in 1:100){
  cl9 <- c(cl9, mean(sample(r, 9)))
} 
hist(cl9)


cl100 <- mean(sample(r, 100)) # mean of one sample

for (i in 1:100){
  cl100 <- c(cl100, mean(sample(r, 100)))
} 
hist(cl100)

meancl4 <- mean(cl4)
sdcl4 <- sd(cl4)
meancl9 <- mean(cl9)
sdcl9 <- sd(cl9)
meancl100 <- mean(cl100)
sdcl100 <- sd(cl100)


# summarise


par(mfrow = c(2,2))
hist(r, main = "1 Sample") 
mtext(sdr, side=3) 
mtext(meanr, side=4)
hist(cl4, main = "4 Samples") 
mtext(sdcl4, side=3)
mtext(meancl4, side=4)
hist(cl9, main="9 samples") 
mtext(sdcl9, side=3) 
mtext(meancl9, side=4)
hist(cl100, main="100 sample") 
mtext(sdcl100, side=3) 
mtext(meancl100, side=4)

# normal distribution functions

summary(table(fac1,fac2)) #create random numbers
# finding probabilities (as in table 4)
pnorm(-2) # area under curve to the left of -2
qnorm(0.02275013) # when we know the probability and want to find the related z value
                  # finding z values for percentiles
qnorm(0.90) # gives 90th percentile z value
dnorm(0) # takes values from x axis and gives the corresponding values on the y axis
dnorm(1)
dnorm(-1)
?dnorm

1- pnorm(-2)
qnorm(0.05)

zvalue <- seq(-4.0, 4.0, by=0.1)
x4 <- dnorm(zvalue)
plot(x4)
plot(zvalue, dnorm(zvalue), type= 'l')

pnorm(-3)
1- pnorm(3)
2 * pnorm(-3)

# visualise package

library(visualize)

visualize.norm(-2) # -2 refers to z value (area to the left of the given value)
?visualize.norm
visualize.norm(-3) 

# area to the left and right of z
visualize.norm(c(-3, 3), section = 'tails')
visualize.norm(c(-3, 3), section = 'bounded')
visualize.norm(c(-1.2727, 1.2727), section = 'bounded')

visualize.norm(stat = 76, mu = 75, sd = 1.4, section = 'upper')
visualize.norm(stat = 76, mu = 75, sd = 1.4)

visualize.norm(c(-0.887, 1.6), section = 'tails')

# subset
library(MASS)
Cars93

# Select the model name for cars that can 
# exceed 30 miles per gallon (MPG) in the city

subset(Cars93, select=Model, subset=(MPG.city > 30))
subset(Cars93, subset=(MPG.city > 30))
?subset

#Select the model name and price range for 
# four-cylinder cars made in the United States

subset(Cars93, select=c(Model, Min.Price, Max.Price), 
       subset=(Cylinders == 4 & Origin == 'USA'))

subset(Cars93, select=c(Manufacturer,Model), 
       subset=c(MPG.highway > median(MPG.highway)))

# removing NAs

# use na.omit to remove rows that contain any NA values
clean <- na.omit(dfrm)

#

# calculating z-score
Cars93
z <- (Cars93$Price - mean(Cars93$Price)) / sd(Cars93$Price)
z
# or better, shorter way with 'with
z <- with(Cars93, (Price - mean(Price)) / sd(Price))
z

########

v <- c(40,2,83,28,58)
f <- factor(c("A","C","C","B","C"))
split(v, f)
unstack(data.frame(v,f))

library(MASS)
split(Cars93$MPG.city, Cars93$Origin)
g <- split(Cars93$MPG.city, Cars93$Origin)
g
median(g[[1]])
median(g[[2]])
lapply(g, median)

################

by(trials, trials$sex, summary)

################

# linear model for 2 factors

models <- by(trials, trials$sex, function(df) lm(post~pre+dose1+dose2, data=df))

# confidence interval for the 2 models
lapply(models, confint)
?confint

?mapply

##  STRING OPERATIONS
length('Curly')
nchar('Curly') # gives no of characters

stooges <- c("Moe", "Larry", "Curly")
paste(stooges, "loves", "stats.")

substr("Statistics", 1, 4) # Extract first 4 characters
substr("Statistics", 7, 10) # Extract last 4 characters

ss <- c("Moe", "Larry", "Curly")
substr(ss, 1, 2)

cities <- c("New York, NY", "Los Angeles, CA", "Peoria, IL")
substr(cities, nchar(cities)-1, nchar(cities))

path <- "/home/mike/data/trials.csv"
strsplit(path, '/')

s <- "Curly is the smart one. Curly is funny, too." 
sub("Curly", "Moe", s)

s <- "Curly is the smart one. Curly is funny, too." 
gsub("Curly", "Moe", s)

sub(" and SAS", "", "For really tough problems, you need R and SAS.")

locations <- c("NY", "LA", "CHI", "HOU")
treatments <- c("T1", "T2", "T3")
outer(locations, treatments, paste, sep="-") # all possible combinations

s <- as.Date("2012-01-01")
e <- as.Date("2012-02-01") 
seq(from=s, to=e, by=1)
seq(from=s, by=1, length.out=7) # dates one week apart
seq(from=s, by="month", length.out=12) # first of month for one year
seq(from=s, by="3 months", length.out=4) # Quarterly dates for one year


############# PROBABILITY

choose(n, k)
choose(10, 2)

combn(1:5, 3)

rnorm(3, mean=c(-10,0,+10), sd=1)

set.seed(165) # Initialize the random number generator to a known state
runif(10)  # Generate ten random numbers
set.seed(165) # Reinitialize to the same known state
runif(10)  # Generate the same ten "random" numbers

# sampling
sample(c("H","T"), 10, replace=TRUE)
sample(v)

# probabilities for discreet distributions

# for simple probability, P(X=x) use density function:
dbinom(7, 10, 0.5)
# 7 successes, 10 trials

# for cumulative probability, P(X <= x), use the distribution function
pbinom(7, 10, 0.5)

# finding right-tailed probability (greater than) by specifying
# lower.tail=FALSE:
pbinom(7, 10, 0.5, lower.tail=FALSE)

# interval probability, P(x1 < X <= x2) is P(X<x2) - P(X<x1):
pbinom(7, 10, 0.5) - pbinom(3, 10, 0.5)

# can calculate multiple porbabilities in one call
pbinom(c(3,7), 10, 0.5)

# from this we can get interval probability with diff:
diff(pbinom(c(3,7), 10, 0.5))

diff(c(10, 25))
diff(c(25, 10))

# probabilities for continuous functions

# we want the probability that a man is shorter than 66 in,
# given that heights are normally distributed with mean of
# 70 and sd of 3 in:

pnorm(66, 70, 3)
pnorm(75, 70, 3)
1- pnorm(75, 70, 3)

# finding right-tailed probability (greater than) by specifying
# lower.tail=FALSE:

pnorm(75, 70, 3, lower.tail = FALSE)

# interval probability, P(x1 < X <= x2) is P(X<x2) - P(X<x1):
diff(pnorm(c(64, 67), 70, 3))
pnorm(67, 70, 3) - pnorm(64, 70, 3)

# getting quantiles
qnorm(0.05, 100, 15)
qnorm(0.10, 0, 1)

# plotting density functions
x <- seq(from=0, to=6, length.out=100) 
ylim <- c(0, 0.6) # Define the density domains
par(mfrow=c(2,2)) # Create a 2x2 plotting area 
plot(x, dunif(x,min=2,max=4), main="Uniform", type='l', ylim=ylim) # Plot a uniform density
plot(x, dnorm(x,mean=3,sd=1), main="Normal", type='l', ylim=ylim) # Plot a Normal density
plot(x, dexp(x,rate=1/2), main="Exponential", type='l', ylim=ylim) # Plot an exponential density
plot(x, dgamma(x,shape=2,rate=1), main="Gamma", type='l', ylim=ylim)  # Plot a gamma density

par(mfrow=c(1,1))

# with shaded area

x <- seq(from=-3, to=+3, length.out=100)
y <- dnorm(x)
plot(x, y, main="Standard Normal Distribution", type='l', 
     ylab="Density", xlab="Quantile") 
abline(h=0)

# The body of the polygon follows the density curve where 1 <= z <= 2 
region.x <- x[1 <= x & x <= 2]
region.y <- y
# We add initial and final segments, which drop down to the Y axis
region.x <- c(region.x[1], region.x, tail(region.x,1)) 
region.y <- c( 0, region.y, 0)
polygon(region.x, region.y, density=10)
polygon(region.x, region.y, density=-1, col="red")

#######################################

# how to get summary of a list:
lapply(vec.list, summary)

# testing categorical variables for independence:
# use table() to produce contingency table, then
# use summary() to get chi-squared test

summary(table(fac1,fac2))

# getting quantiles:
d <- rnorm(100, 50, 5)
d
quantile(d, c(0.05, 0.95)) # gives middle 90% of observations
quantile(d)

# converting to z-scores
scale(d) #!!!!!!!!

# testing the mean of ther sample t test
t.test(d, mu=70)
t.test(d, mu=90)
t.test(d, mu=58)
t.test(d, mu=53)
t.test(d, mu=51)
t.test(d, mu=50)
t.test(d, mu=41)

# confidence interval for a mean
x <- rnorm(50, mean=100, sd=15) 
t.test(x)
t.test(x, conf.level = 0.99)

# confidence interval for a median - wilcox.test()

wilcox.test(x, conf.int = TRUE)

# testing a sample proportion
# Cubs have played 20 games and won 11 of them, or 55% of their games. 
# Based on that a fan is “confident” that the Cubs will win more than 
# half of their games this year. Should he be  confident?

# prop.test(x, n, p): the number of observations is n = 20, 
# the number of successes is x = 11, and p is the true probability of 
# winning a game. We want to know whether it is reasonable to conclude that
#  p > 0.5. Normally, prop.test would check for p ≠ 0.05 but we can check 
# for p > 0.5 instead by setting alternative="greater":

prop.test(11, 20, 0.5, alternative="greater")
prop.test(11, 20, 0.5)
prop.test(2, 20, 0.5) # would reject in this case

# confidence interval for a proportion
prop.test(6, 9)

# testing for normality
shapiro.test(x)  # large p-value = normal population

# testing for runs
library(tseries)
runs.test(x)  # p-value of less than 0.05 indicates sequence
# is likely not random
s <- sample(c(0,1), 100, replace=T) 
runs.test(as.factor(s)) # random

s <- c(0,0,0,0,1,1,1,1,0,0,0,0)
runs.test(as.factor(s)) # non random

# comparing the means of two population
t.test(x, s)

# correlation
cor(x, y) # gives correlation coefficient

# testing correlation for significance
cor.test(x, y)  # default is for Pearson correlation (normal distributions)

# testing groups for equal proportions (is prop of successes equal for both trials?)
successes <- c(14,10)
trials <- c(38,40)
prop.test(successes, trials)

# pairwise comparison between group means
pairwise.t.test(comb$values, comb$ind)

# testing two samples for the same distribution
ks.test(x, y)

##############################
#GRAPHICS

cars
plot(cars) # first column becomes x-axis

plot(cars, main="cars: Speed vs. Stopping Distance (1920)", xlab="Speed (MPH)",
     ylab="Stopping Distance (ft)")

# plot with grid
plot(cars, main="cars: Speed vs. Stopping Distance (1920)", xlab="Speed (MPH)",
     ylab="Stopping Distance (ft)", type='n')
grid()
points(cars)

# scatter plot for multiple groups, f is the vector that indicates groups
plot(x, y, pch=as.integer(f))
iris

plot(iris, Petal.Length, Petal.Width, pch=as.integer(Species)) #NO work

with(iris, plot(Petal.Length, Petal.Width, pch=as.integer(Species)))
with(iris, plot(Petal.Length, Petal.Width, col = Species))

# LEGEND
# Legend for points
legend(x, y, labels, pch=c(pointtype1, pointtype2, ...)) 
# Legend for lines according to line type
legend(x, y, labels, lty=c(linetype1, linetype2, ...))
# Legend for lines according to line width
legend(x, y, labels, lwd=c(width1, width2, ...))
# Legend for colors
legend(x, y, labels, col=c(color1, color2, ...))

with(iris, plot(Petal.Length, Petal.Width, pch=as.integer(Species)))
legend(1.5, 2.4, c("setosa","versicolor","virginica"), pch=1:3)

# or better, more flexible
f <- factor(iris$Species)
with(iris, plot(Petal.Length, Petal.Width, pch=as.integer(f)))
legend(1.5, 2.4, as.character(levels(f)), pch=1:length(levels(f)))

with(iris, plot(Petal.Length, Petal.Width, col = Species))
legend(1.5, 2.4, c("setosa","versicolor","virginica"), 
       col=c('black', 'red', 'green'), pch=19)

# PLOTTING REGRESSION LINE OF a SCATTER PLOT
# use abline()
m <- lm(y ~ x) 
plot(y ~ x)
abline(m)

library(MASS)
m <- lm(birthwt$low ~ birthwt$age) #meh
plot(birthwt$low ~ birthwt$age)
abline(m)

m <- lm(cars$dist ~ cars$speed)
plot(cars$dist ~ cars$speed)
abline(m)

Cars93
m <- lm(Cars93$EngineSize ~ Cars93$Price)
plot(Cars93$EngineSize ~ Cars93$Price)
abline(m)

# plotting all variables against all other variables
plot(iris[,1:4])

# scatterplot for each factor level
data(Cars93, package="MASS")
coplot(Horsepower ~ MPG.city | Origin, data=Cars93)

# bar chart
airquality
# bar chart of the mean temperature by month
heights <- tapply(airquality$Temp, airquality$Month, mean)
heights
barplot(heights)


barplot(heights, main="Mean Temp. by Month",
        names.arg=c("May", "Jun", "Jul", "Aug", "Sep"),
        ylab="Temp (deg. F)")

# adding confidence interval to a bar chart
library(gplots)
barplot2(x, plot.ci=TRUE, ci.l=lower, ci.u=upper)

attach(airquality)
heights <- tapply(Temp, Month, mean)
lower <- tapply(Temp, Month, function(v) t.test(v)$conf.int[1])
upper <- tapply(Temp, Month, function(v) t.test(v)$conf.int[2])
# basic:
barplot2(heights, plot.ci=TRUE, ci.l=lower, ci.u=upper)

barplot2(heights, plot.ci=TRUE, ci.l=lower, ci.u=upper, ylim=c(50,90), 
         xpd=FALSE, main="Mean Temp. By Month", names.arg=c("May","Jun","Jul","Aug","Sep"), 
         ylab="Temp (deg. F)")

# coloring bar charts
barplot(c(3,5,4), col=c("red","white","blue"))

rel.hts <- rank(heights) / length(heights)
grays <- gray(1 - rel.hts)
barplot(heights, col=grays)

rel.hts <- (heights - min(heights)) / (max(heights) - min(heights))
grays <- gray(1 - rel.hts)
barplot(heights, col=grays, ylim=c(50,90), xpd=FALSE, 
        main="Mean Temp. By Month", names.arg=c("May", "Jun", "Jul", "Aug", "Sep"),
        ylab="Temp (deg. F)")

# line plot
pressure
plot(pressure)
plot(pressure, type='l')
plot(pressure, type="l", lty="dashed")
plot(pressure, type='l', lwd=2)
plot(pressure, type='l', lwd=2, col='red')
# different colors for different variables
plot(x, y.democr, type="l", col="blue") 
lines(x, y.republ, col="red")
lines(x, y.indeps, col="yellow")

############
# one box plot for each factor level
library(MASS)
UScereal
boxplot(UScereal$sugars ~ UScereal$shelf)

boxplot(UScereal$sugars ~ UScereal$shelf, 
        main="Sugar Content by Shelf", 
        xlab="Shelf", ylab="Sugar (grams per portion)")

# histogram
hist(Cars93$MPG.city)
hist(Cars93$MPG.city, 20) # increase bin number

hist(Cars93$MPG.city, 20, main="City MPG (1993)", xlab="MPG")

# adding a density estimate (curve) to histogram
samp <- rgamma(500, 2, 2) 
hist(samp, 20, prob=T)
lines(density(samp))

# creating a discreet histogram (use table() to count occurences)
plot(table(x), type="h")
x <- c(2, 2, 3, 5, 6, 7, 2, 4, 5, 5, 5, 5, 1, 2, 1, 1, 3, 8, 9, 9, 4)
plot(table(x), type="h", lwd=5, ylab="Freq")

# checking for normality with quantile-quantile plot
# using the Price column from Cars93

data(Cars93, package="MASS")
qqnorm(Cars93$Price, main="Q-Q Plot: Price") 
qqline(Cars93$Price) # plot suggests skeweness to the left
# can be fixed with log(Price)
data(Cars93, package="MASS")
qqnorm(log(Cars93$Price), main="Q-Q Plot: log(Price)") 
qqline(log(Cars93$Price))

# graphing a function
curve(sin, -3, 3) # Graph the sine function from -3 to +3
curve(dnorm, -3.5, +3.5, main="Std. Normal Density")

f <- function(x) exp(-abs(x)) * sin(2*pi*x) 
curve(f, -5, +5, main="Dampened Sine Wave")

# saving plot to a file
png("myPlot.png", width=648, height=432) # Or whatever dimensions work for you 
plot(x, y, main="Scatterplot of X, Y")
dev.off()

###########################
# REGRESSION

# simple linear regression
lm(y ~ x)

lm(y ~ x, data=dfrm) # for data frame with x, y columns

# multiple linear regression
lm(y ~ u + v + w)

lm(y ~ u + v + w, data=dfrm)

# getting regression statistics
m <- lm(y ~ u + v + w)
summary(m)

# selecting the best regression variables
full.model <- lm(y ~ x1 + x2 + x3 + x4)
reduced.model <- step(full.model, direction="backward")

min.model <- lm(y ~ 1)
fwd.model <- step(min.model, direction="forward", scope=( ~ x1 + x2 + x3 + x4 ))

# regression on a subset of data
lm(y ~ x, subset=1:100) # Use only x[1:100]

lm(y ~ x, subset=(lab == "NJ"))

# using an expression inside a regression formula
lm(y ~ I(u + v))
lm(y ~ u + I(u^2))

# polynomial regression with poly()
lm(y ~ poly(x,3,raw=TRUE)) # cubic regression

# primitive equivalent
x_sq <- x^2
x_cub <- x^3
m <- lm(y ~ x + x_sq + x_cub)

# exact equivalent:
lm(y ~ x + I(x^2) + I(x^3))

# regressing on transformed data (x, y) don't have linear relationship
lm(log(y) ~ x)

# can also be the following (not sure what means):
lm(y ~ sqrt(x))
lm(log(y) ~ log(x))

# finding best power transformation box-cox procedure
# The procedure will identify a power, λ, such that 
# transforming y into yλ will improve the fit of your model:
library(MASS) 
m <- lm(y ~ x) 
boxcox(m)

x <- 10:100
eps <- rnorm(length(x), sd=5) 
y <- (x + eps)^(-1/1.5)
m <- lm(y ~ x)
summary(m)
# When plotting the residuals against the fitted values, 
#we get a clue that something is wrong:

plot(m, which=1) # Plot only the fitted vs residuals
# plot has parabolic shape, to fix:
library(MASS)
bc <- boxcox(m)
which.max(bc$y)
lambda <- bc$x[which.max(bc$y)]
lambda
# applying to model:
z <- y^lambda
m2 <- lm(z ~ x) 
summary(m2)
# or like this:
m2 <- lm(I(y^lambda) ~ x)

# forming confidence interval for regression coefficients
m <- lm(y ~ x1 + x2) 
confint(m)
confint(m, level=0.99)

# plotting regression residuals
# You can plot the model object by selecting 
# the residuals plot from the available plots:
plot(m, which=1)

# diagnosing a linear regression
m <- lm(y ~ x) 
plot(m) # plotting m will give several diagnostic plots

# identifying influential observations
influence.measures(m)

# testing residuals for auto-correlation
library(lmtest)
m <- lm(y ~ x) # Create a model object
dwtest(m) # Test the model residuals
acf(m)
# small p value means autocorrelation is likely positive

dwtest(m, alternative = 'two.sided') # test for negative correlation as well

# predicti8ng new values from regression model
m <- lm(y ~ u + v + w)
preds <- data.frame(u=3.1, v=4.0, w=5.5) 
predict(m, newdata=preds)

m # example for obe variable object m
summary(m)
preds <- data.frame(x=3.1) 
predict(m, newdata=preds)

# forming prediction interval
predict(m, newdata=preds, interval="prediction")

# one way ANOVA
# Use a factor to define the groups. Then apply the oneway.test function: 
oneway.test(x ~ f)
# Here, x is a vector of numeric values and f is a factor that identifies the groups. 

# or specify equal variances
oneway.test(x ~ f, var.equal = TRUE)

# alternative
m <- aov(x ~ f)
summary(m)

# interaction plot for multiway ANOVA
interaction.plot(pred1, pred2, resp)

# finding differences between means of groups
m <- aov(x ~ f) 
TukeyHSD(m)
plot(TukeyHSD(m))

# 
#TRICKS

# widen your output
options(width=numcols)
options(width=120) # default is 80

# combining vectors
cbind(x,y,Total=x+y)

# dividing data into bins
f <- cut(x, breaks)

x <- rnorm(1000)
breaks <- c(-3,-2,-1,0,1,2,3) 
f <- cut(x, breaks)
f
str(f)
summary(f)
f <- cut(x, breaks, labels=c("Bottom", "Low", "Neg", "Pos", "High", "Top"))

# finding the position of a particular value
vec <- c(100,90,80,70,60,50,40,30,20,10) 
match(80, vec)
which.min(vec)
which.max(vec)

# selecting every nth element of a vector
v[ seq_along(v) %% n == 0 ]
# if we want to select every other element, this is also possible:
v[ c(FALSE, TRUE) ]

# setting negative values to 0 in a vector using pmax
v <- c(-6,-7,5,90,-2,9,8,9,0,-22,-1,2,1)
v <- pmax(v, 0)
v

# generating all combinations of several factors
sides <- factor(c("Heads", "Tails"))
faces <- factor(c("1 pip", paste(2:6, "pips")))
expand.grid(faces, sides)

# flatten data frame
mean(as.matrix(dfrm)) # finds mean of all df values

# sorting a data frame using one column as the sort key
dfrm <- dfrm[order(dfrm$key),] # sort doesn' work on data frames

# sorting data frame by 2 columns
dfrm <- dfrm[order(dfrm$key1,dfrm$key2),]

# taking function arguments from a list
numbers <- list(1, 3, 5, 7, 9) 
mean(numbers)
mean(unlist(numbers))

# more difficult with multi level list structure
lists <- list(col1=list(7,8,9), col2=list(70,80,90), col3=list(700,800,900))

# Suppose we want to form this data into a matrix. The cbind function 
# is supposed to create data columns, but it gets confused by the list 
# structure and returns something useless:
# to solve this:
do.call(cbind, lists)
?do.call

# minimising or maximising a single parameter function
# to minimise:
optimize(f, lower=lowerBound, upper=upperBound)
# to maximize:
optimize(f, lower=lowerBound, upper=upperBound, maximum=TRUE)
# bounds are domain limits

f <- function(x) 3*x^4 - 2*x^3 + 3*x^2 - 4*x + 5 
optimize(f, lower=-20, upper=20)
# returns minimum: the x value that minimises the function and 
# objective: the value of function  at that point

f <- function(x) 3*x^4 - 2*x^3 + 3*x^2 - 4*x + 5 
optimize(f, lower=-20, upper=20, maximum=TRUE)
plot(f)

# minimising or maximising a multi parameter function
# To minimize a multiparameter function, use optim. 
# You must specify the starting point, which is a vector of initial arguments for f:
optim(startingPoint, f)

# To maximize the function instead, specify this control parameter:
optim(startingPoint, f, control=list(fnscale=-1))

f <- function(v) {
          a <- v[1]
          b <- v[2] 
          sum(abs(z - ((x + a)^b)))
              } 

# "Unpack" v, giving a and b
f
# This call to optim starts from (1, 1) and searches for the minimum point of f:
optim(c(1,1), f) # doesn't work

# principal component analysis
r <- prcomp( ~ x + y + z) 
summary(r)

# logistic regression
m <- glm(b ~ x1 + x2 + x3, family=binomial)

# Use the model object, m, and the predict function to predict a probability from new data:
dfrm <- data.frame(x1=value, x2=value, x3=value)
predict(m, type="response", newdata=dfrm)

# below we're predicting the variable test which is binary
data(pima, package="faraway")
b <- factor(pima$test)
m <- glm(b ~ diastolic + bmi, family=binomial, data=pima)
# look at estimate which gives probability
# once we know that one variable is significant, we can create reduced model
m.red <- glm(b ~ bmi, family=binomial, data=pima)

# Let’s use the model to calculate the probability that someone with an average BMI
# (32.0) will test positive for diabetes:
newdata <- data.frame(bmi=32.0)
predict(m.red, type="response", newdata=newdata)


