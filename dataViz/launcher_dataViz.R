# # create demo data
# write.table(mtcars, "C:/Users/fabnatal/Documents/dataViz/data_demo.txt",
#             row.names = F, sep = "\t",quote = F)

################### Please set the arguments #########################
mypath <- "C:/Users/fabnatal/Documents/dataViz"
mydataset <- "data_demo.txt"

################### What follows is up to me #########################
library(shiny)
runApp(mypath)
