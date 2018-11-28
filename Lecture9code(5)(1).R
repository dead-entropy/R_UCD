# Lecture 9 code

# Best to set your working directory in a folder which contains the Week 9 files.

# Use the scan function to read the files
scan('z1.txt')
scan('z2.txt')
scan('z3.txt')
scan('z3.txt', what = '')
scan('z3.txt', what = 'character')
scan('z4.txt', what = '')

# Return it to an object
x1 <- scan('z3.txt', what = '')
x2 <- scan('z3.txt', what = '', sep = '\n')
x1
x2
?scan

# Read in from the R console 
v <- scan('') #??????
v

# Use of readline
z <- readline()
z

inits <- readline('Type your initials: ')
inits

?readLines
########################################

# Printing to the screen
x <- 1:3
print(x^2)
cat('The values of x are', x, '\n')
cat('The values of x are', x, '\n', sep = '')
?cat

?read.table
?read.delim

# Connections
?connection
# See the examples in that file

# Using a connection - try loading in the file 

y <- file('z5.txt','r')
y
readLines(y, n = 1)
readLines(y, n = 1)
readLines(y, n = 1)
readLines(y, n = 1)
# rewind
seek(con = y, where = 0)
readLines(y, n = 1)
close(y)

# Use of write.table
kids <- c('Jack', 'Jill')
ages <- c(12, 10)
d <- data.frame(kids, ages, stringsAsFactors = FALSE)
write.table(d, file = 'd1.txt')
write.table(d, file = 'd2.txt', quote = FALSE, row.names = FALSE)
write.csv # similar

# Use of cat
x <- 2:4
cat('abc\n ', x, file = 'd3.txt', sep = '')
cat(x, 'de\n', x, file = 'd4.txt', append = TRUE)

# Reading and writing from the clipboard - these are windows only
x <- "hello world"
writeClipboard(x)
x <- 3.14
writeClipboard(x)
# Copy something to the clipboard and then run this line
x <- readClipboard()


#
library(foreign) # reading in other types of files
??foreign

#
list.files()

########################################

# Reading in data from the internet:

# Load in some data from the web
prostate.url <- 
  'https://web.stanford.edu/~hastie/ElemStatLearn/datasets/prostate.data'
prostate <- read.table(prostate.url, header = TRUE, sep = '\t', row.names = 1)
head(prostate)

# Use RCurl
library(bitops)
library(RCurl)
??getUrl

# Download the webpage
oct17 <- getURL("https://stat.ethz.ch/pipermail/r-help/2017-October/date.html")
# Sort into lines
oct17
webpage <- strsplit(oct17,"\n")[[1]] 
webpage[1:5]
webpage[1:25]
class(webpage)
webpage

# Use of XML
library(XML)
library(xml2)
myurl <- getURL('https://en.wikipedia.org/wiki/Comparison_of_statistical_packages')
mytable <- read_html(myurl)[[2]]  # readHTMLTable(myurl)[[2]]
mytable

########################################

#  String manipulation

# Use of grep
grep('Pole', c('Equator', 'North Pole', 'South Pole'))
grep('pole', c('Equator', 'North Pole', 'South Pole'))
grep('pole', c('Equator', 'North Pole', 'South Pole'), ignore.case = TRUE)
?grep

grep("a+", c("abc", "def", "cba a", "aa"), perl=TRUE, value=FALSE)
# returns positions of elements that have 'regex'
grep("a+", c("abc", "def", "cba a", "aa"), perl=TRUE, value=TRUE)
# returns the values of elements that have 'regex'

# gsub
x <- 'South Pole'
gsub('South', 'North', x)
x
?gsub

# nchar
nchar('South Pole')
nchar('SouthPole')

# substr
substr('Equator', 1, 2)
substr('Equator', 3, 5)
?substr

# strsplit
strsplit('October-17', split = '-')
d <- strsplit('October-17', split = '-')
d

# paste
paste('North', 'Pole')
paste('North', 'Pole', sep = '')
x <- 'and'
paste('North', x, 'South', 'Pole')

# sprintf
i <- 8
s <- sprintf('the square of %d is %d', i, i^2)
s

# regexpr
regexpr('an','Banana')
?regexpr

# gregexpr
gregexpr('an','Banana')


########################################

# Example regular expressions

# Find 'a' or 'u' in a vector
grep('[au]', c('Equator', 'North Pole', 'South Pole'))

# Find places where 'o' is followed by a character and then an 'e'
grep('o.e', c('Equator', 'North Pole', 'South Pole'))

# Find places where 'N' is separated by two characters from 't'
grep('N..t', c('Equator', 'North Pole', 'South Pole'))

# What if you want to search for a .?
grep('.', c('abc', 'de', 'f.g'))

# The way it's done
grep('\\.', c('abc', 'de', 'f.g'))

# More examples - states ending in 'ana'
state.name[grep('ana$', state.name)]

# States beginning with 'South'
state.name[grep('^South', state.name)]

# More on regular expressions
?regexp

# It doesn't have to be single characters
words <- c('cat','bat','dog','rabbit','rat')
grep('bat|cat', words)

# bat or cat
words[grep('(b|c)at', words)]

# At least zero of b or c
words[grep('(b*|c*)at', words)]


########################################

## Examples


# Example 1: forming file names
for(i in 1:5) { 
  fname <- paste('N(0,', i, ').pdf', sep = '')
  pdf(fname)
  hist(rnorm(100, sd = i))
  dev.off()
}

# the files has been saved in your working directory

# Example 2: find files in a directory ending in a certain type
list.files(getwd(), '\\.txt$')
list.files(getwd(), '\\.pdf$')

# Example 3 web scraping and then cleaning up
library(bitops)
library(RCurl)
oct17 <- getURL("https://stat.ethz.ch/pipermail/r-help/2017-October/date.html")
webpage <- strsplit(oct17, "\n")[[1]] # download the webpage see slide 21
webpage
# get the lines that contains the authors 
# [the authors are in italic, so html code starts with "<I>"]:
authorsraw <- grep("<I>", webpage, value = TRUE)
authors <- gsub("<I>", "", authorsraw, fixed = TRUE) # only keep the names
# create a table that contains the number of contributions for each author, 
# and sort it in decreasing order:
author_counts <- sort(table(authors), decreasing = TRUE) 
author_counts[1:5]

# LAB 9 #############

#1 
?read.delim

text1<- read.delim('file1.rtf', header=TRUE, sep='$')
head(text1)
text1.1 <- read.delim('file1.rtf', sep='$', skip = 6)
head(text1.1, 20)
str(text1)
which(text1.1==-99) #works
text1.1[823,]

#2 

?scan
text2 <- scan('file2.rtf', what= 'character' , sep='', skip =9)
text2
str(text2)
substr(text2, 3, 3) # did it!!!

# 3

text3 <- scan('file3.rtf', what= 'character')
text3
FR <- grep('Freeman', text3, value = T)
NI <- grep('Nicholson', text3, value = T)
PI <- grep('Pitt', text3, value = T)
FR
NI
PI
lst.act <- list(FR, NI, PI)
lst.act
s <- lapply(lst.act, length)
s

# 4
text4 <- scan('file4.rtf', what = 'character')
text4

spam <- getURL("https://web.stanford.edu/~hastie/ElemStatLearn/datasets/spam.data")
spam
?read.delim

webpage <- strsplit(spam, "\n")[[1]]
str(webpage)
webpage2 <- strsplit(spam, " ")[[1]]
webpage2
str(webpage2)
ww <- substr(webpage2, 1, 58)
str(ww)
ww
matrix(ww)
