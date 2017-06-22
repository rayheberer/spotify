library(shiny)

ui = fluidPage(
  
  sidebarLayout(
    
    sidebarPanel(
      dateInput(inputId = "date",
                label = "Date",
                value = "2017-06-20",
                min = "2016-05-17",
                max = "2017-06-20"),
      sliderInput(inputId = "rank",
                  label = "Top Chart Ranks Included",
                  value = c(1,200),
                  min = 1,
                  max = 200),
      selectInput(inputId = "feature",
                  label = "Feature",
                  choices = c("Danceability", "Energy", "Valence"))
      
    ),
    
    mainPanel(
    )
  )
  
)

server = function(input, output) {}

shinyApp(ui = ui, server = server)