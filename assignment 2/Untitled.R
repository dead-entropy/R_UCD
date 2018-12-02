plot(y)

x <- c(3, 6, 1)

fun <- function(x){
  
  x <- assign('x', x * 2)
  
  x <- x + 3
  
  x
  
}

fun(x)
x

z <- 5
while(z < 10) {
  z <- z + 3
}
z

x <- list(z = 3, y = 2)
for(i in x) {
  
  print(1 / i)
  
}

q <- -3

repeat{
  print(2 * q)
  q <- q + 1
  if(q > 10) 
    exit

}


for(i in 10:-2) print(i)




'%+%' <- function(a, b) join(a, b, sep = "")
c <- 'f'
g <- 'jk'
c %+% g

'%+%' <- function(a, b) as.character(a) + as.character(b)
'%+%' <- function(a, b) paste(a, b, sep = "")
'%+%' <- function(a, b) as.character(a, b)
