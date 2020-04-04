calc_sunday <- function(x){
  x[,1] <- as.Date(x[,1],"%d/%m/%Y")
  semanales <- data.frame(matrix(nrow=0,ncol=2))
  names(semanales) <- c("fecha_domingo","valor")
  for(i in 1:nrow(x)){
    if(strftime(x[i,1],"%u")=="7"){
      if(i-6>=0){
        semanales <- rbind(semanales,data.frame("fecha_domingo"=x[i,1],"valor"=sum(x[(i-6):i,2])))
      }else{next}
    }else{next}
  }
  semanales$fecha_domingo <- format(semanales$fecha_domingo,"%d/%m/%Y")
  return(semanales)
}
