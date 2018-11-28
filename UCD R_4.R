demo(graphics)

# the plot function
plot(x, y)  # x and y are vectors

x <- c(1, 2, 3)
y <- c(1, 2, 4) 
plot(x, y)

plot(x, y, 
     xlab='x-axis', ylab='y-axis', # specifies the axes
     type='l',  # specifies the plot type to be a line
     main='My graph') #  specifies the main title

# adding to graphs
plot(x, y, type='n')  # blank graph
lines(x, y, col='red', lty=2, lwd=3)  # add red line
points(x, y, col='blue', pch=17, cex=2) # add blue points to line

plot(c(1, 2, 3), c(1, 2, 3), main ='plot 1')
plot(c(3, 2, 1), c(1, 2, 3))

# lty specifies the line type. lwd specifies the line width
help(lines)
# pch specifies the plotting character. cex specifies the point size 
help(points)

# adding text with text function
plot(x, y, type='b', pch=4)
text(1.5, 2.5, 'Text here') # the numbers refer to axes!
# the first 2 arguments specifythe x,y locations of the text
# the 3rd element gives text itself
# useful extra argument is pos which allows you to put the text:
# below (pos=1), left (pos=2), above (pos=3), right (pos=4) in repect
# of the chosen location

# adding text with mtext function
# if you want add text in the margin (outside the plotting region), 
# use the mtext function
mtext('Margin text', side=4, line=1)
# the side argument indicates which margin to write beside (1= bottom,
# 2= left, 3= top, 4= right)
# line tells R how far away from the margin the text should be
mtext('Margin text', side=3, line=2)

# changing colours
colours()
# colours case be used with the following:
par(bg= 'yellow')  # yellow background (have to re-run graph)
plot(x, y, type= 'n')
lines(x, y, col='blue')
points(x, y, pch=4, col= 'red')  # red points
# par controls persistent graphical parameters

par(bg= 'white')
# adding a legend with legend function

# the default usage is legend(x, y, legend, pch, lty, col) 
# where x, y is the location where you want the legend to be, 
# legend is a vector of names, pch are the plotting characters, 
# lty are the line formats, and col are the colours.

plot(x, y, type='p', pch=4, col='red')
lines(x, y, lty=2, col= 'red')
legend(1, 4, legend= c('My points', 'My lines'), 
       pch= c(4, -1), lty= c(-1, 2), col= 'red') # pch and lty here must
                                # match the entries in plot() and lines()
# 1, 4 are coordinates for the legend
# legend vector contains the legen text

# NOTE: here -1 produces a blank (no point or line)
# you can replace x, y with topleft, bottomleft etc
# if you want to get rid of the box use bty='n'

# customisation
# sizes: cex (character expansion) and is given relative to the standard size

plot(x, y, type= 'b', cex=1.5)
text(1.5, 2.5, 'Text here', cex=1.5)

# cex=1.5 will give text that's 1.5 the usual size
# the same argument works in plot, points, main, mtext

# fonts
plot(x, y, type= 'b', cex=1.5)
text(1.5, 2.5, 'text here', font=2, family='HersheyGothicEnglish')
text(1.5, 3.5, 'text here', font=3, family='mono', col='red')

# putting maths in legend
# using Greek letter or other symbols in a plot title of axis
help(plotmath)
?expression
?paste

# example:
plot(x, y, xlab = expression(paste(x[1],"=", phi)),
     main = expression(paste(y^2 + 2 %->% infinity)), col.main = "red")
text(2, 3, expression(paste(frac(1, sigma * sqrt(2 * pi)), " ", 
                            plain(e)^{frac(-(x - mu)^2, 2 * sigma^2)})))

# many of the usual arguments (e'g' cex, col) can be applied here

# Axes
plot(x, y, type= 'b', pch=4, col= 'red', lty=2, xlim= c(0, 10), ylim= c(-2, 5))
plot(x, y, type= 'b', pch=4, col= 'red', lty=2, xlim= c(10, 0), ylim= c(-2, 5))

# axis function to create own specialist axis
plot(x, y, type= 'b', pch=4, col= 'red', xaxt= 'n')
axis(side=1, at= seq(1, 3, by= 0.1), label= TRUE)

# setting persistent defaults
# the par function creates a default plotting environment BUT EVEYTHING you set
# becomes permanent!!!
help(par)
# useful arguments for par():
# mar and mgp - default margins and plotting regions
# usr - gets the current plot limits
# mfrow/mfcol - plots an array of graphs
# las - rotates the axis label
# bg - set the background colour

# useful comman at start of a function to produce a plot is:
par(mar = c(3, 3, 2, 1), mgp = c(2, 0.7, 0), las = 1)
# ?????

# brilliant resource: http://gastonsanchez.com/r-graphical-parameters-cheatsheet.pdf

# saving graphs to files
# better to save through command, not export button
pdf("myfilename.pdf", width = 10, height = 8) 
# Plotting commands go here
dev.off()

# BAR CHARTS
stores <- factor(rep(c("Tesco", "Supervalu", "M&S", "Dunnes Stores"), c(100, 30, 25, 85))) 
par(mar = c(5, 7, 1, 2)) # Adjust the margins on the four sides of the plot
barplot(height = table(stores), main = "Stores in Ireland", xlab = "Number of stores", col = 1:4, horiz = TRUE, las = 1)

?barplot
?factor

# HISTOGRAMS
library(MASS) 
hist(birthwt$bwt)

# to spice it up:
hist(birthwt$bwt, breaks = 30, xlab = "Birth weight (grams)", 
     main = "Histogram of birth weight", col = "lightblue")

hist(birthwt$bwt, breaks = 20, xlab = "Birth weight (grams)", 
     main = "Histogram of birth weight", col = "lightblue")

#DENSITY PLOTS (continuous line version of a histogram)
# the density function is not a plotting fucntion but can be 
# called directly by plot

plot(density(birthwt$bwt))

# better version:
plot(density(birthwt$bwt), xlab = "Birth weight (grams)", 
     main = "Histogram of birth weight", col = "green", lwd = 4)

# BOXPLOTS
boxplot(birthwt$bwt ~ birthwt$race, ylab = "Birth weight (grams)", xlab = "Race")

# better:
boxplot(birthwt$bwt ~ birthwt$race, xaxt = "n", # xaxt = "n" removes the x axis 
        main = "Birth weight by race", col = 2:4, ylab = "Birth weight (grams)")
        # Add the x axis with new labels:
axis(1, at = 1:3, labels = c("White", "Black", "Other"))

# PIE CHARTS (NOT IDEAL!!!)
pie(table(stores))

# multiple panels (through par)
par(mfrow = c(2, 2)) # creates a 2 by 2 plotting matrix which is then filled in by row
hist(birthwt$bwt, breaks = 30, xlab = "Birth weight (grams)",
     main = "Histogram of birth weight", col = "lightblue")
plot(density(birthwt$bwt), xlab = "Birth weight (grams)",
     main = "Histogram of birth weight", col = "green", lwd = 2)
boxplot(birthwt$bwt ~ birthwt$race, xaxt = "n", 
        main = "Birth weight by race", col = 2:4) 
pie(table(stores))

# 3D plots (usually require input as a matrix or a 3 vectors x, y, z)
par(mfrow = c(2, 3))
contour(volcano, main = "contour plot")  # contour plot
image(volcano, main = "image plot") # image plot
persp(volcano, main = "perspective plot") # perspective plot

# nicer ones
filled.contour(volcano, main = "Maunga Whau volcano heights", xlab = "x",
               ylab = "y")

persp(volcano, theta = 20, phi = 30,
      col = "green3", main = "Maunga Whau", 
      expand = 0.25, ltheta = 150, shade = 0.75, 
      border = NA, box = FALSE)

# maps
# R has the ability to read in both Google maps and OpenStreetMaps. 
# These essentially load in the map as a background and allow you t
# to plot on top of it.

# extended example
# publication standard graphs

#the default command
library(MASS)
x <- birthwt$lwt 
y <- birthwt$low 
plot(x, y)

birthwt$lwt

# set up plot frame:
par(mar = c(3, 3, 2, 1), mgp = c(2, 0.7, 0), las = 1) 
plot(x, y, type = "n", xaxt = "n", yaxt = "n", 
     xlab = "Mother's weight (lbs)", ylab = "Low birth weight (probability)") 
      title("Risk factors associated with low infant birth weight")
axis(1, at = pretty(x, n = 10))
axis(2, at = pretty(y, n = 10))
grid()

?pretty
par(mar = c(3, 3, 2, 1), mgp = c(2, 0.7, 0), las = 1) 
plot(x, y, type = "n", xaxt = "n", yaxt = "n", 
     xlab = "Mother's weight (lbs)", ylab = "Low birth weight (probability)") 
title("Risk factors associated with low infant birth weight")
axis(1, at = pretty(x, n = 20))
axis(2, at = pretty(y, n = 20))
grid()


# adding points and lines
points(jitter(x, amount = 0.5), y, col = "blue", pch = 20)

# adding fitted line from a logistic regression
mod <- glm(y ~ x, family = binomial)
xgrid <- seq(min(x), max(x), by = 1)
ypred <- predict(mod, data.frame(x = xgrid), se.fit = TRUE, type = "response") 
lines(xgrid, ypred$fit, col = "red", lwd = 2)

# uncertainty bands (not working!!!)
newcol <- rgb(1, 0, 0, 0.2)
ypred.lower <- ypred$fit - 1.96 * ypred$se.fit
ypred.upper <- ypred$fit + 1.96 * ypred$se.fit
polygon(c(xgrid, rev(xgrid)), c(ypred.lower, rev(ypred.upper)), col = newcol, border = NA)

legend("topright", legend = c("Data", "Fitted line", "95% CI"), 
       pch = c(20, -1, 15), lty = c(-1, 1, -1), lwd = c(-1, 2, -1), 
       col = c("blue", "red", newcol))

# LAB

demo(graphics)

library(MASS)

survey
head(survey)
str(survey)
help(survey)

x <- survey$Wr.Hnd
y <- survey$NW.Hnd

par(bg= 'gray') 
plot(x, y, type= 'n')
cols <- c('red', 'blue')
with(survey,plot(x,y,col=cols[survey$Sex],xlab= 'Writing hand', ylab= 'Non writing hand' ))
legend('topleft',legend=levels(survey$Sex),col=cols,pch=1,title='Sex')
title('Span of writing vs non writing hand')


par(mar= c(3, 3, 1, 3))
barplot(height = table(survey$Smoke), main = "Smoking",
        names.arg = c('Heavy', 'Never', 'Occasional', 'Regular'),
        col= c('red', 'blue', 'yellow', 'dark blue'),
        ylim= c(0, 200), xlab= 'levels of smoking')

?barplot
levels(survey$Smoke)
?par

par(mfrow = c(2, 1))
par(mar= c(3, 3, 1, 3))
barplot(height = table(survey$Smoke[survey$Sex == 'Male']), main = "Smoking",
        names.arg = c('Heavy', 'Never', 'Occ', 'Regular'),
        col= c('red', 'blue', 'yellow', 'dark blue'),
        ylim= c(0, 200))

barplot(height = table(survey$Smoke[survey$Sex == 'Female']), main = "Smoking",
        names.arg = c('Heavy', 'Never', 'Occ', 'Regular'),
        col= c('red', 'blue', 'yellow', 'dark blue'),
        ylim= c(0, 200))


par(mfrow = c(2, 1))
par(mar= c(3, 3, 1, 3))
barplot(height = table(survey$Smoke[survey$Sex == 'Male']), main = "Smoking in males",
        names.arg = c('Heavy', 'Never', 'Occ', 'Regular'),
        col= c('red', 'blue', 'yellow', 'dark blue'),
        xlim= c(0, 200), horiz = TRUE)

barplot(height = table(survey$Smoke[survey$Sex == 'Female']), main = "Smoking in females",
        names.arg = c('Heavy', 'Never', 'Occ', 'Regular'),
        col= c('red', 'blue', 'yellow', 'dark blue'),
        xlim= c(0, 200), horiz = TRUE)

survey$Smoke[survey$Sex == 'Male']

# 7
head(survey)

par(mfrow = c(1, 1), las =1)
par(bg= 'white') 
boxplot(survey$Pulse ~ survey$Exer, xaxt = "n", ylab = "pulse", xlab = "exercise status",
        main = 'Pulse vs exercise status', col= c('light green', 'tomato', 'light blue'))
axis(1, at = 1:3, labels = c("Frequent", "None", "Some"))
grid()

?boxplot


#####################
# Extended example - plot of fitted models for birth weight data

# Make it easier to access the data
birthwt
x <- birthwt$age
y <- birthwt$low

# Basic plot we're going to improve
plot(x, y)

# Set up the plot frame
par(mar = c(3, 3, 2, 1), mgp = c(2, 0.7, 0), las = 1)
plot(x, y, type = "n", xaxt = "n", yaxt = "n", 
     xlab = "Mother's age", ylab = "Low birth weight (probability)")
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



#

x <- birthwt$smoke
y <- birthwt$low

plot(x, y)

# Set up the plot frame
par(mar = c(3, 3, 2, 1), mgp = c(2, 0.7, 0), las = 1)
plot(x, y, type = "n", xaxt = "n", yaxt = "n", 
     xlab = "Smoking mother", ylab = "Low birth weight (probability)")
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
