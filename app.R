#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


library(shiny)
library(plotly)
library(dplyr)
library(shinythemes)
library(shinyWidgets)
library(ggplot2)
library(leaflet)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  #theme = shinytheme("cyborg"),
  theme = shinytheme("slate"),
  
  setBackgroundImage(
    src = "https://previews.123rf.com/images/monsitj/monsitj1704/monsitj170400016/75476966-3d-rendering-futuristic-blue-circuit-board-background-illustration.jpg"
  ),
  # App title ----
  headerPanel("Sensor Data Visualization"),
  
  # Sidebar panel for inputs ----
  sidebarPanel(
    # Input: Selector for variable to plot against mpg ----
    img(src="FA1_sensor_location.png", height = 250, width = 400),
    selectInput("variable", label = h4("Choose a variable:"), 
                choices = c("temperature" = "temperature",
                  "pressure" = "pressure",
                  "humidity" = "humidity")),
    h4("Summary"),
    verbatimTextOutput("summary"),
    
    # Input: Numeric entry for number of obs to view ----
    numericInput(inputId = "obs",
                 label = h4("Choose number of observations:"),
                 value = 5),
    h4("View Data"),
    tableOutput("view")
    
  ),
  
  # Main panel for displaying outputs ----
  mainPanel(
    tabsetPanel(
      tabPanel("Plot", plotOutput("plot"), plotOutput("plot2")),
      tabPanel("Leaflet Graph", leafletOutput("map")),
      tabPanel("Plotly Graph", plotlyOutput("graph"), plotlyOutput("graph2"), plotlyOutput("graph3")),
      tabPanel("App Info", h5(tableOutput("text1"), "color:black")),
      tabPanel("Source", h5(tableOutput("text2"))),
      tabPanel("More on App", h5(tableOutput("text3")))
    )
    
    
  )
)

#Change file path here
mydata <- read.csv(file="C:/Users/veena/Documents/R/shiny/sofia-air-quality-dataset/2017-07_bme280sof.csv", header=TRUE, sep=",")
setwd("C:/Users/veena/Documents/R/shiny/air_quality_shiny/www")
# Define server logic required to draw a histogram
server <- function(input, output) {
  
  # Return the requested dataset ----
  datasetInput <- reactive({
    switch(input$variable,
           "temperature" = mydata$temperature,
           "pressure" = mydata$pressure,
           "humidity" = mydata$humidity)
  })
  
  
  # Generate a summary of the dataset ----
  output$summary <- renderPrint({
    data <-datasetInput()
    summary(
      data)
  })
  
  # Show the first "n" observations ----
  output$view <- renderTable({
    data <-datasetInput()
    head(data, n = input$obs)
  })
  
  inputVariable <- reactive({
    switch(input$variable,
           "temperature" = "temperature",
           "pressure" = "pressure" ,
           "humidity" = "humidity")
  })
  # renderPlotly() also understands ggplot2 objects!
  output$plot <- renderPlot({
    data <-datasetInput()
    hist(data,col = "#75AADB", border = "red",
         xlab = inputVariable(),
         main = "Histogram")

    
})
  
  output$plot2 <- renderPlot(
    #ggplot(mydata, mapping = aes(x = mydata$timestamp, y = data))
    hist(data,col = "#75AADB", border = "red",
         xlab = inputVariable(),
         main = "Histogram")
    
  )
  
  output$text1 <- renderText({
    "A proven air quality monitoring solution for home enthusiasts and air quality professionals alike.
    In the broadest definition, a sensor is a device, module, machine, or subsystem whose purpose is to 
    detect events or changes in its environment and send the information to other electronics,
    frequently a computer processor. A sensor is always used with other electronics. 
    Air pollution sensors are devices that monitor the presence of air pollution in the surrounding area. 
    They can be used for both indoor and outdoor environments. These sensors can be built at home, or bought 
    from certain manufactures. Although there are various types of air pollution sensors, and some are specialized 
    in certain aspects, the majority focuses on five components: ozone, particulate matter, carbon monoxide, sulfur dioxide,
    and nitrous oxide. The sensors were very expensive in the past, but with technological advancements these sensors are becoming more 
    affordable and more widespread throughout the population. These sensors can help serve many purposes and help bring attention to environmental 
    issues beyond the scope of the human eye.

    The EPA maintains a repository of air quality data through the Air Quality System (AQS), where it stores data from over 10,000 monitors in the 
    United States.[1]"
  })
  
  output$text2 <- renderText({
    paste("Source : https://www.kaggle.com/hmavrodiev/sofia-air-quality-dataset ")
  })
  
  output$text3 <- renderText({
    " The application displays the outdoor sensor data. Air pollution sensors are devices that monitor the 
    presence of air pollution in the surrounding area. They can be used for both indoor and outdoor 
    environments. These sensors can be built at home, or bought from certain manufactures. 
A sensor is a device that detects and responds to some type of input from the physical environment. 
    The specific input could be light, heat, motion, moisture, pressure, or any one of a great number 
    of other environmental phenomena. The output is generally a signal that is converted to human-readable 
    display at the sensor location or transmitted electronically over a network for reading or further processing.  
    Here are a few examples of the many different types of sensors: In a mercury-based glass thermometer, the input is temperature. 
    The liquid contained expands and contracts in response, causing the level to be higher or lower on the marked 
    gauge, which is human-readable. "
  })
  
  output$map <- renderLeaflet({
    # reactive expression code required here to connect with ui selection?
    
    df = data.frame(Lat = head(mydata$lat,200), Long = head(mydata$lon,200))
    leaflet(df) %>% 
      addTiles() %>% 
      addCircles()
  })
  
  output$graph <- renderPlotly({
    f <- list(
      family = "Courier New, monospace",
      size = 20,
      color = "purple"
    )
    x <- list(
      title = "Timestamp: data every second",
      titlefont = f
    )
    y <- list(
      title = "Air Temperature",
      titlefont = f
    )
    plot_ly(x = head(mydata$timestamp, 10000), y1 = head(mydata$temperature,10000), color = I("black"), type = 'scatter',  mode = 'lines') %>%
      layout(xaxis =x, yaxis =y)
        
  })
  
  output$graph2 <- renderPlotly({
    f <- list(
      family = "Courier New, monospace",
      size = 20,
      color = "purple"
    )
    x <- list(
      title = "Air Pressure",
      titlefont = f
    )
    y <- list(
      title = "Air Temperature",
      titlefont = f
    )
    plot_ly(x = head(mydata$pressure, 100), y1 = head(mydata$temperature,100), color = I("red"), type = 'scatter',  mode = 'lines')%>%
      layout(xaxis =x, yaxis =y)
  })
  
  output$graph3 <- renderPlotly({
    f <- list(
      family = "Courier New, monospace",
      size = 20,
      color = "purple"
    )
    x <- list(
      title = "Air Humidity",
      titlefont = f
    )
    y <- list(
      title = "Air Temperature",
      titlefont = f
    )
    plot_ly(x = head(mydata$humidity, 100), y1 = head(mydata$temperature,100),color = I("green"), type = 'scatter',  mode = 'lines')%>%
      layout(xaxis =x, yaxis =y)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
