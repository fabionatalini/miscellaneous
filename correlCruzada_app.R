library(shiny)

######################################## ui ########################################
my_ui <- fluidPage(
  # Application title
  titlePanel("Correlación cruzada", windowTitle = "Correlación cruzada"),
  # Sidebar layout with input and output definitions 
  sidebarLayout(
    # Inputs
    sidebarPanel(
      fileInput("file_1","Upload your dataset")
    ),
    # Outputs
    mainPanel(
      uiOutput("start_button"),
      tableOutput("resultado"),
      uiOutput("get_the_result")
    )
  )
)

######################################## server ########################################
my_server <- function(input, output) {
  
  # function to read the input dataset and to generate the result
  mydata <- reactive({
      tb <- read.table(input$file_1$datapath,header=TRUE,sep=';')
      tb1 <- aggregate(tb[,1],by=list(tb[,2]),sum)
      return(tb1)
  })

  # Adding the start button
  output$start_button <- renderUI({
    # use req() to wait for user's inputs before executing the commands
    req(input$file_1)
    actionButton("start_button", "Start")
  })
  
  # show the result
  output$resultado <- renderTable({
    req(input$start_button)
    foo <- mydata()
    print(foo)
  })
  
  # Add downloadButton to download the result
  output$get_the_result <- renderUI({
    req(input$start_button)
    downloadButton("download_data", "Download the result")
  })
  
  # Handle the downloadButton
  output$download_data <- downloadHandler(
    # set the name of the exported file
    filename = function() {paste("resultado_",Sys.Date(),".csv",sep="")},
    # content of the exported file
    content = function(file) {
      foo <- mydata()
      write.csv(foo, file, row.names=FALSE, sep = ";")
    }
  )
}

######################################## run ########################################
shinyApp(ui = my_ui, server = my_server)
