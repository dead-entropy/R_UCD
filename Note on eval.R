####################################################
# Note on eval() and D()
####################################################

# Clear everything:
rm(list = ls())

# D() is used to differentiate mathematical expressions:
D(expression(x^2), 'x')

# This returns a symbolic object (an expression)
# R doesn't see this as a function, and can't,
# for example, substitute x into it

# D() won't work without the expression function:
D(2 * x^2 + 3 * x - 5, 'x')

x <- 2
D(2 * x^2 + 3 * x - 5, 'x')
# Now D() thinks I want to differentiate
# 2 * 2^2 + 3 * 2 - 5, which is of course 0

####################################################

# If we use the eval() function,
# we're telling R to see the result from D() as a function
# with unknowns that can be filled in and evaluated:
x <- 5
eval(D(expression(x^2), 'x'))

# This returns 10, as it should
# The derivative of x^2 is 2 * x
# Then 2 * x is 10 since x is 5

# I can then use curve() to draw the original function:
curve(x^2, from=0, to=5)

# And also to draw the derivative:
# (add=TRUE means that I add the line on
# top of the existing plot)
curve(eval(D(expression(x^2), 'x')),
      from=0, to=5, add=TRUE)

# Note that in line 41, we need to have
# curve(eval(D(), from=..., to=...)
# even though it looks a little messy
