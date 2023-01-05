# Customizing graph legends.


# Graphical characteristics of plots can be easily and largely customized in R.
# Users can decide to draw a frame around the legend of a graph: the space between the border and the content of the legend can be reduced or enlarged.
# This can be accomplished using R functions for drawing shapes in a graphical area:
# for the legend of a graph, the shape can be a rectangle with the function rect().


# Example data
my_data <- c(110,76,78,80,111,95,89,99,79,84,120,107,87,104,155,167)
names(my_data) <- letters[1:16]


# Plot the data in a bar plot with default legend borders.
# Make the graph:


png("my_graph_defaultborder.png")
my_graph <- barplot(my_data, col = c(rep("blue", 8), rep("red", 8)))


# Add the legend with default borders:


legend("top", legend=c("blue letters", "red letters"), cex=0.9, fill=c("blue", "red"))
dev.off()


# Find the image in your working directory.


# Let's make again the graph with legend borders closer to the legend text.


png("my_graph_closerborder.png")
my_graph <- barplot(my_data, col = c(rep("blue", 8), rep("red", 8)))


# Add the argument bty="n" in legend() to remove the default legend borders:


legend("top", legend=c("blue letters", "red letters"), cex=0.9, fill=c("blue", "red"), bty="n")


# Draw your own rectangle around the legend:


rect(xleft=7.7, ybottom=149.7, xright=11.8, ytop=164.5)
dev.off()


# Let's make again the graph with farther legend borders.


png("my_graph_fartherborder.png")
my_graph <- barplot(my_data, col = c(rep("blue", 8), rep("red", 8)))


# Add the argument bty="n" in legend() to remove the default legend borders:


legend("top", legend=c("blue letters", "red letters"), cex=0.9, fill=c("blue", "red"), bty="n")


# Draw your own rectangle around the legend:


rect(xleft=5, ybottom=140, xright=14, ytop=165)
dev.off()