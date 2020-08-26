library(shiny)

ui<- fluidPage(
  dateRangeInput("dates", h3("Date range"))
)

server <-function(input, output){
  
}

shinyApp(ui=ui, server = server)