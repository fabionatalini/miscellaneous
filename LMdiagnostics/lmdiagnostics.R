############################ arguments ##################################
setwd("/home/fabio/Documents")
# https://online.stat.psu.edu/stat462/sites/onlinecourses.science.psu.edu.stat462/files/data/bloodpress/index.txt
datos <- read.delim("bloodpressure.txt",header=TRUE)
variable_respuesta <- "BP"

############################ process ##################################
if(!dir.exists(file.path(getwd(),"diagnostico_MMM"))){
  dir.create(file.path(getwd(),"diagnostico_MMM"))
}

setwd(file.path(getwd(),"diagnostico_MMM"))

calcuvif <- function(x,depvar){
  indepvar <- x[,-which(names(x)==depvar)]
  mylist <- list()
  for(i in 1:ncol(indepvar)){
    varname <- names(indepvar[,i,drop=FALSE])
    fo <- formula(paste0(varname,"~."))
    rsq <- summary(lm(fo,data=indepvar))$r.squared
    mylist[varname] <- 1/(1-rsq)
    viftable <- setNames(data.frame(do.call(rbind, mylist)),"VIF")
  }
  return(viftable)
}

viewer <- function(x,depvar){
  fo <- formula(paste0(depvar,"~."))
  mymodel <- lm(fo,data=x)
  suffix <- paste0("_",gsub(":","",gsub(" ","_",Sys.time())))
  pdf(file = paste0("diagnostico_residuales",suffix,".pdf"))
  par(cex.main=0.9,cex.lab=0.8,mfrow=c(2,2),mar=c(4,3,2,1))
  plot(mymodel$residuals,main="Residual plot",ylab="",xlab="")
  abline(h=0)
  plot(mymodel$residuals~mymodel$fitted.values,xlab="",ylab="",main="Residuals vs. fitted")
  abline(h=0)
  hist(mymodel$residuals, main="Histogram of residuals",ylab="",xlab="")
  qqnorm(mymodel$residuals,ylab="",xlab="")
  qqline(mymodel$residuals,ylab="",xlab="")
  dev.off()
}

ShapiroWilk <- function(x,depvar){
  fo <- formula(paste0(depvar,"~."))
  mymodel <- lm(fo,data=x)
  return(shapiro.test(mymodel$residuals))
}

viewer(datos,variable_respuesta)
suffix <- paste0("_",gsub(":","",gsub(" ","_",Sys.time())))
sink(paste0("vif_shapiroTest",suffix,".txt"))
ShapiroWilk(datos,variable_respuesta)
calcuvif(datos,variable_respuesta)
sink()

