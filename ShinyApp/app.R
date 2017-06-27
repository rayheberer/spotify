library(shiny)
library(httr)
library(ggplot2)
library(plyr)

features.dti.100.b = readRDS("data/features.dti.100.b.rds")
features.dti.100.t = readRDS("data/features.dti.100.t.rds")
features.dti.200.b = readRDS("data/features.dti.200.b.rds")
features.dti.200.t = readRDS("data/features.dti.200.t.rds")
features.dti.300.b = readRDS("data/features.dti.300.b.rds")
features.dti.300.t = readRDS("data/features.dti.300.t.rds")
features.dti.400.b = readRDS("data/features.dti.400.b.rds")
features.dti.400.t = readRDS("data/features.dti.400.t.rds")

features.content.t = sapply(features.dti.100.t, function(day) {
  content(day)
})

features.content.b = sapply(features.dti.100.b, function(day) {
  content(day)
})



ui = fluidPage(
  
  sidebarLayout(
    
    sidebarPanel(
      dateInput(inputId = "date",
                label = "Date",
                value = "2017-06-20",
                min = "2017-03-13",
                max = "2017-06-20"),
      sliderInput(inputId = "rank",
                  label = "Top Chart Ranks Included",
                  value = c(1,200),
                  min = 1,
                  max = 200),
      selectInput(inputId = "feature",
                  label = "Feature",
                  choices = c("danceability", "energy", "key",
                              "loudness", "mode", "speechiness", 
                              "acousticness", "instrumentalness",
                              "liveness", "valence", "tempo", "duration_ms",
                              "time_signature")),
      sliderInput(inputId = "bins",
                  label = "Histogram Bins",
                  value = 30,
                  min = 1,
                  max = 50)
      
    ),
    
    mainPanel(
      plotOutput(outputId = "histogram")
      )
  )
  
)

server = function(input, output, session) {
  

  observe({
    date = input$date
    index = as.numeric(as.Date("2017-06-20") - date)
  })
  
  features.list.t = lapply(features.content.t[[1]], function(track) {
    data.frame(danceability = track$danceability,
               energy = track$energy,
               key = track$key,
               loudness = track$loudness,
               mode = track$mode,
               speechiness = track$speechiness,
               acousticness = track$acousticness,
               instrumentalness = track$instrumentalness,
               liveness = track$liveness,
               valence = track$valence,
               tempo = track$tempo,
               type = track$type,
               id = track$id,
               uri = track$uri,
               track_href = track$track_href,
               analysis_url = track$analysis_url,
               duration_ms = track$duration_ms,
               time_signature = track$time_signature)
  })
  
  features.list.b = lapply(features.content.b[[1]], function(track) {
    data.frame(danceability = track$danceability,
               energy = track$energy,
               key = track$key,
               loudness = track$loudness,
               mode = track$mode,
               speechiness = track$speechiness,
               acousticness = track$acousticness,
               instrumentalness = track$instrumentalness,
               liveness = track$liveness,
               valence = track$valence,
               tempo = track$tempo,
               type = track$type,
               id = track$id,
               uri = track$uri,
               track_href = track$track_href,
               analysis_url = track$analysis_url,
               duration_ms = track$duration_ms,
               time_signature = track$time_signature)
  })
  
  
  features.df.t = ldply(features.list.t)
  features.df.b = ldply(features.list.b)
  
  features.df = rbind(features.df.t, features.df.b)
  
  features.df$rank = 1:200
  features.df$popularity = 200:1
  
  
  
  observe({
    if (input$feature == "key") {
      updateSliderInput(session, "bins", value = 12, min = 1, max = 12)
    } else if (input$feature == "mode" | input$feature == "time_signature") {
      updateSliderInput(session, "bins", value = 2, min = 1, max = 2)
    } else {
      updateSliderInput(session, "bins", value = 30, min = 1, max = 50)
    }
  })
  
  output$histogram = renderPlot(
    ggplot(features.df[min(input$rank):max(input$rank),], aes(x = eval(parse(text = input$feature)))) + 
      geom_histogram(bins = input$bins, fill = "#428bca", alpha = 0.9, color = "black") +
      xlab(input$feature) + theme_minimal()
    )
  
}

shinyApp(ui = ui, server = server)