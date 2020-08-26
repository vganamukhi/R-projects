library(shiny)

ui<- fluidPage(
  h3("Single checkbox"),
  checkboxGroupInput("checkGroup", h3("Checkbox  Group"),
                     choices = list("Choice 1"=1, 
                                    "Choice 1"=2,
                                    "Choice 1"=3),
                     selected = 1)
)

server <-function(input, output){
  
}

shinyApp(ui=ui, server = server)