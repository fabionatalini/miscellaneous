library(forecast)

dp_promo <- c(
  15,14,13,6,9,13,20,16,12,7,15,17,16,15,14,10,14,13,11,11,15,14,9,16,
  13,15,16,20,15,11,5,6,7,8,7,10,19,21,21,16,20,11,17,16,15,9,7,10,11,
  17,10,10,18,18,15,7,7,8,17,18,11,11,14,14,18,15,24,21,25,15,14,9,16,
  15,16,14,10,15,16,19,19,20,14,11,8,11,14,13,24,26,28,19,17,11,16,15,
  16,14,16,17,15,14,16,15,19,22,21,12,11,8,14,15,20,16,22,16,20,17,18,
  20,17,17,16,13,12,14,14,18,20,20
)

dp_promo <- ts(dp_promo,start=c(1,1),frequency = 52)

plot(decompose(dp_promo))

################ auto.arima ##################
model1=auto.arima(dp_promo)

summary(model1)

prediccion <- forecast(model1,26)

plot(prediccion)

################ autoregressive model ##################
acf(dp_promo)

model1 <- arima(dp_promo, order = c(1,0,0))

prediccion <- forecast(model1,26)

plot(prediccion)






