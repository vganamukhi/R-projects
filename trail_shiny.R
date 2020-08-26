library(shiny)

ui<-fluidPage(
  titlePanel("Shiny app building"),
  sidebarLayout(position = "right", sidebarPanel("sidebar panel"), mainPanel("main_panel"))
  
)

server<-function(input, output){
  
}

shinyApp(ui=ui, server = server)