# Use of plot
x <- c(1, 2, 3)
y <- c(1, 2, 4)
plot(x, y)

plot(x, y, 
  xlab = "x", ylab = "y", # specify the x and y-axis labels
  type = "l", # specify the plot type to be a line
  main = "My graph") # specify the main title

plot(c(1, 2, 3), c(1, 2, 3))
plot(c(3, 2, 1), c(1, 2, 3))

# Add points and lines
plot(x, y, type = "n") # create blank graph
lines(x, y, col = "red", lty = 2, lwd = 3) # add the red line
points(x, y, col = "blue", pch = 17, cex = 2) # add the blue points

# Use of the text and mtext functions
plot(x, y, type = "b", pch = 4)
text(1.5, 2.5, "Text here")
mtext("Margin text", side = 4, line = 1)

# See list of colours
colours()

# Use them
par(bg = "yellow") # yellow background
plot(x, y, type = "n")
lines(x, y, col = "blue") # blue lines
points(x, y, pch = 4, col = "red") # red points

# Create a legend
plot(x, y, type = "p", pch = 4, col = "red")
lines(x, y, lty = 2, col = "red" )
legend(1, 4, # x, y coordinates for the legend
  legend = c("My points", "My lines"), # vector containing the text to appear in the legend
  pch = c(4, -1), lty = c(-1, 2), col = "red") # graphical parameters: point type, line type and color

# or
legend("topleft", # x, y coordinates for the legend
  legend = c("My points", "My lines"), # vector containing the text to appear in the legend
  pch = c(4, -1), lty = c(-1, 2), col = "red") # graphical parameters: point type, line type and color

#####################

## Customisation

# Use of cex
plot(x, y, type = "b", pch = 4)
text(1.5, 2.5, "Text here", cex = 1.5)
text(1.5, 3.5, "Text here", cex = 0.75)

# Use of different font types
text(1.5, 2.5, "Text here", font = 2, family = "HersheyGothicEnglish")
text(1.5, 3.5, "Text here", font = 3, family = "mono", col = "red")

# Use of plot math
# A simple example
plot(x, y, xlab = expression(paste(x[1],"=", phi)), 
  main = expression(paste(y^2 + 2 %->% infinity)), col.main = "red")

# A more complicated example
text(2, 3, expression(paste(frac(1, sigma * sqrt(2 * pi)), " ", plain(e)^{frac(-(x - mu)^2, 2 * sigma^2)}))) 

# Changing the axis limits
plot(x, y, type = "b", pch = 4, col = "red", lty = 2, xlim = c(0, 10), ylim = c(-2, 5))

# Reversed x-axis
plot(x, y, type = "b", pch = 4, col = "red", lty = 2, xlim = c(10, 0), ylim = c(-2, 5))

# Use of axis function
plot(x, y, type = "b", pch = 4, col = "red", xaxt = "n")
axis(side = 1, at = seq(1, 3, by = 0.1), labels = TRUE)

# Use of par
par(mar = c(3, 3, 2, 1), mgp = c(2, 0.7, 0), las = 1)

# Save a graph
pdf("myfilename.pdf", width = 10, height = 8)
plot(x, y, type = "b", pch = 4, col = "red", xaxt = "n")
axis(side = 1, at = seq(1, 3, by = 0.1), labels = TRUE)
dev.off()

#####################

## Fancy graphics

# Bar charts
stores <- factor(rep(c("Tesco", "Supervalu", "M&S", "Dunnes Stores"), c(100, 30, 25, 85)))
par(mar = c(3, 7, 1, 1)) # Adjust the margins on the four sides of the plot
barplot(height = table(stores), main = "Stores in Ireland", xlab = "Number of stores",
  col = 1:4, horiz = TRUE, las = 1)

# Set margins back to defaults
par(mar = c(5, 4, 4, 2) + 0.1)

# Histograms - do birth weight
library(MASS)
hist(birthwt$bwt)
# Nicer version
hist(birthwt$bwt, breaks = 30, xlab = "Birth weight (grams)", 
  main = "Histogram of birth weight", col = "lightblue")

# Density plot
plot(density(birthwt$bwt))
# Nicer version
plot(density(birthwt$bwt), xlab = "Birth weight (grams)", 
  main = "Histogram of birth weight", col = "green", lwd = 2)

# Boxplots - plot birthwt by race
boxplot(birthwt$bwt ~ birthwt$race, ylab = "Birth weight (grams)", xlab = "Race")
# Better version
boxplot(birthwt$bwt ~ birthwt$race, xaxt = "n", # xaxt = "n" removes the x axis
  main = "Birth weight by race", col = 2:4, ylab = "Birth weight (grams)")
# Add the x axis with new labels:
axis(1, at = 1:3, labels = c("White", "Black", "Other"))

# Pie charts - Yuck
pie(table(stores))

#####################

# Multiple panels
par(mar = c(3, 3, 2, 1), mgp=c(2,0.7,0),las=1)
par(mfrow = c(2, 2)) # creates a 2 by 2 plotting matrix which is then filled in by row
hist(birthwt$bwt, breaks = 30, xlab = "Birth weight (grams)", 
  main = "Histogram of birth weight", col = "lightblue")
plot(density(birthwt$bwt), xlab = "Birth weight (grams)", 
  main = "Histogram of birth weight", col = "green", lwd = 2)
boxplot(birthwt$bwt ~ birthwt$race, xaxt = "n", main = "Birth weight by race", col = 2:4)
pie(table(stores))

par(mfrow = c(1, 1)) # Restore default

# Some 3D plots - use volcano data to show the difference
help(volcano)
str(volcano)
par(mfrow = c(1, 3))
contour(volcano, main = "contour plot")
image(volcano, main = "image plot")
persp(volcano, main = "perspective plot")

# Nicer versions
filled.contour(volcano, 
  main = "Maunga Whau volcano heights", 
  xlab = "x", 
  ylab = "y")

persp(volcano, theta = 20, phi = 30, 
  col = "green3", main = "Maunga Whau", 
  expand = 0.25, ltheta = 150, shade = 0.75, 
  border = NA, box = FALSE)

# A demo of nice perspective plots
demo(persp)

#####################
# Extended example - plot of fitted models for birth weight data

# Make it easier to access the data
x <- birthwt$lwt
y <- birthwt$low

# Basic plot we're going to improve
plot(x, y)

# Set up the plot frame
par(mar = c(3, 3, 2, 1), mgp = c(2, 0.7, 0), las = 1)
plot(x, y, type = "n", xaxt = "n", yaxt = "n", 
  xlab = "Mother's weight (lbs)", ylab = "Low birth weight (probability)")
title("Risk factors associated with low infant birth weight")
axis(1, at = pretty(x, n = 10))
axis(2, at = pretty(y, n = 10))
grid()

# Add in the data
points(jitter(x, amount = 0.5), y, col = "blue", pch = 20)

# Add in the fitted line
mod <- glm(y ~ x, family = binomial)
xgrid <- seq(min(x), max(x), by = 1) 
ypred <- predict(mod, data.frame(x = xgrid), se.fit = TRUE, type = "response")
lines(xgrid, ypred$fit, col = "red", lwd = 2)

# Create a polygon with uncertainties in a translucent colour
newcol <- rgb(1, 0, 0, 0.2)
ypred.lower <- ypred$fit - 1.96 * ypred$se.fit
ypred.upper <- ypred$fit + 1.96 * ypred$se.fit
polygon(c(xgrid, rev(xgrid)), c(ypred.lower, rev(ypred.upper)), 
  col = newcol, border = NA)

# Add in the legend
legend("topright", legend = c("Data", "Fitted line", "95% CI"), pch = c(20, -1, 15), 
  lty = c(-1, 1, -1), lwd = c(-1, 2, -1), col = c("blue", "red", newcol))

