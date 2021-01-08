f <- function (x) (x - 5)^2

iter <- -5:20
z <- c()
for(i in iter){
  z <- c(z,f(x=i))
}

plot(z,xlab="",xaxt="n")
axis(1, at=1:length(z), labels=iter)

optimize(f, interval=c(min(iter), max(iter)), maximum = TRUE)
optimize(f, interval=c(min(iter), max(iter)), maximum = FALSE)


