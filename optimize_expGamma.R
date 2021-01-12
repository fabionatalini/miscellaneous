setwd("C:/Users/fabnatal/Documents/myRcodes")

# a table with three columns "fecha", "GRP", "VVOL"
datos <- read.delim("grp_VVOL.txt",header = T,stringsAsFactors = F)

tr.expo.gamma.correl <- function(expon,alpha,beta){
  y <- 1-exp(-datos[,2]/expon)
  pesos <- pgamma(1:100,shape=alpha, scale=beta)
  pesos <- c(pesos[1],diff(pesos,1))
  suma <- pesos[1:20]/sum(pesos[1:20])
  res <- rep(0,length(y))
  for(i in 1:length(y)){
    for(j in 1:20){
      if((i)>=j){
        res[i]=res[i]+y[i-j+1]*suma[j]
      }
    }
  }
  cor(res, datos[,3])
}


iter_exp <- seq(80, 200, by=10)
iter_alpha <- seq(0.1, 3, by=0.1)
iter_beta <- seq(0.1, 3, by=0.1)

opt_result <- data.frame()
for(e in iter_exp){
  for(a in iter_alpha){
    opt <- optimize(tr.expo.gamma.correl, interval=iter_beta, expon=e, alpha=a, maximum=TRUE)
    dt <- data.frame("expo"=e,"alpha"=a,"beta"=opt$maximum,"objective"=opt$objective)
    opt_result <- rbind(opt_result, dt)
  }
}

