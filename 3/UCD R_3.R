# reading in data from a file in the same directory

mydata <- read.table(file = "row3.txt", header = TRUE, sep = ",", 
                     row.names = 1)
str(mydata)
mydata
# creating lists
j <- list(name='Joe', salary= 55000, union=T)
j
# note that names of list elements (tags) are not in quotes

# list indexing (3 ways)
j$salary
j[['salary']]
j[[2]]
j[2] # without double square brackets, it returns a list and not a number
j['salary'] # same as above
j[1:2] # this command works because R treats list as VECTORS

# adding and deleting list elements
# adding a new component
j$sales <- c(10400, 12300, 13700)
j
# we can also do this via a vector index:
j[[5]] <- 'Manager'
j

# deleting
j[[5]] <- NULL
j
j[[5]] <- 'bossy boss'
j
j[5] <- NULL 
j

# since list is a vector, you can get the number of tags with length:
length(j)
length(j$sales)

# accessing list components
names(j)
str(j)

# the function UNLIST will convert a list into a vector using thge mode of the 
# lowest common denominator (here, char)
t <- unlist(j)
t
mode(t)
# by default, R will give names to unlisted objects taken from tags, 
# we can remove them via unname() command or through an extra argument
unlist(j, use.names=FALSE)
j
?unlist
l.ex <- list(a = list(1:5, LETTERS[1:5]), b = "Z", c = NA)
l.ex
unlist(l.ex, recursive = FALSE)
unlist(l.ex, recursive = TRUE)

# applying functions to lists
# lapply - version for lists
lapply(list(1:3, 25:29), median) #returns result as a list
?lapply()

sapply(list(1:3, 45:67), median) #returns result as vector (simple apply)

# lists within lists
list(a=1, b=2, c=list(d=3, e=4))

# matrix within a list:
list(a=1, b=matrix(c(1,2,3,4), ncol=2, nrow=2), c=c('a', 'f', 'y'))
?list

# hist() returns a list of values as well as the graph
nh <- hist(Nile)
str(nh)

summary(d)

# EXAMPLE (text concordance)
# we want to create a function which lists thge different words used in 
# a text amd their position (non letter characters are removed)
firstpart <- "It was a bright cold day in April and the clocks were striking thirteen
  Winston Smith his chin nuzzled into his breast in an effort to escape the vile wind
slipped quickly through the glass doors of Victory Mansions though not quickly enough
to prevent a swirl of gritty dust from entering along with him"
firstpart
# findwords function

findwords <- function(tf) {
  txt <- unlist(strsplit(tf, ' ')) # Read in the words from the text and separate into a vector
  wl <- list() # Create a list to store the words and their positions
  for(i in 1:length(txt)) { # Loop through each word
    wrd <- txt[i]  # Get the current word
    wl[[wrd]] <- c(wl[[wrd]], i) # Add its position to the list with the appropriate tag
  }
  return(wl) # Return the answer as a list
}

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

findwords2(firstpart)

# function analysis
tf <- firstpart
?strsplit
txt <- unlist(strsplit(tf, ' ')) # strsplit returns list, unlist returns vector
txt
i <- 3
word <- txt[i]
word
word_list[[word]] <- c(word_list[[word]], i) # it tag doesn't exist, this line
                # adds it to list and notes the 'i' (position), if a tag
                # exists, the code appends the new 'i' (position) to the list
word_list

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

wl <- findwords2(firstpart)
wl
nms <- names(wl) # creates vector of tags from the word list
nms
sort_names <- sort(nms)
sort_names
li <- list(sort_names)
li

# sorting by frequency
freq_word_list <- function(word_list){
  freq_word_list <- sapply(word_list, length) # find the length of each 
      #list element i.e. how many entries for each tag (tags=words, entries=frequencies)
  return(word_list[order(freq_word_list)]) # sort the words (tags) in order
}
freq_word_list(findwords2(firstpart))

wordlst <- findwords2(firstpart)
wordlst
freqs <- sapply(wordlst, length) #INTERESTING output
freqs
order(freqs)

# CREATING DATE FRAMES
kids <- c('Jack', 'Jill') # strings will be turned into factors
ages <- c(12, 10)
d <- data.frame(kids, ages)
d
?data.frame

# data frames are treated as a list
mode(d)

# we can access it the same way as list
d[[2]]  # as vector
d[2]  # as data frame
d$kids
str(d)

# extracting parts of data frame
# R treats data frames as lists but allows to extract and filter
# the same way as matrices

str(women)
women
women[1:2,]
women[women$height > 70,]
subset(women, weight <= 130) # removes NA and no need to use full women$weight
women[women$weight > 130,]

# a useful function for removing rows with NA values in data frame complete.case
women[1,1] <- women[13,2] <- NA
women[1,1]
women[complete.cases(women),] # rows 1 and 13 were removed
?complete.cases

# rbind cbind work for matrices and data frames
women2 <- cbind(women, letters[1:15]) # adds new column
women2
women3 <- rbind(women, c(73, 166)) # added a row at the bottom
women3
women4 <- cbind(women, women$height * 2.54, women$weight * 0.45)
women4
# adding names fo columns
names(women4) <- c('heightin', 'weightlbs', 'heightcm', 'weightkg')
women4
# another way to add columns names:
women$heightcm <- women$height * 2.54
women

# merging data frames with merge(x,y)
?merge
d1 <- data.frame(kids = c('Jack', 'Jill', 'Jillian', 'John'), county = c('Dublin', 'Cork', 'Donegal', 'Kerry'))
d2 <- data.frame(ages = c(10, 7, 12), kids = c('Jill', 'Lillian', 'Jack'))
d1
d2
d<- merge(d1, d2)
d

# outer join: includes everything 
dd <- merge(x = d1, y = d2, by = "kids", all = TRUE)
dd

# matching with different variable (column) names
d3 <- data.frame(age= c(10,7,12), names= c('Jill', 'Lillian', 'Jack'))
d3
# d1 has a column 'kids' d3 has a column 'names'

dd2 <- merge(d1, d3, by.x='kids', by.y='names')
dd2

# example with duplicates
d4 <- rbind(d2, list(15, 'Jill'))  # d4 now has 2 Jills
d4

merge(d1, d4) # this merge creates a problem because of duplicates
          # R assumes that the second Jill also belongs to 
          # Cork county (we want to avoid it so best to join
          # by unique column/obervation ID)

# applying functions to data frames
# since R treats data frame like a list so 'apply' function will evaluate the given
# function on each of the data frame's columns
lapply(d, sort)
lapply(dd, sort)
lapply(d1, sort)

# to get it back into a data frame, we could use:
data.frame(lapply(d, sort)) #but this breaks structure!!!!! Jack is now 10

# LOGISTIC REGRESSION
library(MASS)

help(birthwt)
str(birthwt)
head(birthwt, 10)

birthwt2 <- birthwt[,-c(4,10)]
head(birthwt2, 10)

logfun <- function(x){
  glm(birthwt2$low ~ x, family = binomial)$coef
}
sapply(birthwt2[,-1], logfun)

# relationship between age and low birth in a plot
mod <- glm(birthwt2$low ~ birthwt2$age, family = binomial)$coef 
plot(jitter(birthwt2$age), birthwt2$low, col = "red") 
points(birthwt2$age, 1 / (1 + exp(-(mod[1] + mod[2] * birthwt2$age))),
  pch = 2, col = "green")

mod2 <- glm(birthwt2$low ~ birthwt2$smoke, family = binomial)$coef 
plot(jitter(birthwt2$smoke), birthwt2$low, col = "red") 
points(birthwt2$smoke, 1 / (1 + exp(-(mod[1] + mod[2] * birthwt2$smoke))),
       pch = 2, col = "blue")

?glm

# LAB

data(esoph)
?esoph
?data
esoph
head(esoph)
colnames(esoph) <- c('age', 'alcohol', 'tobacco', 
                     'cases', 'controls')
head(esoph)
esoph[15, 'cases']
esoph[15, 4]
esoph[15, -c(1,2,3,5)]
esoph$observations <- esoph$cases + esoph$controls
head(esoph)

e2 <- data.frame(esoph$cases, esoph$controls)
head(e2)
sapply(e2, mean)
sapply(e2, sd)
sapply(e2, IQR)

summary(esoph)
str(esoph)

low <- subset(esoph, alcohol =='0-39g/day')
low
mean(low$cases)
levels(esoph$alcohol)

high <- subset(esoph, alcohol=='120+')
high
mean(high$cases)

newtext <- 'Lets get back to cricket Suppose that you won the toss today and this
indicates a successful event You toss again but you lost this time If 
you win a toss today this does not necessitate that you will win the 
toss tomorrow Let’s assign a random variable say X to the number of 
times you won the toss What can be the possible value of X It can be
any number depending on the number of times you tossed a coin'
findwords2(newtext)

str(birthwt)

mod3 <- glm(birthwt$low ~ birthwt$lwt, family = binomial)$coef 
plot(jitter(birthwt$lwt), birthwt$low, col = "red") 
points(birthwt$lwt, 1 / (1 + exp(-(mod[1] + mod[2] * birthwt$lwt))),
       pch = 2, col = "blue")

mod3 <- glm(birthwt2$low ~ birthwt2$lwt, family = binomial)$coef 
plot(jitter(birthwt2$lwt), birthwt2$low, col = "red") 
points(birthwt2$lwt, 1 / (1 + exp(-(mod[1] + mod[2] * birthwt2$lwt))),
       pch = 2, col = "green")

# LAB SOLUTIONS

# Lab 3 answers

# Load the esoph inbuilt data set
data(esoph)
?esoph

# Use the colnames function to give it some more helpful column names
colnames(esoph) <- c('Age', 'Alcohol', 'Tobacco', 'NoCases', 'NoControls')

# Three different ways of accessing the number of cases in the 15th record.
esoph$NoCases[15]
esoph[15, 4]
esoph[15, 'NoCases']

# Create a new variable total observations
esoph$TotalObs <- esoph$NoCases + esoph$NoControls

# Create a new data frame which contains only the number of cases and the number of controls columns
esoph2 <- esoph[, 4:5]
esoph2
# Use sapply to calculate the mean, standard deviation and IQR for this new data frame
sapply(esoph2, 'mean')
sapply(esoph2, 'sd')
sapply(esoph2, 'IQR')

# Using subset
esophLowAlc <- subset(esoph, Alcohol=='0-39g/day')
esophHighAlc <- subset(esoph, Alcohol=='120+')
mean(esophLowAlc$NoCases)
mean(esophHighAlc$NoCases)

# Take a new block of text from an Irish Times article and run the findwords function on it.
# Not shown

# Re-create the plot in slide 26 but this time with mother's weight (lwt) instead of age
library(MASS)
data(birthwt)
birthwt2 <- birthwt[,-c(4,10)]

# Plot of low birthwt against lwt
mod <- glm(birthwt2$low ~ birthwt2$lwt, family = binomial)$coef
plot(jitter(birthwt2$lwt),birthwt2$low, col = "red")
points(birthwt2$lwt, 1 / (1 + exp(-(mod[1] + mod[2] * birthwt2$lwt))), pch = 2, col = "green")


