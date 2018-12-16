amazon <- read.csv('AmazonBestSellers2014.csv', head = T)
head(amazon)
summary(amazon)
str(amazon)

amazon[amazon$PublicationYear == 2014,]
nrow(amazon[amazon$PublicationYear == 2014,])


amazon$PublicationYear <- factor(amazon$PublicationYear)

nrow(amazon[amazon$PublicationYear == 2014 & amazon$Publisher == 'Penguin',])

attach(amazon)

nrow(amazon[PublicationYear == 2014,]) / nrow(amazon)

table(PublicationYear) 
?aggregate
?by

#
?aggregate
sum <- aggregate(cbind(NumReviews, Price, Stars), list(Genre), mean)

colnames(sum) <- c('Genre', 'Reviews', 'Price', 'Rating')
sum
sort(sum$Reviews)[1]
sum[order(sum$Reviews)[1],]  #this
sum[order(sum$Price, decreasing = TRUE)[1],]   #this
sum[which.min(sum$Reviews),]  #this
sum[which.max(sum$Price),]   #this


##
par(mfrow=c(1,2))

boxplot(year$NumReviews, ylim = c(0, 7500), 
        main= '(2014)', ylab= 'Number of reviews', xlab= 'Books published', col = 'light green')
boxplot(year2$NumReviews, ylim = c(0, 7500), 
        main= '(pre-2014)', ylab = 'Number of reviews', xlab= 'Books published', col = 'light blue')

year <- amazon[PublicationYear == 2014,]
year2 <- amazon[PublicationYear != 2014,]

par(mfrow = c(1, 1)) # Restore default

##

?t.test
ChildrensBooks <- amazon[Genre == 'ChildrensBooks',]
ContemporaryFiction <- amazon[Genre == 'ContemporaryFiction',]

t.test(ChildrensBooks$Price, ContemporaryFiction$Price)
# ?????? conclusion

t.test(extra ~ group, data=sleep)
head(sleep)
##

mreg <- function(Y, X){
Y <- vector('numeric', length= n)
X <- matrix(NULL, 4, n)
}

year<- c(1, 2013, 2014, 2017, 2011)
revs <- c(1, 2, 4, 9, 42)
stars <- c(1, 3, 7, 5, 2)
pages <- c(1, 300, 345, 67, 987)

X <- cbind(year, revs, stars, pages)
X
Y <- c(34.55, 67, 8.77, 45.6)

out <- solve(t(X)%*%X) %*% (t(X)%*%Y)

out

X <- matrix()

x <- c(2015, 4, 7)
mreg(x)

y <- 1
Z <- c(y, D)
D <- c(2013, 4, 6)
Z

######################## 2

ships <- read.csv('FroudShips1907.csv', row.names =1, head=TRUE)
ships
attach(ships)
plot(LogTonnage[Power == 'Steam' | Power =='Sail'], 
     CrewSize[Power == 'Steam' | Power =='Sail'], col = Power)


#
shforplot <- ships[Froud$Power == 'Steam' | Froud$Power =='Sail',]
shforplot
?subset
subset(Froud, ships$Power == 'Steam' | ships$Power == 'Sail')

shforplot <- droplevels(shforplot, 'NotGiven')

plot(shforplot$LogTonnage, shforplot$CrewSize, col = shforplot$Power,
     xlab='Tonnage', ylab='Crew Size', main= ' Ship Crew Size per Tonnage')
legend(3.5, 30, as.character(levels(shforplot$Power)), col=shforplot$Power, pch=19)

#############

CrewSize

crewsizecat <- factor(CrewSize, levels = c("1-5","6-10","11-15","16-20", "21-25","26-30","31-35"))

crewsizecat <- factor(as.character(CrewSize), 
                      levels=c(0,5,10,15,20,25,30,35))

ct <- cut(CrewSize, breaks= c(0,5,10,15,20,25,30,35), labels = c("1-5","6-10","11-15","16-20", "21-25","26-30","31-35"))
ct

ct <- cut(CrewSize, breaks= 7, labels = c("1-5","6-10","11-15","16-20", "21-25","26-30","31-35"))
ct

crewsizecat <- cut(CrewSize, seq(0,35,5), labels = c("1-5","6-10","11-15","16-20", "21-25","26-30","31-35"))
ct

crewsizecat
ships2 <- ships
ships2$CrewSize <- crewsizecat
colnames(ships2)[4] <- c('Crewsizecat')
ships2
table(crewsizecat)

aggregate(ships2$Tonnage, list(ships2$Crewsizecat), mean)
mean.t <- tapply(ships2$Tonnage, ships2$Crewsizecat, mean)
sd.t <- tapply(ships2$Tonnage, ships2$Crewsizecat, sd)

mean.t 


aggregate(ships2$Tonnage, list(ships2$Crewsizecat), summary)
tapply(ships2$Tonnage, ships2$Crewsizecat, summary)

with(ships2, table(mean.t, sd.t))
with(ships2, table(mean.t))

#NEXT one KINDA works
aggregate(ships2$Tonnage, list(ships2$Crewsizecat), function(x) c(mean = mean(x), sd = sd(x)))

# c)

ships
Froud <- ships
TonnageData <- list(Froud)
class(Froud) <- c('TonnageData')
class(Froud)

stats.TonnageData <- function(frd, factor= frd$Power){
  list(mean = by(frd$Tonnage, factor, mean), 
       standard_deviation = by(frd$Tonnage, factor, sd))
}


stats.TonnageData <- function(frd, factor= frd$Power){
  list(mean = round(by(frd$Tonnage, factor, mean), 2), 
       round(standard_deviation = by(frd$Tonnage, factor, sd), 2))
} # where user can choose type of Power, slightly strange output

stats.TonnageData(Froud)
stats.TonnageData(Froud, Froud$Power == 'Steam')
stats.TonnageData(Froud)


summary.TonnageData <- function(frd){
  list(mean = by(frd$Tonnage, frd$Power, mean), standard_deviation = by(frd$Tonnage, frd$Power, sd))
} # best so far!!

summary.TonnageData <- function(frd){
  list(mean = round(by(frd$Tonnage, frd$Power, mean), 2), 
       standard_deviation = round(by(frd$Tonnage, frd$Power, sd), 2))
} 


summary(Froud)
stats.TonnageData(Froud)


paste('Mean for Froud:')
by(Froud$Tonnage, Froud$Power, mean) 
paste('SD for Froud:')
by(Froud$Tonnage, Froud$Power, sd) 

Froud
sapply(Froud[,"Tonnage"], mean)
colMeans(Froud)

by(Froud$Tonnage, Froud$Power, mean) # works good
paste('mean: ', by(Froud$Tonnage, Froud$Power, mean)) # no!
by(Froud$Tonnage, Froud$Power, sd) 

Froud$Tonnage
stats.TonnageData(Froud)

mean(Froud[,'Tonnage'])
aggregate(Froud$Tonnage, list(Froud$Power), mean) # works


# d
?glm

new <- subset(Froud, ships$Power == 'Steam' | ships$Power == 'Sail')
new

sup <- glm(new$CrewSize ~ new$Power + new$LogTonnage, family=poisson)
sup
sup2 <- glm(new$CrewSize ~ new$Power + new$LogTonnage - 1, family=poisson)
sup2 # gives coeff by ship type!!!
summary(sup)
summary(sup2)
sup$coef
plot(sup2) # both this and below gives same plot
plot(sup)
sup$fitted.values    

#####
#3
g <- 6
eval(exp(g))

D(expression(exp(x)), 'x')

DD <- function(y) { D(expression(exp(x)), 'x')
}


############
# 2017

#1 a

crimes15 <- read.csv("EuroStatCrime2015.csv", row.names = 1)
head(crimes15)

crimes15

rowSums(crimes15, na.rm=T)
which.max(crimes15['Ireland',])
max(crimes15['Ireland',])
which.min(crimes15['Ireland',])

# or 
sort(crimes15['Ireland',], decreasing=TRUE)[1]
sort(crimes15['Ireland',])[1]

sort(crimes15['Ireland',], decreasing=TRUE)
order(crimes15['Ireland',], decreasing=TRUE) # gives indexes

#1 b
?cor
cor(crimes15, use = "complete.obs")


# 1 c
tail(crimes15)
crimes15_2 <- crimes15
sexual.crime <- rowSums(crimes15_2[, c('Rape', 'Sexual.assault', 'Sexual.violence')], na.rm=T)
sexual.crime
crimes15_2$Sexual.crime <- sexual.crime
tail(crimes15_2)
crimes15_2 <- crimes15_2[, -c(3,5,6)]
head(crimes15_2)

crimes15_2[any(is.na(crimes15_2))]

# below is better
subset(crimes15_2, is.na(Assault) | is.na(Intentional.homicide) | is.na(Robbery) |  is.na(Theft) | is.na(Sexual.crime))

crimes15_22 <- crimes15_2[complete.cases(crimes15_2),]
crimes15_22

# 1 e

crimes.2008 <- read.csv("EuroStatCrime2008.csv", row.names = 1)
crimes.2008 
crimes.2009 <- read.csv("EuroStatCrime2009.csv", row.names = 1)
crimes.2010 <- read.csv("EuroStatCrime2010.csv", row.names = 1)
crimes.2011 <- read.csv("EuroStatCrime2011.csv", row.names = 1)
crimes.2012 <- read.csv("EuroStatCrime2012.csv", row.names = 1)
crimes.2013 <- read.csv("EuroStatCrime2013.csv", row.names = 1)
crimes.2014 <- read.csv("EuroStatCrime2014.csv", row.names = 1)
crimes.2015 <- read.csv("EuroStatCrime2015.csv", row.names = 1)

big.mat <- as.matrix(cbind(crimes.2008, crimes.2009, crimes.2010, crimes.2011,
                           crimes.2012, crimes.2013, crimes.2014, crimes.2015))
big.mat


A <- array(data = big.mat,
          dim = c(41, 7, 8), 
          dimnames = list(rownames(crimes.2008), colnames(crimes.2008), 2008:2015))
A
?array
A[, , '2015']
head(A[ , , 1])
head(crimes.2008)
head(A[ , , 2])
head(crimes.2009)

# 1 f
plot(A['Ireland', 'Theft',], ylab = 'No of thefts', xlab = 'Year',  xaxt="n")
axis(side = 1, at= 1:8, labels = 2008:2015)

barplot(A['Ireland', 'Theft',], ylab = 'No of thefts', xlab = 'Year',  xaxt="n")
axis(side = 1, at= 1:8, labels = 2008:2015)

#########
# PART 2
# a
wines <- read.csv("wines.csv")
wines
plot(wines)
?pairs

# b
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


# c
# this is it!
plot(wines$View, wines$Tasting)
lines(reg$fitted.values ~ wines$View)

####
# PART B

rosenbrock <- function(x) {
  stopifnot(is.vector(x, mode = "numeric"))
  n <- length(x)
  res <- 0
  for(i in 1:(n - 1)){
    res<- res+100*(x[i+1]-x[i]^2)^2+(1-x[i])^2 }
  return(res)
}
x <- rnorm(4, 3, 2)
rosenbrock(x)
x

system.time(rep(rosenbrock(x)), 10000)

####
# SAMPLE
attach(iris)
by(Sepal.Length, list(Species), mean)
which.max(by(Sepal.Length, list(Species), mean))

by(Sepal.Length, list(Species), sd)
which.min(by(Sepal.Length, list(Species), mean))

iris[which.max(Sepal.Width),]

head(iris)
iris[,-5]
cor(iris[,-5])
?cor
sort(cor(iris[,-5]), decreasing = T)[5]
min(cor(iris[,-5]))



