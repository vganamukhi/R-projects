library(shiny)

ui<-fluidPage(
  titlePanel("Meme"),
  sidebarLayout(sidebarPanel(), mainPanel(img(src="venn.png", height = 200, width = 400)))
  
)

server<-function(input, output){
  
}

shinyApp(ui=ui, server = server)