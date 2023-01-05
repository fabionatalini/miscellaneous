# The Reduce function in R

# Sometimes we need to use the output of a function as input of a second function, then the output of the second function as input of a third one and so on.
# For example, we want to multiply the first two numbers of a sequence, say from 1 to 7, 
# then we want to multiply the result by the third number, then the new result by the fourth number and so on until the seventh number.
result1 <- 1*2
result2 <- result1 * 3
result3 <- result2 * 4
result4 <- result3 * 5
result5 <- result4 * 6
result6 <- result5 * 7

# In fact, this may be accomplished in simpler ways (i.e. 1*2*3*4*5*6*7), but the example is useful to understand the rationale of Reduce.
# Reduce takes a binary function and a series of data (e.g. a list, a sequence), and successively applies the function to the items of the series:
Reduce("*", 1:7)

# Interestingly, the Reduce functions includes the argument accumulate=TRUE which displays the output of each step
Reduce("*", 1:7, accumulate=TRUE)