# definir la ruta para guardar el resultado
ruta_salida <- "C:/Users/fabnatal/Documents/"

# definir primera y ultima fecha domingo con formato AAAA-MM-DD
fecha_ini <- "2020-01-05"
fecha_fin <- "2022-01-02"


##########################################################################
fechas <- seq(as.Date(fecha_ini),as.Date(fecha_fin),7)

tabla_salida <- data.frame("fecha_domingo"=fechas)
tabla_salida[,paste0("mes_",1:12)] <- 0

for(mes_fecha in 1:12){
  # mes_fecha <- 4
  nombre_col <- paste0("mes_",mes_fecha)
  
  for(j in 1:length(fechas)){
    # j <- 1
    nueva_serie <- c()
    for(i in 0:6){
      nueva_serie <- c(nueva_serie, as.character(fechas[j]-i))
    }
    nueva_serie <- as.Date(nueva_serie)
    
    meses <- sapply(nueva_serie, month, simplify=TRUE)
    
    proporcion <- as.data.frame(prop.table(table(meses)))
    
    voila <- proporcion[proporcion$meses==mes_fecha,"Freq"]
    
    if(length(voila)==0){voila <- 0}
    
    tabla_salida[tabla_salida$fecha_domingo==as.Date(fechas[j]),nombre_col] <- voila
  }
}


write.table(tabla_salida,file.path(ruta_salida,"makeMonthSeries.txt"),quote=FALSE,sep="\t",row.names=FALSE)







