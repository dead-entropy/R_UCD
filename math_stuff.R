# The R expression represents e
exp(1) 
exp(2) # represents e^2

# Matrix operations - matrix multiplication
M <- matrix(1:6, nrow = 3, ncol = 2)
N <- matrix(c(1:4, 5, 9, 7, 1, 2), nrow = 3, ncol = 3)
t(M) %*% M
M
N
solve(N)
solve(N) %*% N # Matrix x its inverse gives identity matrix

# Other useful matrix functions
I <- diag(2) # creates diagonal matrix of size given
I
I2 <- diag(6)
I2
M <- matrix(1:4,2,2)
M
m <- c(2,4)
M %*% m
det(M)
solve(M)
solve(M) %*% M
eigen(M)

c22 = rbind(c(1, -1/4), c(-1/4, 1))
c22
solve(c22) %*% c22

###########################

# Some examples of various maths functions
exp(1) # The value of e
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

###########################

a <- c(1,4,9)
b <- c(2,2,7)
pmin(a, b) # parallel minimum

############################

# Calculus
D(expression(exp(x^2)), 'x') # derivative
# to do second derivative use D function within D function:
D(D(expression(exp(x^2)), 'x'), 'x')

x <- 3
eval(exp(x^2))
exp(9)

integrate(function(x) x^2, 0, 1)

?D
?integrate

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


