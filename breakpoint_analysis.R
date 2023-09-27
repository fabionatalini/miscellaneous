library(segmented)
library(plotly)

set.seed(1)
datos <- (c(rnorm(20,mean=5,sd=1),rnorm(20,mean=10,sd=1)))
datos <- data.frame("X"=1:length(datos),"Y"=datos)

plot(x=datos$X, y=datos$Y, ylab="Y",xlab="")

modelo.lm <- lm(Y~X, data=datos)

lines(fitted.values(modelo.lm), col="red")

fit.seg <- segmented(modelo.lm, seg.Z = ~X, psi=20)
# summary(fit.seg)
# summary(modelo.lm)

lines(fitted.values(fit.seg), col="blue")

# Davison and Hinkley (1997)
modelo.lm<-update(modelo.lm,.~.-X)
fit.seg1<-update(fit.seg)
lines(fitted.values(fit.seg1), col="darkgreen")

slope(fit.seg)
slope(fit.seg1)

fit.seg[["psi"]]
fit.seg1[["psi"]]

##########################
data("down")
fit.glm<-glm(cases/births~age, weight= births, family=binomial, data=down)
fit.seg<-segmented(fit.glm, seg.Z=~age,psi=25)

fit.glm<-update(fit.glm,.~.-age)
fit.seg1<-update(fit.seg)

fit.seg$psi
fit.seg1$psi

plot(x=down$age,y=down$cases/down$births,ylab="cases/births",xlab="age")
lines(x=down$age, y=fitted.values(fit.seg),col='red')
lines(x=down$age, y=fitted.values(fit.seg1),col='blue')

##########################
rm(list=ls())
canarias <- read.delim(
  "J:/PMED_Practices/Data_Sciences/Advanced Analytics/Analisis/Clientes/Ebro Foods/2023/03 Modelizacion/Brillante Calidad Oro Canarias/2.v2/raw.txt"
)

datos <- data.frame("domingo"=canarias$FECHA,"X"=1:nrow(canarias),"Y"=canarias$VVOL)

plot_ly(data=datos, x = ~as.Date(datos$domingo,"%d/%m/%Y"), y = ~Y, type = 'scatter', mode = 'lines') %>%
  layout(xaxis = list(title = 'semana (fecha domingo)'), yaxis = list (title = 'ventas VVOL'))

# quito las semanas del confinamiento
datos <- datos[-c(113:117),]

plot(x=datos$X, y=datos$Y,ylab="Y",xlab="X")

modelo.lm <- lm(Y~X, data=datos)

lines(fitted.values(modelo.lm), col="red")

# huelga 14/03/2022
fit.seg <- segmented(modelo.lm, seg.Z = ~X, psi=which(datos$domingo=="13/03/2022"))
# summary(fit.seg)
# summary(modelo.lm)

lines(fitted.values(fit.seg), col="blue")

datos$domingo[
  fit.seg[["psi"]][,"Est."]
]#"06/03/2022"

# Davison and Hinkley (1997)
modelo.lm<-update(modelo.lm,.~.-X)
fit.seg1<-update(fit.seg)
lines(fitted.values(fit.seg1), col="darkgreen")

datos$domingo[
  fit.seg1[["psi"]][,"Est."]
]#"07/11/2021"



