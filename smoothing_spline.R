datos <- mtcars$mpg

k <- 10
curva <- smooth.spline(x=1:length(datos),y=datos,all.knots=FALSE,nknots=k)$y

matplot(data.frame(datos, curva), type = "l")


