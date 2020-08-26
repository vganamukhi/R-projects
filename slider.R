library(shiny)

ui<- fluidPage(
  sliderInput("slider1", h3("sliders"),
              min = 0, max = 100, value = 50),
  sliderInput("slider2", h3("sliders"),
              min = 0, max = 100, value = 50)
  
)

server <-function(input, output){
  
}

shinyApp(ui=ui, server = server)