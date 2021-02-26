################### moving average using stats::filter #######################
# this is a centered moving average
ma <- function(x,n=5){stats::filter(x, rep(1 / n, n), method="convolution", sides=2)}

datos <- mtcars$mpg

mediamovil <- ma(datos)
matplot(data.frame(datos, mediamovil), type="l")

mediamovil <- ma(datos,n=10)
matplot(data.frame(datos, mediamovil), type="l")

# how stats::filter works
coef1 <- 2
coef2 <- 2
x <- c(1:5)
stats::filter(x,c(coef1, coef2))
# 6 10 14 18 NA
# that is:
x[1]*coef1+x[2]*coef2
x[2]*coef1+x[3]*coef2
x[3]*coef1+x[4]*coef2
x[4]*coef1+x[5]*coef2
x[5]*coef1+x[6]*coef2

################### moving average using loops #######################
# note: this is not a centered moving average
# it is build upon the last number of the window
movAvg <- function(x,width,inputConstant=FALSE){
  lx <- length(x)
  result <- c()
  while(TRUE){
    w <- tail(x,width)
    if(length(w)<width){break}
    result <- c(result,mean(w))
    x <- head(x,-1)
  }
  result <- rev(result)
  if(inputConstant){
    lxr <- lx-length(result)
    if(lxr>0){
      result <- c(rep(result[1],lxr),result)
    }
  }
  return(result)
}

mediamovil <- movAvg(datos, 5, inputConstant=TRUE)

matplot(data.frame(datos, mediamovil), type="l")


