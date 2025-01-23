
library(shiny)
library(bslib)

ui <- page_sidebar( 
  title = "Hello Shiny!", 
  sidebar = sidebar( 
    sliderInput( inputId = "bins", 
                 label = "Number of bins:", 
                 min = 1, max = 50, value = 30 ) ,
    selectInput( inputId = "color", 
                 label = "Color of bins:", 
                 choices = c( "blue", 
                              "orange", 
                              "green", 
                              "red",
                              "#007bc2" ),
                 selected = "#007bc2"
    ) 
  ), 
  
  plotOutput(outputId = "distPlot"), 	textOutput("bins"),
  textOutput("color")
)

server <- function(input, output) { 
  
  output$distPlot <- renderPlot({ 
    
    x <- faithful$waiting 
    bins <- seq(min(x), max(x), 
                length.out = input$bins + 1)
    
    hist(x, breaks = bins, col = input$color, 
         border = "white", 
         xlab = "Waiting time to next eruption (in mins)", 
         main = "Histogram of waiting times") 
  })
  
  output$bins <- renderText({     
    paste("You have selected", input$bins, "bins")  
  }) 
  
}

shinyApp(ui = ui, server = server)
