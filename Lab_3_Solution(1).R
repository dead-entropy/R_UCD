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
