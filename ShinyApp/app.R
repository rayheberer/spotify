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
  
  HTML('<h2 style = "text-align: center;">Top 200 Spotify Tracks: Audio Features Explorer</h2>'),
  HTML('<h5 style = "text-align: center;">March 13 - June 20, 2017</h4>'),
  hr(),
  
  sidebarLayout(
    
    sidebarPanel(
      dateInput(inputId = "date",
                label = "Date (functionality in development)",
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
  ),
  
  fluidRow(
    column(width = 2),
    column(width = 8,
           textOutput(outputId = "description")
    ),
    column(width = 2)
  ),
  
  hr()
  
)

server = function(input, output, session) {
  
  #date = input$date
  #index = as.numeric(as.Date("2017-06-20") - date)
  
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
      if (input$rank[2] - input$rank[1] <= 100) {
        updateSliderInput(session, "bins", value = 20) 
      }
    }
  })
  
  output$histogram = renderPlot(
    ggplot(features.df[min(input$rank):max(input$rank),], aes(x = eval(parse(text = input$feature)))) + 
      geom_histogram(bins = input$bins, fill = "#428bca", alpha = 0.9, color = "black") +
      xlab(input$feature) + theme_minimal()
    )
  
  feat.description = ": describes how suitable a track is for dancing based on a combination of musical elements including tempo, rhythm stability, beat strength, and overall regularity. A value of 0.0 is least danceable and 1.0 is most danceable."
  
  observe({
    if (input$feature == "energy") {
      feat.description = ": a measure from 0.0 to 1.0 and represents a perceptual measure of intensity and activity. Typically, energetic tracks feel fast, loud, and noisy. For example, death metal has high energy, while a Bach prelude scores low on the scale. Perceptual features contributing to this attribute include dynamic range, perceived loudness, timbre, onset rate, and general entropy."
    } else if (input$feature == "key") {
      feat.description = ": the key the track is in. Integers map to pitches using standard Pitch Class notation. E.g. 0 = C, 1 = C???/D???, 2 = D, and so on."
    } else if (input$feature == "loudness") {
      feat.description = ": the overall loudness of a track in decibels (dB). Loudness values are averaged across the entire track and are useful for comparing relative loudness of tracks. Loudness is the quality of a sound that is the primary psychological correlate of physical strength (amplitude). Values typical range between -60 and 0 db."
    } else if (input$feature == "mode") {
      feat.description = ":  the modality (major or minor) of a track, the type of scale from which its melodic content is derived. Major is represented by 1 and minor is 0."
    } else if (input$feature == "speechiness") {
      feat.description = ": detects the presence of spoken words in a track. The more exclusively speech-like the recording (e.g. talk show, audio book, poetry), the closer to 1.0 the attribute value. Values above 0.66 describe tracks that are probably made entirely of spoken words. Values between 0.33 and 0.66 describe tracks that may contain both music and speech, either in sections or layered, including such cases as rap music. Values below 0.33 most likely represent music and other non-speech-like tracks."
    } else if (input$feature == "acousticness") {
      feat.description = ": a confidence measure from 0.0 to 1.0 of whether the track is acoustic. 1.0 represents high confidence the track is acoustic."
    } else if (input$feature == "instrumentalness") {
      feat.description = ': predicts whether a track contains no vocals. "Ooh" and "aah" sounds are treated as instrumental in this context. Rap or spoken word tracks are clearly "vocal". The closer the instrumentalness value is to 1.0, the greater likelihood the track contains no vocal content. Values above 0.5 are intended to represent instrumental tracks, but confidence is higher as the value approaches 1.0.'
    } else if (input$feature == "liveness") {
      feat.description = ": detects the presence of an audience in the recording. Higher liveness values represent an increased probability that the track was performed live. A value above 0.8 provides strong likelihood that the track is live."
    } else if (input$feature == "valence") {
      feat.description = ": a measure from 0.0 to 1.0 describing the musical positiveness conveyed by a track. Tracks with high valence sound more positive (e.g. happy, cheerful, euphoric), while tracks with low valence sound more negative (e.g. sad, depressed, angry)."
    } else if (input$feature == "tempo") {
      feat.description = ": the overall estimated tempo of a track in beats per minute (BPM). In musical terminology, tempo is the speed or pace of a given piece and derives directly from the average beat duration."
    } else if (input$feature == "duration_ms") {
      feat.description = ": the duration of the track in milliseconds."
    } else if (input$feature == "time_signature") {
      feat.description = ": an estimated overall time signature of a track. The time signature (meter) is a notational convention to specify how many beats are in each bar (or measure)."
    } 
    
    output$description = renderText({
      paste0(tools::toTitleCase(input$feature), feat.description)
    })
  })
  
}

shinyApp(ui = ui, server = server)