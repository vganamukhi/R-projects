library(shiny)

ui<- fluidPage(
  radioButtons("radio", h3("Radio buttons"), 
               choices = list("choice 1"=1, "Choice 2"=2, 
                              "Choice 3"= 3), selected = 1)
  
)

server <-function(input, output){
  
}

shinyApp(ui=ui, server = server)