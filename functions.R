# counts odd numbers in a vector

oddcount <- function(x) {
  # Set k to be 0
  k <- 0 
  for(n in x) {
    # %% finds remainder on division
    if(n %% 2 == 1) k <- k + 1 
  }
  return(k)
}

oddcount(c(1,3,5))
oddcount(c(1,2,3,7,9))

##########################################


# Function to find the number of repeated ones of length k
findruns <- function(x, k) {
  n <- length(x)
  runs <- NULL
  for(i in 1:(n - k + 1)) {
    if(all(x[i:(i + k - 1)] == 1)) runs <- c(runs, i)
  }
  return(runs)
}

# Using the function
y <- c(1, 0, 0, 1, 1, 1, 0, 1, 1)
findruns(y,3)
findruns(y,2)
findruns(y,6)

###########################################

# Predicting discrete valued time series version used in lecture
pred <- function(x,k) {
  n <- length(x)
  k2 <- k/2
  pred <- vector(length = n - k)
  for(i in 1:(n - k)) {
    if(sum(x[i:(i + (k - 1))]) >= k2) pred[i] <- 1 else pred[i] <- 0
  }
  return(mean(abs(pred - x[(k + 1):n])))
}

# Run it
pred(y, 1)
pred(y, 2)
pred(y, 3)

# predb - better way of updating the sum
predb <- function(x,k) {
  n <- length(x)
  k2 <- k/2
  pred <- vector(length = n - k)
  sm <- sum(x[1:k])
  if(sm >= k2) pred[1] <- 1 else pred[1] <- 0
  if(n - k >= 2) {
    for(i in 2:(n - k)) {
      sm <- sm + x[i + k - 1] - x[i-1]
      if(sm >= k2) pred[i] <- 1 else pred[i] <- 0
    }
  }
  return(mean(abs(pred - x[(k + 1):n])))
}

# Run it
predb(y, 1)
predb(y, 2)
predb(y, 3)

# Third version predc - use cumulative sum - cumsum
predc <- function(x,k) {
  n <- length(x)
  k2 <- k/2
  pred <- vector(length = n - k)
  csx <- c(0, cumsum(x))
  for(i in 1:(n - k)) {
    if(csx[i + k] - csx[i] >= k2) pred[i] <- 1 else pred[i] <- 0
  }
  return(mean(abs(pred - x[(k + 1):n])))
}

# Run it
predc(y, 1)
predc(y, 2)
predc(y, 3)

##################################

firstpar <- "It was a bright cold day in April and the clocks were striking thirteen Winston Smith his chin nuzzled into his breast in an effort to escape the vile wind slipped quickly through the glass doors of Victory Mansions though not quickly enough to prevent a swirl of gritty dust from entering along with him"

findwords <- function(tf) {
  txt <- unlist(strsplit(tf, ' ')) # Read in the words from the text and separate into a vector
  wl <- list() # Create a list to store the words and their positions
  for(i in 1:length(txt)) { # Loop through each word
    wrd <- txt[i]  # Get the current word
    wl[[wrd]] <- c(wl[[wrd]], i) # Add its position to the list with the appropriate tag
  }
  return(wl) # Return the answer as a list
}

findwords(firstpar)

findwords2 <- function(tf){
  txt <- unlist(strsplit(tf, ' ')) # reads text, separates into vector of words                      
  word_list <- list() # create a list to store the words and their positions
  for(i in 1:length(txt)){  # loop through each word
    word <- txt[i] # get the current word
    word_list[[word]] <- c(word_list[[word]], i) #list of positions of words
    # with the words as tags 
  }
  return(word_list)
}

findwords2(firstpar)

# find words in alphabetical order (to be used with previous function)
alpha_word_list <- function(word_list){
  nms <- names(word_list) # find the tags of the list
  sort_names <- sort(nms) # sort the words (tags) alphabetically
  return(word_list[sort_names])  # gives list as result
}
alpha_word_list(findwords2(firstpart))

alpha_word_list2 <- function(word_list){
  nms <- names(word_list) # find the tags of the list
  sort_names <- sort(nms) # sort the words (tags) alphabetically
  return(sort_names)  # gives a vector as result!!
}
alpha_word_list2(findwords2(firstpart))

# or sort by frequency

freqwl <- function(wrdlst) {
  freqs <- sapply(wrdlst, length) # Find the freq of each word
  return(wrdlst[order(freqs)]) # Return them in order
}
freqwl(findwords(firstpar)) 

freqwl <- function(wrdlst) {
  freqs <- sapply(wrdlst, length) # Find the freq of each word
  rev(return(wrdlst[order(freqs)]))  # Return them in order
}
freqwl(findwords(firstpar)) 

###########################################

# load the library MASS
library(MASS)

# Drop 2 of the columns
birthwt2 <- birthwt[,-c(4, 10)]
head(birthwt2) # check the first 6 lines of the new dataset

# Write a function
logfun <- function(x) {
  glm(birthwt2$low ~ x, family = binomial)$coef
}
sapply(birthwt2[,-1], logfun)

# Plot of low birthwt against age
mod <- glm(birthwt2$low ~ birthwt2$age, family = binomial)$coef
plot(jitter(birthwt2$age), birthwt2$low, col = "red")
points(birthwt2$age, 
       1 / (1 + exp(-(mod[1] + mod[2] * birthwt2$age))), 
       pch = 2, col = "green")

############################################

powers2 <- function(x, deg) {
  pw <- matrix(nrow = length(x), ncol = deg)
  prod <- x
  pw[,1] <- prod
  for(i in 2:deg) {
    prod <- prod * x
    pw[,i] <- prod
  }
  return(pw) 
}

##########################################

# function to create sums of matrix columns

mycolsum2 <- function(i, M) {
  return(sum(M[,i]))
}

# A for loop over matrix objects
u <- matrix(1:6, 3, 2)
v <- matrix(7:12, 3, 2)
for(i in c('u', 'v')) {
  print(i) # print the value of i
  z <- get(i) # get the object with the name given by the current value of i
  print(colMeans(z)) # print the values of the column means
}

############################################


# Function to find factorials
fact <- function(x) {
  if(x == 1) return(x)
  return(x * fact(x - 1))
}
fact(5)

############################################

# Quick sort
quicksort <- function(x) {
  if(length(x) <= 1) return(x)
  pivot <- x[1] # take the first value as pivot
  therest <- x[-1] # create a new vector with all values but the pivot
  sv1 <- therest[therest < pivot] # subset of values smaller than the pivot
  sv2 <- therest[therest >= pivot] # subset of values greater than or = the pivot
  sv1 <- quicksort(sv1) # quicksort the values smaller than the pivot
  sv2 <- quicksort(sv2) # quicksort the values greater than or equal the pivot
  return(c(sv1, pivot, sv2))
}
quicksort(c(5, 4, 12, 13, 3, 8, 88))

###########################################

# Snap!

# Let's first number the cards
cards <- 1:52

# A snap occurs the first time when both players draw the same card
# Let's draw some hands
p1hand <- sample(cards)
p2hand <- sample(cards)
p1hand
?sample

# Find out when they both intersect
print(snaptime <- which((p1hand - p2hand == 0) == TRUE)[1])
print(snaptime <- which((p2hand - p1hand == 0) == TRUE)[1])

# Now let's try working out the value with a loop
numhands <- 1000
snaptimes <- vector(length = numhands)
for(i in 1:numhands) {
  p1hand <- sample(cards)
  p2hand <- sample(cards)  
  snaptimes[i] <- which(p1hand - p2hand == 0)[1]
}

table(snaptimes, useNA = "always")

# Can we do this without a loop?
snap <- function(handdiff) which((handdiff == 0) == TRUE)[1]
snap # ????
# Create lots of hands and then run lots of applys
numhands <- 100000
bighand1 <- apply(matrix(rep(cards, numhands), 52, numhands), 2, sample)
bighand2 <- apply(matrix(rep(cards, numhands), 52, numhands), 2, sample)
snaptimes2 <- apply(bighand1 - bighand2, 2, snap)
table(snaptimes2, useNA = "always")

