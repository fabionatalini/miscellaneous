replicate(n=3,expr={
  ruido <- rnorm(n=nrow(cars), mean=0, sd=min(cars$speed))
  x <- cars$speed + ruido
  y <- cars$dist + ruido
  list(x=x,y=y,yhat=predict(lm(y~x)))
}, simplify = "array") -> simulacion

plot(y=cars$dist, x=cars$speed)
abline(lm(cars$dist~cars$speed))
colores <- rainbow(ncol(simulacion))
for(i in 1:ncol(simulacion)){
  points(x=simulacion[1,i]$x, y=simulacion[2,i]$y,col=colores[i])
  abline(lm(simulacion[2,i]$y ~ simulacion[1,i]$x), col=colores[i])
}





