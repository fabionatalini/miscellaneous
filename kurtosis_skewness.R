library(moments)

ku <- function(x) {
  return(sum(
    ( ((x-mean(x))^4) / length(x) ) / (sd(x))^4
  ))
}

sk <- function(x) {
  return(sum(
    ( ((x-mean(x))^3) / length(x) ) / (sd(x))^3
  ))
}

set.seed(1)
data.n <- rnorm(1000)
set.seed(1)
data.t <- rt(1000,df=3)

add.lines <- function(x){
  lines(density(x),col='blue')
  lines(min(x):max(x),dnorm(min(x):max(x),mean=mean(x), sd=sd(x)),col='red')
}

par(mfrow=c(1,2))
hist(data.n,prob=TRUE,ylim=c(0,0.5))
add.lines(data.n)

hist(data.t,prob=TRUE,ylim=c(0,0.5))
add.lines(data.n)

moments::kurtosis(data.n)
ku(data.n)
moments::skewness(data.n)
sk(data.n)

moments::kurtosis(data.t)
ku(data.t)
moments::skewness(data.t)
sk(data.t)

