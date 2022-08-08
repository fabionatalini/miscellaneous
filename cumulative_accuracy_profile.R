cap_lift <- function(predictions,quantiles){
  #========================================================#
  # predictions is a dataframe with two columns:
  # the first column is the true response (binary numeric with unique values 0 and 1, where 1 is the positive response),
  # the second column contains the probabilistic predictions;
  # quantiles is the number of quantiles to calculate the results.
  #========================================================#
  # ordenar las predicciones
  set.seed(123)
  predictions$aleatory<-sample(1:nrow(predictions), nrow(predictions), replace=FALSE)
  predictions<-predictions[order(predictions[,2], predictions$aleatory, decreasing = TRUE),]
  # distribucion en cuantiles
  predictions$quantile<-as.numeric(cut(1:nrow(predictions),quantiles,labels=FALSE))
  # % de respuestas positivas capturadas en cada cuantil
  Results <- aggregate(predictions[,1], by = list(predictions$quantile),  FUN = sum)
  Results$sums_id <- aggregate(1:nrow(predictions), by = list(predictions$quantile),  FUN = length)[,"x"]
  Results$actual_accum <- cumsum(Results$x)
  Results$sums_id_accum <- cumsum(Results$sums_id)
  names(Results)<-c("quantile","actual","sums_id","actual_accum","sums_id_accum")
  Results$captured_target<-Results$actual/sum(Results$actual)
  Results$captured_target_accum<-cumsum(Results$captured_target)
  # Lift
  average_rate <- sum(Results$actual) / nrow(Results)
  Results$lift <- Results$actual / average_rate
  lift_acum <- c()
  for (r in 1:nrow(Results)) {
    lift_acum_r <- Results$actual_accum[r] / (average_rate*r)
    lift_acum <- c(lift_acum, lift_acum_r)
  }
  Results$lift_accum <- lift_acum
  return(Results)
}
