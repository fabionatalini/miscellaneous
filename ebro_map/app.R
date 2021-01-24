library(shiny)
library(rgdal)

my_spdf <- readOGR(
    dsn <- "C:/Users/fabnatal/Documents/TRABAJO EN LOCAL/ebro_map/ebro_map/shapefiles",
    layer <- "recintos_autonomicas_inspire_peninbal_etrs89",
    verbose=FALSE
)

n <- nrow(my_spdf@data)

set.seed(123)
my_spdf@data[,"VVOL"] <- sample(c(100:1000),n,replace=FALSE)
# View(my_spdf@data)
set.seed(123)
my_spdf@data[,"DP"] <- sample(c(10:80),n,replace=FALSE)

my_spdf@data[,"lat"] <- NA
my_spdf@data[,"lon"] <- NA
poligonos <- my_spdf@polygons
for(i in 1:length(poligonos)){
    coord <- poligonos[[i]]@labpt
    my_spdf@data[i,"lat"] <- coord[2]
    my_spdf@data[i,"lon"] <- coord[1]
}

######################################## ui ########################################
my_ui <- fluidPage(
    # Application title
    titlePanel("Ebro Food"),
    # Sidebar layout with input and output definitions 
    sidebarLayout(
        # Inputs
        sidebarPanel(
            span("Nielsen map", style="color:blue;font-weight:bold"),
            # p("Modelizacion del lucro de 50 empresas emergentes"),
            br(),br(),
            span("Elaborado por", style="color:brown;font-size:70%;font-style:italic"),
            img(src="logo.png")
        ),
        # Outputs
        mainPanel(
            tabsetPanel(type = "tabs",
                        tabPanel("VVOL", br(),br(), plotOutput("map_vvol",width="70%",height="400px")),
                        tabPanel("DP", br(),br(), plotOutput("map_dp",width="70%",height="400px"))
            )
        )
    )
)

######################################## server ########################################
my_server <- function(input, output) {
    
    output$map_vvol <- renderPlot({
        my_colors <- colorRampPalette(c("white","blue"))(n)
        clases <- cut(as.numeric(my_spdf@data[,"VVOL"]),n,labels=FALSE)
        my_colors <- my_colors[clases]
        par(mar=c(0,0,0,0))
        plot(my_spdf, col=my_colors)
        text(x=my_spdf@data$lon, y=my_spdf@data$lat, as.character(my_spdf@data[,"VVOL"]))
    })
    
    output$map_dp <- renderPlot({
        my_colors <- colorRampPalette(c("white","orange"))(n)
        clases <- cut(as.numeric(my_spdf@data[,"DP"]),n,labels=FALSE)
        my_colors <- my_colors[clases]
        par(mar=c(0,0,0,0))
        plot(my_spdf, col=my_colors)
        text(x=my_spdf@data$lon, y=my_spdf@data$lat, as.character(my_spdf@data[,"DP"]))
    })
    
}

######################################## run ########################################
shinyApp(ui = my_ui, server = my_server)