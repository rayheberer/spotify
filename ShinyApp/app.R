library(shiny)
library(httr)
library(ggplot2)

features.dti.100.b = readRDS("data/features.dti.100.b.rds")
features.dti.100.t = readRDS("data/features.dti.100.t.rds")
features.dti.200.b = readRDS("data/features.dti.200.b.rds")
features.dti.200.t = readRDS("data/features.dti.200.t.rds")
features.dti.300.b = readRDS("data/features.dti.300.b.rds")
features.dti.300.t = readRDS("data/features.dti.300.t.rds")
features.dti.400.b = readRDS("data/features.dti.400.b.rds")
features.dti.400.t = readRDS("data/features.dti.400.t.rds")


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
                  choices = c("danceability", "energy", "valence"))
      
    ),
    
    mainPanel(
      plotOutput(outputId = "mainplot")
    )
  )
  
)

server = function(input, output) {
  
  date = observe(input$date)
  #index = as.numeric(as.Date("2017-06-20") - date)
  
  features.content.t = sapply(features.dti.100.t, function(day) {
    content(day)
  })
  
  features.content.b = sapply(features.dti.100.b, function(day) {
    content(day)
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
  
  output$mainplot = renderPlot(
    ggplot(features.df, aes(x = eval(parse(text = input$feature)))) + geom_histogram() +
      xlab(input$feature)
    )
  
  #if (observe({input$feature}) == "Danceability") {
  #  output$mainplot = renderPlot(
  #    ggplot(features.df, aes(x = danceability)) + geom_histogram()
  #  )
  #}
  
  #if (observe({input$feature}) == "Energy") {
  #  output$mainplot = renderPlot(
  #    ggplot(features.df, aes(x = energy)) + geom_histogram()
  #  )
  #}
  
  #if (observe({input$feature}) == "Valence") {
  #  output$mainplot = renderPlot(
  #    ggplot(features.df, aes(x = valence)) + geom_histogram()
  #  )
  #}
  
}

shinyApp(ui = ui, server = server)