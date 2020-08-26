library(shiny)

ui<- fluidPage(
  h3("Single checkbox"),
  checkboxInput("checkbox", "Choice A", value = TRUE)
)

server <-function(input, output){
  
}

shinyApp(ui=ui, server = server)