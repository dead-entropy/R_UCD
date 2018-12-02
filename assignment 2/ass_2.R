# TASK 1

#1
lawyers <- read.csv('Lawyers.csv', head = T)
head(lawyers)
str(lawyers)
lit <- nrow(lawyers[lawyers$Practice == 'Litigation',])
other <- nrow(lawyers[lawyers$Practice,])
round(lit/other, 2)

#2
lawyers2 <- data.frame(lawyers$Office, lawyers$Practice)
t <- table(lawyers2)
proptable <- t / sum(t)
proptable # table of proportions per practice, per office for the whole firm
proptable['Boston','Corporate'] # accesing answers
proptable['Providence','Corporate']

ss <- stack(prop)

apply(t, 1, 'Corporate' / sum)
apply(t, 2, sum)
sum(t)

office_totals <- table(lawyers$Office)
B.corp <- nrow(lawyers[lawyers$Practice == 'Corporate' & 
                      lawyers$Office == 'Boston',])
H.corp <- nrow(lawyers[lawyers$Practice == 'Corporate' & 
                         lawyers$Office == 'Harvard',])
P.corp <- nrow(lawyers[lawyers$Practice == 'Corporate' & 
                         lawyers$Office == 'Providence',])
pp <- lawyers[lawyers$Practice == 'Corporate' & 
                         lawyers$Office == 'Providence',]
corpprop <- data.frame(B.corp, H.corp, P.corp)
final <- corpprop / office_totals
colnames(final) <- c('Boston_corp', 'Harvard_corp', 'Providence_corp')
rownames(final) <- 'Proportion'
final

##

by(lawyers$Age, lawyers[,'Office'], mean)


# 3 
head(lawyers)

lawyer_age <- aggregate(lawyers$Age, list(lawyers$Seniority, lawyers$Practice), mean)
colnames(lawyer_age) <- c('Seniority', 'Practice', 'Mean_age')
lawyer_age



# 4

m.age <- aggregate(lawyers$Age, list(lawyers$Office), median)
colnames(m.age) <- c('Office', 'Median_age')
m.age[which.min(m.age[,2]),1] 


# TASK 2




ban(c(0.5, 0.6))

ban <- function(x){
  res <- vector(mode = "numeric", length(x))
  for(i in x) 
  { res[i] <- (1 - res[i])^2}
  return(res)
}    

ban(c(2,3))

ban <- function(x){
  z <- NULL
  for(i in x) 
  { z <- c(z, (1 - i)^2)}
  sum(z)
}    


ban <- function(x){
  z <- NULL

  for (i in 1:length(x)-1) z <- c(z, (100 * ((i+1) - (i^2))^2) + (1 - i)^2)
  return(z)
}    

ban <- function(x){
  z <- NULL
  for (i in x) z <- c(z, (100 * ((i+1) - (i^2))^2) + (1 - i)^2)
  return(z)
}   


z
ban(c(0.2, 0.5, 0.1, 0.6))


  
ban2 <- function(x){

  for(i in 1:length(x)-1) 
  {x1 <- x[i]
  x2 <- x[i+1]
  z <- 100*(x2-x1*x1)^2+(1-x1)^2}
  return(z)
}    


ban2(c(0.2, 0.5, 0.1, 0.6)) # gives result that doesnt look idiotic


ban2.1 <- function(x){
  z <- NULL
  for(i in 1:length(x)-1) 
  {x1 <- x[i]
  x2 <- x[i+1]
  z <- c(z, (100*(x2-x1*x1)^2+(1-x1)^2))}
  return(z)
}    #!!!!!!!!! works???????


ban2.1 <- function(x){
  z <- NULL
  for(i in 1:length(x)-1) 
  {x1 <- x[i]
  x2 <- x[i+1]
  z <- c(z, (100*(x2-x1*x1)^2+(1-x1)^2))}
  return(sum(z)) # have to assume this is it
}    


ban2.1(c(0.2, 0.5, 0.1, 0.6))
ban2.1(c(0.2, 0.5))
system.time(rep(ban2.1(c(0.2, 0.5, 0.1, 0.6)), 100))

rosen <- function (x) {   ## Rosenbrock Banana function
  x1 <- x[1]
  x2 <- x[2]
 return(sum(100*((x[i+1])-x[i]*x[i])^2+(1-x[i])^2))
}

rosen(c(0.2, 0.5))

fr <- function(x) {   ## Rosenbrock Banana function
  x1 <- x[1]
  x2 <- x[2]
  100 * (x2 - x1 * x1)^2 + (1 - x1)^2
}

res <- sapply(x, fr)
res
x

system.time(rep(banana(c(0.2, 0.5, 0.1, 0.6)), 100))
system.time(rep(banana(c(0.2, 0.5, 0.1, 0.6)), 100))

system.time(replicate(100, banana(c(0.2, 0.5, 0.1, 0.6))))


ban3 <- function(x){
  x1 <- x[1]
  x2 <- x[2]
  for(i in x) 
  {z <- 100*(x2-x1*x1)^2+(1-x1)^2}
  return(z)
}    

bb <- function(x){
for (i in 1:length(x)-1){
{   ## Rosenbrock Banana function
  x1 <- x[1]
  x2 <- x[2]
  100*(x2-x1*x1)^2+(1-x1)^2
}
}
}

bb(c(0.2, 0.5, 0.1, 0.6))

# for without loop, try sapply
results <- vapply(x, function(x) { 100*((x[i+1])-x[i]*x[i])^2+(1-x[i])^2})
results
?sapply

ban2.1 <- function(x){
  z <- NULL # sets 
  for(i in 1:length(x)-1) 
  {x1 <- x[i]
  x2 <- x[i+1]
  z <- c(z, (100*(x2-x1*x1)^2+(1-x1)^2))}
  return(sum(z)) # have to assume this is it
}   

z <- NULL
is.vector(z)

ban2.2 <- function(x){
  z <- NULL 
  z <- eval(expression(x, 100*((x[i+1])-x[i]*x[i])^2+(1-x[i])^2))
  return(sum(z))
}   

ban2.2(c(0.2, 0.5, 0.1, 0.6))

eval(expression(x ,100*((x[i+1])-x[i]*x[i])^2+(1-x[i])^2))


fr <- function(x) {   ## Rosenbrock Banana function
  z <- NULL
  z <- c(z, (100*((x[i+1])-x[i]*x[i])^2+(1-x[i])^2))
  return(sum(z))
}

fr(c(0.2, 0.5, 0.1, 0.6))


fr(c(0.2, 0.5))

##

banana <- function(x){
  z <- vector(mode = 'double') # creates empty vector z of mode 'double'
  for(i in 1:length(x)-1) # initiates a for loop to work with input vector which will end on the last but one element
  {x1 <- x[i] # defines object x1 which equals the current value of iteration
  x2 <- x[i+1] # defines object x2 which equals the next value of iteration
  z <- c(z, (100*(x2-x1*x1)^2+(1-x1)^2))} # appends results of formula calculations for n-1 vector elements to a vector
  return(sum(z)) # returns sum of the above vector
}   

banana(c(0.2, 0.5))
banana(c(0.2, 0.5, 0.1, 0.6))
banana(c(0.2, 0.5, 0.1, 0.6, 0.9))

banana.2.2 <- function(vec){
  z <- vector(mode = 'double') # creates empty vector z of mode 'double'
  for(i in 1:length(x)-1) # initiates a for loop to work with input vector which will end on the last but one element
  {x1 <- x[i] # defines object x1 which equals the current value of iteration
  x2 <- x[i+1] # defines object x2 which equals the next value of iteration
  z <- c(z, (100*(x2-x1*x1)^2+(1-x1)^2))} # appends results of formula calculations for n-1 vector elements to a vector
  return(sum(z)) # returns sum of the above vector
}   

banana.2.2(c(0.2, 0.5, 0.1, 0.6))

fr(c(0.2, 0.5, 0.1, 0.6))

fr(c(0.2, 0.5))

noloopba <- function(vec){
  x <- vec[-length(vec)]
  y <- vec[-1]
  z <- 100*(y-x*x)^2+(1-x)^2
  return(sum(z))
}


x <- c(0.2, 0.5, 0.1, 0.6)
v <- x[-length(x)]
y <- x[seq(2, length(x), by = 2)]
v
y
x2 <- c(0.2, 0.5)
v2 <- x2[-length(x2)]
y2 <- x2[seq(2, length(x2), by = 2)]
v2
y2

vec <- c(0.2, 0.5, 0.1, 0.6)
x <- vec[-length(vec)]
y <- vec[seq(2, length(vec), by = 2)]
x
y

## 

banana2 <- function(x){
  x1 <- x
  x2 <- x[-1]
  z <- expression(x1, x2, 100*(x2-x1*x1)^2+(1-x1)^2)
  sapply(x, z)
  return(z)
}   

banana2(c(0.2, 0.5, 0.1, 0.6))

banana2 <- function(x){
  x1 <- x
  x2 <- x[-1]
  z <- sum((expression(x1, x2, 100*(x2-x1*x1)^2+(1-x1)^2)))
  return(z)
}

banana2(c(0.2, 0.5, 0.1, 0.6))




x1 <- x[i]
x2 <- x[i+1] # defines object x2 which equals the next value of iteration
z <- expression(x1, x2, 100*(x2-x1*x1)^2+(1-x1)^2)
z2 <- apply(x, 1, z)

?apply
?expression


# finish!!!!

# TASK 3

DublinAiport <- read.csv('2018_09_Dublin_Airport.csv', head = T)
WeatherData <- list(DublinAiport)
class(DublinAiport) <- c('WeatherData', 'data.frame')
class(DublinAiport)

head(DublinAiport)

summary.WeatherData <- function(airp) {
  md <- data.frame(airp$rain, airp$maxtp, airp$mintp)
  colnames(md) <- c('rain', 'max_tem', 'min_temp')
  x1 <- round(apply(md, 2, mean), 2)
  x2 <- round(apply(md, 2, sd), 2)
  x3 <- apply(md, 2, min)
  x4 <- apply(md, 2, max)
  list(mean = x1, standard_deviation = x2, minimum = x3, maximum = x4)
}

summary.WeatherData (DublinAiport)
summary(DublinAiport)
data.frame(DublinAiport)

CorkAiport <- read.csv('2018_09_Cork_Airport.csv', head = T)
class(CorkAiport) <- c('WeatherData', 'data.frame')
WeatherData(CorkAiport)


# 4

class(WeatherData) <- 'self.plot'


par(mfrow = c(2,1))
plot(DublinAiport$maxtp, type= 'n', xlab="September 2018", ylab="Air Temperature (C)", ylim = c(0, 26),
     main = 'Daily temperatures and precipitation')
lines(DublinAiport$maxtp, col = 'red')
lines(DublinAiport$mintp, col = 'blue')
legend("topright", legend = c("max daily temp", "min daily temp"), 
      cex = 0.74, lty=c(1,1), col = c("red", "blue"))
points(DublinAiport[DublinAiport$maxtp == max(DublinAiport$maxtp),],  col = 'red', pch = 24)
points(DublinAiport[DublinAiport$mintp == min(DublinAiport$mintp),],  col = 'blue', pch = 24)

abline(v = seq(1,30), lty = 3, col = 'grey')
cols <- ifelse(DublinAiport$rain == max(DublinAiport$rain), 'red', 'black')
plot(DublinAiport$rain, type = 'h', xlab="September 2018", 
        ylab="Precipitation Amount (mm)", col = cols, lwd = 2)





DublinAiport[DublinAiport$maxtp == max(DublinAiport$maxtp)]

DublinAiport[min(DublinAiport$maxtp),]
DublinAiport[DublinAiport$maxtp ==  max(DublinAiport$maxtp),]
?axis
?plot


plot(y)


  par(mfrow = c(2,1))
  plot(data$maxtp, type= 'n', xlab="September 2018", ylab="Air Temperature (C)", ylim = c(0, 26),
       main = 'Daily temperatures and precipitation')
  lines(data$maxtp, col = 'red')
  lines(data$mintp, col = 'blue')
  legend("topright", legend = c("max daily temp", "min daily temp"), 
         cex = 0.74, lty=c(1,1), col = c("red", "blue"))
  points(data[data$maxtp == max(data$maxtp),],  col = 'red', pch = 24)
  points(data[data$mintp == min(data$mintp),],  col = 'blue', pch = 24)
  abline(v = seq(1,30), lty = 3, col = 'grey')
  plot(data$rain, type = 'h', xlab="September 2018", 
       ylab="Precipitation Amount (mm)", col = cols, lwd = 2)
  cols <- ifelse(data$rain == max(data$rain), 'red', 'black')


self.plot(DublinAiport)
self.plot(CorkAiport)

CorkAiport
CorkAiport[CorkAiport$maxtp ==  max(CorkAiport$maxtp),]
CorkAiport[CorkAiport$rain ==  max(CorkAiport$rain),]
DublinAiport[DublinAiport$rain ==  max(DublinAiport$rain),]
DublinAiport
CorkAiport

self.plot2 <- function(data, maxtpcol = 'red', mintpcol = 'blue'){
  par(mfrow = c(2,1))
  plot(data$maxtp, type= 'n', xlab="September 2018", ylab="Air Temperature (C)", ylim = c(0, 26),
       main = 'Daily temperatures and precipitation')
  lines(data$maxtp, col = maxtpcol)
  lines(data$mintp, col = mintpcol)
  legend("topright", legend = c("max daily temp", "min daily temp"), 
         cex = 0.74, lty=c(1,1), col = c(maxtpcol, mintpcol))
  points(data[data$maxtp == max(data$maxtp),],  col = 'red', pch = 24)
  points(data[data$mintp == min(data$mintp),],  col = 'blue', pch = 24)
  
  abline(v = seq(1,30), lty = 3, col = 'grey')
  plot(data$rain, type = 'h', xlab="September 2018", 
       ylab="Precipitation Amount (mm)", col = cols, lwd = 2)
  cols <- ifelse(data$rain == max(data$rain), 'red', 'grey')
}

self.plot(DublinAiport)

plot.WeatherData <- function(data, maxtpcol = 'red', mintpcol = 'blue', mmaxr = 'red', maxtppoint = T, mintppoint = T, title = 'Temperature and precipitation'){
  par(mfrow = c(2,1))
  plot(data$maxtp, type= 'n', xlab="September 2018", ylab="Air Temperature (C)", cex.lab= 0.5, ylim = c(0, 26), main = title)
  lines(data$maxtp, col = maxtpcol)
  lines(data$mintp, col = mintpcol)
  legend("topright", legend = c("max daily temp", "min daily temp"), 
         cex = 0.74, lty=c(1,1), col = c(maxtpcol, mintpcol))
  if (maxtppoint == T) points(data[data$maxtp == max(data$maxtp),],  col = maxtpcol, pch = 24)
  if (mintppoint == T) points(data[data$mintp == min(data$mintp),],  col = mintpcol, pch = 24)
  abline(v = seq(1,30), lty = 3, col = 'grey')
  cols <- ifelse(data$rain == max(data$rain), mmaxr, 'black')
  plot(data$rain, type = 'h', xlab="September 2018", 
       ylab="Precipitation Amount (mm)", col = cols, lwd = 2)
}

plot(DublinAiport, title = 'Dublin weather Sep 2018')
plot(CorkAiport)
?axis

plot.WeatherData <- function(data, maxtpcol = 'red', mintpcol = 'blue', 
                             mmaxr = 'red', maxtppoint = T, mintppoint = T, 
                             title = 'Temperature and precipitation'){
  par(mfrow = c(2,1))
  plot(data$maxtp, type= 'n', xlab = 'day', ylab="Air Temperature(C)", 
       ylim = c(0, 36), main = title, cex.lab= 1)
  lines(data$maxtp, col = maxtpcol)
  lines(data$mintp, col = mintpcol)
  legend("topright", legend = c("max daily temp", "min daily temp"), 
         cex = 0.74, lty=c(1,1), col = c(maxtpcol, mintpcol))
  if (maxtppoint == T) points(data[data$maxtp == max(data$maxtp),],  
                              col = maxtpcol, pch = 19)
  if (mintppoint == T) points(data[data$mintp == min(data$mintp),],  
                              col = mintpcol, pch = 19)
  abline(v = seq(1,30), lty = 3, col = 'grey')
  cols <- ifelse(data$rain == max(data$rain), mmaxr, 'black')
  plot(data$rain, type = 'h', xlab = 'day', cex.lab= 1,
       ylab="Precipitation (mm)", ylim = c(0, 20), col = cols, lwd = 2)
}

plot(DublinAiport)
?plot
par(mfrow= c(1,1))
