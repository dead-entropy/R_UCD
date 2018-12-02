banana <- function(x){
  z <- vector(mode = 'double') # creates empty vector z of mode 'double'
  browser()
  for(i in 1:length(x)-1) # initiates a for loop to work with input vector which will end on the last but one element
  {x1 <- x[i] # defines object x1 which equals the current value of iteration
  x2 <- x[i+1] # defines object x2 which equals the next value of iteration
  z <- c(z, (100*(x2-x1*x1)^2+(1-x1)^2))} # appends results of formula calculations for n-1 vector elements to a vector
  browser()
  return(sum(z)) # returns sum of the above vector
}   

banana(c(0.2, 0.5, 0.1, 0.6))
?options

scan('f123.rtf')
scan('f123.rtf', sep = '\n')
scan('f123.rtf', what = '')
scan('f123.rtf', sep = '\n', what = 'char')

cat("The quick brown fox", sep = '')


grep('fi', ls())
grep('^fi', ls())
grep('^fi', list.files())
grep('[fi]', ls())
?ls
?list.files
z <- paste('Experience is simply the', 'name we give our mistakes', sep = ' ')
z
z <- paste('Experience', 'is', 'simply', 'the', 'name', 'we', 'give', 'our', 'mistakes', sep = '')
z
z <- paste('Experience is simply the','name we give our mistakes')
z
z <- paste('Experience is simply the name we give our mistakes')
z
nchar(paste('the', 'quick', 'brown', 'fox', sep = ','))

x <- (c(58, 42, 46, 32, 25, 75, 35, 63))
y <- (c(32, 22, 20, 16, 19, 58, 34, 48))
sum(x^2)
sum(y^2)
sum(x*y)
sum(x)^2
sum(y)
mean(x)
mean(y)

##
x <- c(32, 38, 48, 24, 46, 35, 30, 34, 42)
y <- c(6, 8, 13, 5, 7, 6, 5, 8, 12)
plot(x, y)
plot(lm(y ~ x))
lm(y ~ x)
sum(x*y)
sum(x)*sum(y)
sum(x^2)
sum(x)^2
mean(x)
mean(y)

##

z <- c(1.24, 63.96, 1.35, 66.33, 1.11, 62.91, 1.84, 78.57, 2.03, 80.49, 2.12,
  81.72, 1.98, 78.88, 1.65, 73.77, 1, 58.68, 1.5, 68.32, 1.79, 75.16, 1.56, 68.5)

seq(z, by=2)

x <- z[z < 5]
x
y <- z[z > 5]
y
sum(x*y)
sum(x)*sum(y)
length(x)
sum(x^2)
sum(x)^2
plot(x, y)
mean(y)
mean(x)
lm(y ~ x)
sum(y^2) - ((sum(y)^2)/12)
sum(y^2)
sum(y)
sum(x*y)




z <- paste('Experience is simply the','name we give our mistakes')
z
z <- paste('Experience is simply the', 'name we give our mistakes', sep = ' ')
z
z <- paste('Experience', 'is', 'simply', 'the', 'name', 'we', 'give', 'our', 'mistakes', sep = '')
z
z <- paste('Experience', 'is', 'simply', 'the', 'name', 'we', 'give', 'our', 'mistakes', sep = '')
z
z <- paste('Experience is simply the name we give our mistakes')
z

?ls
ls()
grep('^stu', ls())
grep('^stu', list.files())
grep('[stu]', ls())
grep('stu', ls())
list.files()
ls()
obj.stu.lop <- c(5,67,900)
ls()

nchar(paste('the', 'quick', 'brown', 'fox', sep = ','))
cat("The quick brown fox", sep = '')

read.delim('tabd.txt', header = FALSE)
read.table('tabd.txt', sep = '\t')
read.table('tabd.txt', sep = '/t')
read.csv('tabd.txt', sep = '\t', header = FALSE)
