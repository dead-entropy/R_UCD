## Code Lecture 3

# Create a list
j <- list(name = 'Joe', salary = 55000, union = T)
j

# Access the list
j$salary
j[['salary']]
j[[2]]

# Not using square brackes
j['salary']
j[2]
j[1:2]


# Add a new component
j$sales <- c(10400, 12300, 13700) 
j[[5]] <- 'Manager' 
j

# Delete it
j[[5]] <- NULL
j

# length
length(j)
length(j$sales) 

# Find names or structure
names(j)
str(j) 

# Turn into a vector
unlist(j) 
mode(unlist(j))
unname(unlist(j))
unlist(j, use.names = FALSE)

# Use lapply on list
lapply(list(1:3, 25:29), median)

# And sapply
sapply(list(1:3, 25:29), median)

# A list within a list
list(a = 1, b = 2, c = list(d = 3, e = 4))

# A matrix in a list
list(a = 1, b = matrix(c(1, 2, 3, 4), ncol = 2, nrow = 2))

##########################

# Extended example - text concordance

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

# use the head function to visualise the first 5 components

head(findwords(firstpar), 5)


# Simple sort alphabetically function

alphawl <- function(wrdlst) {
  nms <- names(wrdlst) # Find the tags of the list
  sn <- sort(nms) # Sort them alphabetically
  return(wrdlst[sn]) # Return them
  }
alphawl(findwords(firstpar))

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


##########################

# Data Frames

# Simple example

kids <- c('Jack', 'Jill')
ages <- c(12, 10)
d <- data.frame(kids, ages) 
d
mode(d)

# Access it
d[[2]]
d$kids[1]

str(d)

# Load in the data frame women containing height (inches) and weight (lbs) of 15 women

data(women)
str(women)

# Extract parts of it
women[1:2,]
women[women$height > 70,]
subset(women, weight < 130)

# Look at complete.cases
women[1,1] <- women[13,2] <- NA # insert NA
women # check it
women[complete.cases(women),]

# Add in extra columns
data(women) # Reload the data in again to get rid of the NA values created above
women2 <- cbind(women, letters[1:15])
women2
women3 <- rbind(women, c(73, 166))
women3
women4 <- cbind(women, women$height * 2.54, women$weight * 0.45)
names(women4) <- c('heightin', 'weightin', 'heightcm', 'weightkg')
women4
women$heightcm <- women$height * 2.54
women

# Merging data frames
d1 <- data.frame(kids = c('Jack', 'Jill', 'Jillian', 'John'),
  county = c('Dublin', 'Cork', 'Donegal', 'Kerry'))

d2 <- data.frame(ages = c(10, 7, 12), 
  kids = c('Jill', 'Lillian', 'Jack'))
merge(d1, d2)

##
# From Screencast SC2

# Matching with different variable names
d3 <- data.frame(age = c(10, 7, 12), 
  names = c('Jill', 'Lillian', 'Jack'))

merge(d1, d3, by.x = 'kids', by.y = 'names')

# Be careful matching with duplicates
d4 <- rbind(d2, list(15, 'Jill')) # d4 now contains two Jills
merge(d1, d4)
# The merge now thinks both Jills come from Cork

# Using lapply on a data frame
lapply(d, sort)
data.frame(lapply(d, sort)) 

##########################

# Extended example - birthwt data with logistic regression

# load the library MASS
library(MASS)

# check the dataset
help(birthwt)
str(birthwt)

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

# check the jitter function
?jitter
