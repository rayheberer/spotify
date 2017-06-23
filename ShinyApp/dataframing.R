features.dti.100.b.df = data.frame()


features.content = sapply(1:100, function(n) {
  content(features.dti.100.b[[n]])
})


#dataframe for one day for the first track
features.dti.100.b.df = data.frame(rank= features.rank, danceability = features.danceability2,
                                   energy = features.energy,
                                   key = features.key,    
                                   loudness = features.loudness,
                                   mode = features.mode,
                                   speechiness = features.speechiness,
                                   acousticness = features.acousticness,
                                   instrumentalness = features.instrumentalness,
                                   liveness = features.liveness,
                                   valence = features.valence,
                                   tempo = features.tempo,
                                   type = features.type,
                                   id = features.id,
                                   uri = features.uri,
                                   track_href = features.track_href1,
                                   analysis_url = features.analysis_url,
                                   duration_ms = features.duration_ms,
                                   time_signature = features.time_signature)


features.danceability = list()
features.danceability = sapply(1:100, function(n) {
  paste(features.danceability[n], features.content[[1]][[n]]$danceability, sep = ",")
})

features.danceability2 = c()
  features.danceability2 = sapply(1:100, function(n) {
    append(features.danceability2, features.content[[1]][[n]]$danceability)
  })
  
  features.energy = c()
  features.energy = sapply(1:100, function(n) {
    features.content[[1]][[n]]$energy
  })
  
  features.key = c()
  features.key = sapply(1:100, function(n) {
    append(features.key, features.content[[1]][[n]]$key)
  })
  features.loudness = c()
  features.loudness = sapply(1:100, function(n) {
    append(features.loudness, features.content[[1]][[n]]$loudness)
  })
  features.mode = c()
  features.mode = sapply(1:100, function(n) {
    append(features.mode, features.content[[1]][[n]]$mode)
  })
  features.speechiness = c()
  features.speechiness = sapply(1:100, function(n) {
    append(features.speechiness, features.content[[1]][[n]]$speechiness)
  })
  features.acousticness = c()
  features.acousticness = sapply(1:100, function(n) {
    append(features.acousticness, features.content[[1]][[n]]$acousticness)
  })
  features.instrumentalness = c()
  features.instrumentalness = sapply(1:100, function(n) {
    append(features.instrumentalness, features.content[[1]][[n]]$instrumentalness)
  })
  features.liveness = c()
  features.liveness = sapply(1:100, function(n) {
    append(features.liveness, features.content[[1]][[n]]$liveness)
  })
  features.valence = c()
  features.valence = sapply(1:100, function(n) {
    append(features.valence, features.content[[1]][[n]]$valence)
  })
  features.tempo = c()
  features.tempo = sapply(1:100, function(n) {
    append(features.tempo, features.content[[1]][[n]]$tempo)
  })
  features.type = c()
  features.type = sapply(1:100, function(n) {
    append(features.type, features.content[[1]][[n]]$type)
  })
  features.id = c()
  features.id = sapply(1:100, function(n) {
    append(features.id, features.content[[1]][[n]]$id)
  })
  features.uri = c()
  features.uri = sapply(1:100, function(n) {
    append(features.uri, features.content[[1]][[n]]$uri)
  })
  features.track_href1 = c()
  features.track_href1 = sapply(1:100, function(n) {
    append(features.track_href1, features.content[[1]][[n]]$track_href)
  })
  features.analysis_url = c()
  features.analysis_url = sapply(1:100, function(n) {
    append(features.analysis_url, features.content[[1]][[n]]$analysis_url)
  })
  features.duration_ms = c()
  features.duration_ms = sapply(1:100, function(n) {
    append(features.duration_ms, features.content[[1]][[n]]$duration_ms)
  })
  features.time_signature = c()
  features.time_signature = sapply(1:100, function(n) {
    append(features.time_signature, features.content[[1]][[n]]$time_signature)
})
  features.rank = c()
  features.rank = 1:100
    
  features.date = c(rep(as.Date("2017-06-20"), 200))
  