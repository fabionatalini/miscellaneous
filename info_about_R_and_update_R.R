#Get info about your R system


#With these commands you can get some miscellaneous information about R, including the version of R you are using, how to update your R version, and browsing R directories.

#What version of R am I using
R.Version()

#the version is given by $major and $minor
R.Version()$major
R.Version()$minor 

#Update the R version
library(installr)
updateR()
#it will ask if you want to move all the packages installed in the old version to the new version
#say yes, otherwise you may use the following
setwd("C:/Temp/") #run this in the old version of R
packages <- installed.packages()[,"Package"]
save(packages, file="Rpackages")
#now run the following in the new version of R
setwd("C:/Temp/")
load("Rpackages")
for (p in setdiff(packages, installed.packages()[,"Package"]))install.packages(p)

#Where does R store packages?
.libPaths()


#How can I change the directory in which R stores and accesses packages?
.libPaths(“C:/myfolder”)