library(plyr)

features.content.t = sapply(features.dti.200.t, function(day) {
  content(day)
})

features.content.b = sapply(features.dti.200.b, function(day) {
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
