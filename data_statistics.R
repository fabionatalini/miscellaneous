data_statistics <- function(x){
  # x is a numeric vector with or without NA and no NULL values
  
  # define a function to compute the sample mode
  moda <- function(y){
    a <- c(table(y,useNA="no"))
    b <- as.numeric(names(a)[which(a==max(a))])
    if(length(b)==1){return(b)}else{return(NaN)}
  }
  
  mu <- mean(x,na.rm=TRUE)
  sigma <- sd(x,na.rm=TRUE)
  md <- moda(x)
  mn <- median(x,na.rm=TRUE)
  
  return(c("max"=max(x,na.rm=TRUE),
     "min"=min(x,na.rm=TRUE),
     "mean"=mu,
     "median"=mn,
     "mode"=md,
     "1st_quartile"=setNames(quantile(x,probs=seq(0,1,0.25),na.rm=TRUE)[2],NULL),
     "3st_quartile"=setNames(quantile(x,probs=seq(0,1,0.25),na.rm=TRUE)[4],NULL),
     "percent_of_missing"=sum(is.na(x))/length(x),
     "percent_of_zeros"=sum(x==0,na.rm=TRUE)/length(x),
     "n_of_unique_values"=length(unique(na.omit(x))),
     "std_dev"=sigma,
     "coef_of_var"=sigma/mu,
     "skewness_mode"=if(!is.null(md)){(mu-md)/sigma}else{NaN},
     "skewness_median"=(3*(mu-mn))/sigma))
}

trial_data <- cbind(mtcars, "colWithNAs"=c(sample(nrow(mtcars)-5),rep(NA,5)))

apply(trial_data,MARGIN = 2,FUN = data_statistics)
