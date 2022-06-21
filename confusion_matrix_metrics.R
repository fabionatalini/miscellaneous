confusion_matrix_metrics <- function(predi,real){
  #=======================================================#
  # predi and real are two vectors containing respectively:
  # the binary predictions and the binary actual response
  #=======================================================#
  # confusion matrix; the actual values are in columns, the predicted values are in rows
  conf_matr <- table("predicted"=as.character(predi), "actual"=as.character(real))
  # Overall accuracy
  Accuracy <- (conf_matr[1,1] + conf_matr[2,2]) / sum(conf_matr)
  # Sensitivity TP/(TP+FN)
  Sensitivity <- conf_matr[2,2] / (conf_matr[2,2] + conf_matr[1,2])
  # Specificity TN(TN+FP)
  Specificity <- conf_matr[1,1] / (conf_matr[1,1] + conf_matr[2,1])
  # Precision TP/(TP+FP)
  Precision <- conf_matr[2,2] / (conf_matr[2,2] + conf_matr[2,1])
  # F-score
  Fscore <- (2*Precision*Sensitivity) / (Precision+Sensitivity)
  # kappa statistic
  conf_matr_p <- conf_matr/sum(conf_matr)
  expectable <- sum(conf_matr_p[,1])*sum(conf_matr_p[1,]) + sum(conf_matr_p[,2])*sum(conf_matr_p[2,])
  kappa_score <- (Accuracy-expectable) / (1-expectable)
  
  return(c("Accuracy"=Accuracy,"Sensitivity"=Sensitivity,"Specificity"=Specificity,
           "Precision"=Precision,"Fscore"=Fscore,"kappa_score"=kappa_score))
}