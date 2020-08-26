library(shiny)

ui<-fluidPage(
  titlePanel("My Shiny App"),
  sidebarLayout(sidebarPanel(
    h1("Installation"),
    h2("Shiny is available on CRAN"),
    h6("Console:", alighn = "left"),
    h6("install.packages (Shiny)"),
    p(),
    img(src="rstudio.png", height = 100, width = 200),
    p("Shiny is product of ", span("RStudio", style = "color:blue"))
    
  ), mainPanel(
    
    h1("Introducing Shiny", alighn = "right"),
    h4("Shiny is new package from RSTudio", alighn = "right"),
    p("For introduction and live examples visit", span("Shiny homepage", style = "color:blue")),
    p(),
    p(),
    h1("Features", alighn = "right"),
    p("-Build useful web applications with only few lines of code --no JavaScript required")
    ))
  
)

server<-function(input, output){
  
}

shinyApp(ui=ui, server = server)