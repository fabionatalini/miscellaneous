########################## User input arguments #################################
mydata <- read.delim(file.path(mypath,mydataset),header=TRUE,stringsAsFactors=FALSE)
mychoices <- names(mydata)

########################## Define the UI for the application #################################
ui <- fluidPage(
  
  # Application title
  titlePanel("Hi there! Welcome to dataViz!"),
  
  # Sidebar layout with input and output definitions 
  sidebarLayout(
    
    # Inputs
    sidebarPanel(
      # Select variable on y-axis
      selectInput(inputId = "y1",
                  label = "Choose the variable on the left y-axis:",
                  choices = mychoices,
                  selected = mychoices[1]),
      # Select variable on y-axis
      selectInput(inputId = "y2",
                  label = "Choose the variable on the right y-axis:",
                  choices = mychoices,
                  selected = mychoices[1]),
      # Select variable to set the x-axis
      selectInput(inputId = "x",
                  label = "Choose the variable on the x-axis:",
                  choices = mychoices,
                  selected = mychoices[1])
    ),
    
    # Outputs
    mainPanel(
      plotOutput(outputId = "mi_grafico")
    )
  )
)

########################## Define the server function #################################
server <- function(input, output) {
  # Draw the plot
  output$mi_grafico <- renderPlot({
    #set the plot parameters
    par(mar=c(4,6,3,4))
    #plot the first time series
    plot(mydata[,input$y1], type='l',col='red',xlab="",xaxt="n",ylim=c(0,max(mydata[,input$y1])+1),ylab=input$y1)
    axis(1, at=1:length(mydata[,input$x]), labels=mydata[,input$x][1:length(mydata[,input$x])], las=2)
    #add data to the plot
    par(new=TRUE)
    #add the second time series
    plot(mydata[,input$y2],type='l',col="blue",yaxt='n',xaxt='n',ylab='',xlab='',ylim=c(0,max(mydata[,input$y2])+1))
    #add an y axis to the right
    axis(4)
    #add text to the new y axis
    mtext(input$y2,side=4,line = 2.5)
    #add a legend to the graph
    legend("topleft",col=c("red","blue"),lty=1, legend=c(input$y1,input$y2),ncol=2,bty="n")
  })
}

########################## Run the application  #################################
shinyApp(ui = ui, server = server)
