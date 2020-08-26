library(shiny)
library(maps)
library(mapproj)
source("C:/Users/veena/Documents/R/App-1/helpers.R")
counties <- readRDS("C:/Users/veena/Documents/R/App-1/data/counties.rds")

ui<- fluidPage(
  titlePanel("CensusVis"),
  sidebarLayout(sidebarPanel(helpText("Create demographic maps with information from 2101 US Census"),
                             selectInput("var", label  = "Choose a variable to display", 
                                         choices = list("Percent white"=1, "Percent Black"=2, 
                                                        "Percent Hispanic"= 3, "Percent Asian"=4), selected = "Percent white"),
                             sliderInput("range", label = "Range of Inputs",
                                         min = 0, max = 100, value = 100)),
                mainPanel(
                  textOutput("selected_var"),
                  textOutput("min_max")
                ))
  
  
)

server <-function(input, output){
  output$selected_var <- renderText({paste("You have selected this", input$var)})
  
  output$map <- renderPlot({
    
    data <- switch(input$var,
                   "Percent White" = counties$white,
                   "Percent Black" = counties$black,
                   "Percent Hispanic" = counties$hispanic,
                   "Percent Asian" = counties$asian)
    
    color <- switch(input$var,
                    "Percent White" = "darkgreen",
                    "Percent Black" = "black",
                    "Percent Hispanic" = "darkorange",
                    "Percent Asian" = "darkviolet")
    
    legend <- switch(input$var,
                     "Percent White" = "% White",
                     "Percent Black" = "% Black",
                     "Percent Hispanic" = "% Hispanic",
                     "Percent Asian" = "% Asian")
    
    percent_map(data, color, legend, input$range[1], input$range[2])
    
  })
  
  
}

shinyApp(ui=ui, server = server)