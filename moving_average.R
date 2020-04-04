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
