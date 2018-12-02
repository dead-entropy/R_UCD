# loops

for(i in 1:2) print(i)

x <- c(2, 4, 6)
for(i in x) { # for loop over the elements of x
  print(i) # print the current value of i
  print(i^2) # print the current value of i^2
}

# WHILE & REPEAT

# while loops keep repeating until a certain condition is met.
# repeat loops keep repeating until a break command is found. 
# The break command can also be used in for and while loops.

i <- 2 # initialise i = 2 
while(i < 10){ # stop if i >= 10
  print(i) 
  print(i^2) 
  i <- i + 2
}

i <- 2
repeat{
  print(i)
  print(i^2)
  i <- i + 2
  if(i > 8) break
}

# Another useful command is 'next' which tells a loop to skip to 
# the next iteration without conducting any of the later commands.

# LOOPING OVER NON-VECTORS (a list or a matrix)

# Example: looping over matrix objects

u <- matrix(1:6, 3, 2)
v <- matrix(7:12, 3, 2)
u
v

for(i in c('u', 'v')){
  print(i) # print the value of i
  z <- get(i) # get the object with the name given by the current value of i
  print(colMeans(z)) # print the values of the column means
}

?get
?colMeans

for(i in c('u', 'v')){
  print(i) # print the value of i
  print(colMeans(i)) # does not work without get
}

# The (very powerful) get function here turns the character vector (u, v) 
# into objects from their names!!!

# IF ELSE STATEMENT

r <- 3
if(r == 4){
  x <- 2
} else {  # if (r != 4)
  x <- 3
  y <- 4
  }
  
# If you have multiple commands to carry out inside an if statement 
# you should always use curly brackets

# ARITHMETIC AND BOOLEAN OPERATORS

12 %/% 7 # integer division (7 goes into 12 once)
24 %% 5

a <- c(3, 2, 1)
b <- c(1, 2, 3)

# && produces scalar output
# & prduces vector output

# || produces scalar output
# | prduces vector output

a > 1 & b < 2 # check if: (a[1] > 1 AND b[1] < 2); (a[2] > 1 AND b[2] < 2); (a[3] > 1 AND b[3] < 2)
a > 1 && b < 2 # check only if: a[1] > 1 AND b[1] < 2
a > 1 | b < 2 # check if: (a[1] > 1 OR b[1] < 2); (a[2] > 1 OR b[2] < 2); (a[3] > 1 OR b[3] < 2)
a > 1 || b < 2 # check only if: a[1] > 1 OR b[1] < 2

# The difference is that x && y and x || y look at only the first elements 
# of x and y. It’s usually safer to use x & y or x | y.

TRUE + 2 # TRUE is stored as 1
FALSE + 2 # FALSE is stored as 0

(1 < 2) == 1 # same as: TRUE == 1

# WRITING FUNCTIONS

fun1 <- function(x, printx = TRUE, printy = TRUE) { 
  y <- x^2
  if(printx) print(x) # if(printx) is the same as if(printx == TRUE) 
  if(printy) print(y) # if(printy) is the same as if(printy == TRUE) 
  return(y)
}

answer <- fun1(5)
answer # this shows the value returned by function

fun1_1 <- function(x, printx = TRUE, printy = TRUE) { 
  y <- x^2
  if(printx) print(x) # if(printx) is the same as if(printx == TRUE) 
  if(printy) print(y) # if(printy) is the same as if(printy == TRUE) 
  return(x, y) # THIS WILL GIVE ERROR
}

answer <- fun1_1(5)

# DEFAULT values for arguments

# The first line of the function specifies that printx and printy have 
# default arguments (both set to TRUE). The argument x has no default 
# and must be supplied.

# to turn the arguments off:

answer <- fun1(6, printx = FALSE, printy = FALSE) 
# does not print x and y answer 

answer
# show the value returned by fun1

answer <- fun1(printy = FALSE, x = 7) # does not print y, and the value of x is 7
answer

# However if we don’t give the argument names we must specify them in order:
answer <- fun1(8, FALSE) 
# this is the same as fun1(x = 5, printx = FALSE, printy = TRUE)
answer

# RETURN OR NOT?
# At the end of the function I have used return() to explicitly 
# tell R that this is the value we want to give back

answer <- fun1(5)
# answer will store the value(s) specified by return

# if we want to return multiple values we can return them as a list:

fun2 <- function(x, printx = TRUE, printy = TRUE) { 
  y <- x^2
  if(printx) print(x)
  if(printy) print(y) 
  return(list(input = x, output = y))
}

answer2 <- fun2(4)
answer2 # the returned value is a list!

fun2_1 <- function(x, printx = TRUE, printy = TRUE) { 
  y <- x^2
  if(printx) print(x)
  if(printy) print(y) 
  return(c(x, y)) # also works
}

answer2 <- fun2_1(4)

# INVISIBLE
# By default the function will print out the answer every time:
fun1(5, FALSE, FALSE)
# If we use invisible instead of return we can remove this behaviour:

fun3 <- function(x, printy = TRUE) { 
  y <- x^2
  if(printy) print(y)
  invisible(y) # do not print the value returned by the function if that's
# not assigned to an object
}
fun3(5, FALSE)
answer <- fun3(5, FALSE)
answer # the value is returned since is saved in 'answer'

# the FUNCTION FUNCTION
# The R function function has essentially two arguments, 
# the argument list and the body
# These can be accessed via the functions formals and body

fun4 <- function(x = 7){ 
  return(x^2)
}
formals(fun4) # get the arguments of the function fun4
body(fun4) # get the body of the function fun4

# When you type in the name of a function without brackets 
# R will print out the arguments and body of the function.
abline
abline2 <- abline
page(abline2) # show the function in a "R page"
edit(abline2) # get access to the text editor to edit the function 'abline'

# FLEXIBLE ARGUMENTS in functions
# Many of the default R functions (e.g. plot) contain an ellipsis ... 
# at the end of the argument list. This allows you to pass in other extra 
# named arguments to functions that may be called as part of the main function.

fun5 <- function(x,...){
  return(mean(x,...))
}

# Here mean has the extra arguments na.rm and trim, so:
fun5(c(1:10))
fun5(c(1:10, NA))
fun5(c(1:10, NA), na.rm = TRUE)
# So I can give fun5 the argument na.rm = TRUE despite it not being 
# detailed in the original function arguments.

# ENVIRONMENTS AND SCOPE
w <- 12
f <- function(y) { # create the function f
  d <- 8
  h <- function(){ # create the function h inside the function f
    return(d * (w + y)) # d is passed by the environment of f
    # w is passed by the global environment
    # y is passed as an argument of f return(h()) # function f returns the value of h()
  }
  return(h()) # function f returns the value of h()
}

f(2)

# Environment. ls and ls.str

# The environment function will tell you which environment you are in when you run it.
# The ls (and ls.str) functions will list all the objects in the current environment

environment()
ls()
ls.str()

# Enviroments inside functions
# Now suppose we change our function slightly to print the environment 
# whilst we’re in the function

f2 <- function(y) { 
  d <- 8
  h <- function(){ 
    return(d * (w + y)) 
    }
print(environment()) 
print(ls.str()) 
return(h())
} 

f2(2)

# getting it wrong
# Suppose instead we gave the functions separately:

f <- function(y) { 
  d <- 8
return(h()) 
  }
h <- function() { 
  return(d * (w + y))
} 

f(2)

f <- function(y) { 
  d <- 8
return(h()) 
  }
# change the order in the multiplication in h
h <- function() { 
  return((w + y) * d)
} 

f(2)

# These errors are returned because # the objects d and y do not exist 
# in the environment for h. The fix is to give h some named arguments.

# MORE on LS

# So far we have called ls without any arguments to give the list of objects in the current environment.
# By adding the envir argument, we can list all the objects in environments 
# above that of where envir is called.

f <- function(y) { 
  d <- 8
return(h(d, y)) 
  }
h <- function(dd, yy) {
  print(ls()) # list the arguments in the current environment
  print(ls(envir = parent.frame(n = 1))) # list the arguments in the environment above return(dd * (w + yy))
  return(dd * (w + yy))
  }

f(2) # When h is called from f ls(envir = parent.frame(n = 1)) 
# show the arguments in f

# When h is used directly ls(envir = parent.frame(n = 1)) show the arguments 
# in the global environment
h(8, 2)

# objects can exist only in functions

# If you change an object inside a function the object will remain unchanged 
# once the function has finished its execution

d <- 5
f <- function() {
  d <- 8
  return(d) 
}
f()
d

# However, there is an exception to this rule. . .

# Global assignment
# The <<- and assign functions allow you to change an object inside 
# a function and have it persist in different environments:

d <- 5
f <- function() {
  d <<- 8
  return(d) 
}
f()
d


d <- 6
f <- function() {
  d <- 9
  assign('d', d, pos = .GlobalEnv) 
  return(d)
}
f()
d

# The extra advantage of using assign is that the first argument is a 
# character string so you can assign a vector of names to different values 
# and then call them all back in with get

# RECURSION

# a recursive function is one that calls itself
# consider
# x! = x×(x−1)×(x−2) ×...× 1 
# = x×(x−1)!

fact <- function(x) { 
  if(x == 1) return(x) 
  return(x * fact(x - 1))
} 

fact(5)

# Note that there is a break as soon as x becomes 1, otherwise the function 
# would run on forever. The return function breaks the problem down into 
# a smaller problem and re-runs the function.

# QUICK SORT
# another recursion example

# Given a vector, e.g. (5, 4, 12, 13, 3, 8, 88) this algorithm compares 
# the first element 5 with the others and produces two sub-vectors; the first 
# with all the elements smaller than it 4, 3, the second with all the elements 
# bigger than it 12, 13, 8, 88 and re-runs quicksort on these two sub-vectors.

quicksort <- function(x) {
  if(length(x) <= 1) return(x)
  pivot <- x[1] # take the first value as pivot
  therest <- x[-1] # create a new vector with all values but the pivot
  sv1 <- therest[therest < pivot] # subset of values smaller than the pivot
  sv2 <- therest[therest >= pivot] # subset of values greater than or = the pivot 
  sv1 <- quicksort(sv1) # quicksort the values smaller than the pivot
  sv2 <- quicksort(sv2) # quicksort the values smaller than the pivot o
  return(c(sv1, pivot, sv2))
}

quicksort(c(5, 4, 12, 13, 3, 8, 88))

ft <- c(5, 4, 12, 13, 3, 8, 88)
ft[ft < 12]

# replacement functions
# R allows you to use replacement functions in certain circumstances:
x <- numeric(3)
names(x)
names(x) <- c('a', 'b', 'ab')
names(x)
# What we’re really calling is:
x <- 'names<-'(x, c('a', 'b', 'ab'))
?names(x)

# writing your own operator
"%a2b%" <- function(a, b) return(a + 2 * b) 
3 %a2b% 5

# anonymous functions
# Sometimes it’s not even worth giving your function a name. 
# Eg. if you’re just using it and disposing of it instantly:

M <- matrix(1:6, nrow = 3, ncol = 2) 
f <- function(x) x / max(x)
apply(M, 1, f)
apply(M, 1, function(x) x / max(x)) # here we didn't have to define function at all
M
# MCQ2

?array
dim(as.array(letters))
x <- array(1:3, c(2,4)) # recycle 1:3 "2 2/3 times"

nrow(x)
dim(x)[1]
dim(x)[2]
table(x)
ncol(x)

x=list(letters=c('a','b','c'),numbers=c(1,2))
x
x[[2]]
x$letters[2:3]
x[1]
x@numbers
?complete.cases
iris
str(iris)
x = list(names=letters[1:4],numbers=10:15)
x
x[[3]] = 8
x
x[1] = 7
x
x$colours = c('red','blue')
x
x$names = c(x$names,'e','f')
x
table(letters[1:3], sample(letters[1:3]), deparse.level = 2)
?table
f=factor(sample(1:5,100,replace=T))
mean(as.numeric(levels(f)[f]))
f
apply(f,1,mean)
mean(as.numeric(f))
mean(f)
list.files()
getwd()
file.choose()
file.show()
file.info()
library(MASS)
mean(birthwt$age[birthwt$smoke])
sapply(split(birthwt$age, birthwt$smoke), mean)
tapply(birthwt$age, birthwt$smoke,mean)
by(birthwt$age, birthwt$smoke,mean)
str(birthwt)

birthwt$age[birthwt$smoke]
?file.access()

x <- c(-5, -7, 5, 7, 2, -2, 0, 0, 5, -4, 8)
cut(x,c(-2,0,2),labels=c('low','high'))

?cut()
tapply(height,sex,max) 

f=factor(sample(1:5,100,replace=T))
mean(as.numeric(levels(f)[f]))
apply(f,1,mean)
mean(as.numeric(f))

y <- c('a1', 'a2', 'a3')
x <- c('b1', 'b2', 'b3')
d1 <- data.frame(y)
d2 <- data.frame(x)
str(iris)
c7 <- as.vector(lapply(list(a=1:5,b=6:10),'mean'),mode='numeric')
is.numeric(c4)
c8 <- apply(simplify2array(list(a=1:5,b=6:10)),2,'mean')
c9 <- lapply(list(a=1:5,b=6:10),'mean')
c4 <- sapply(list(a=1:5,b=6:10),'mean') 

# LAB 6

library(gmp)
install.packages(gmp)
rmarkdown:::find_pandoc()
as.list(rmarkdown:::.pandoc)
Sys.getenv("PATH")

# 2 #
library(MASS)
str(painters)
head(painters)
painters
# a
painters$Colour > 15 | painters$Expression > 15
painters$Colour > 15 || painters$Expression > 15

# b
painters[painters$Colour > 15 | painters$Expression > 15,]
sum(painters$Colour > 15 | painters$Expression > 15)

# c #
sum(painters$Composition > 10 & painters$Drawing > 10 & painters$Colour > 10
    & painters$Expression > 10)

# 3 #

rowSums(painters[-5]) > 30

h <- ifelse(rowSums(painters[-5]) > 30, 'elite', 'not elite')
h
table(h) # works

k <- painters[rowSums(painters[-5]) > 30,]
str(k)

g <- painters[rowSums(painters[-5]) > 50,]
str(g)

install.packages('gmp')
install.packages("gmp")
install.packages('Rmpfr')
library('gmp')

# 4 #

d_fact <- function(x) { 
  if(x == 1) { return(x) }
  if(x %% 2 == 0) {x <- x-1}
  return(x * d_fact(x - 2))
}  # I think it works!!!

d_fact(5)
d_fact(6)  
d_fact(7)

warnings()
6 %% 2

mean(c(100, 135, 108, 94, 111, 96, 99, 104, 109, 120))
sd(c(100, 135, 108, 94, 111, 96, 99, 104, 109, 120))

# 5 #

fib <- function(x){
  v <- vector(length = x)
  if(x >= 1)
  for(i in length(v))
    fib(i-1) + fib(i-2)
  print(fib(i))
}
  
  
 # not working

fib(9)

recursive.factorial <- function(x) {
  if (x == 0)    return (1)
  else           return (x * recursive.factorial(x-1))
}

recursive.factorial(9)

recurse_fibonacci <- function(n) {
  if(n <= 1) {
    return(n)
  } else {
    recurse_fibonacci(n-1) + recurse_fibonacci(n-2)
    print(recurse_fibonacci(i))
  }
}

recurse_fibonacci(9)

len <- 10
fibvals <- numeric(len)
fibvals[1] <- 1
fibvals[2] <- 1
for (i in 3:len) { 
  fibvals[i] <- fibvals[i-1]+fibvals[i-2]
}

fibvals


fib <- function(x){
  fibvals = numeric(x)
  fibvals[1] <- 1
  fibvals[2] <- 1
  for (i in 3:length(x)) { 
  fibvals[i] <- fibvals[i-1]+fibvals[i-2]
  }
}

fib(9)
