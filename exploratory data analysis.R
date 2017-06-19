# ///////////////////
# LIBRARIES
library(httr)
library(magrittr)
library(rvest)
library(jsonlite)
# //////////////////
clientID = ""
secret = ""

response = POST(
  'https://accounts.spotify.com/api/token',
  accept_json(),
  authenticate(clientID, secret),
  body = list(grant_type = 'client_credentials'),
  encode = 'form',
  verbose()
)

token = content(response)$access_token

authorization.header = paste0("Bearer ", token)
#GET(url = paste("https://api.spotify.com/v1/tracks/", ":ID", sep = ""),
#           config = add_headers(authorization = authorization.header))
# //////////////////
# WEB SCRAPING


daily.top.songs = read_html("https://spotifycharts.com/regional/global/daily/latest") %>%
  html_nodes("#content > div > div > div > span > table > tbody > tr > td.chart-table-image > a")

id.start = regexpr("/track/", daily.top.songs) # seems to always be 7
id.end = regexpr('" target="', daily.top.songs) # seems to always be 63

top.song.ids = substr(daily.top.songs, id.start+7, id.end-1)
# //////////////////
# API requests

# Get track
tracks = lapply(1:200, function(n) {
  GET(url = paste("https://api.spotify.com/v1/tracks/", top.song.ids[n], sep = ""),
                        config = add_headers(authorization = authorization.header))
})

tracks.content = sapply(1:200, function(n) {
  content(tracks[[n]])
})

tracks.content = t(tracks.content)
tracks.names = sapply(1:200, function(n) {
  tracks.content[[n]]$name
})

tracks.df = cbind(rating = 1:200, name = tracks.names)
tracks.df = tracks.df %>% as.data.frame

# Audio Features
features = lapply(1:200, function(n) {
  GET(url = paste0("https://api.spotify.com/v1/audio-features/", top.song.ids[n]),
               config = add_headers(authorization = authorization.header))
})

features.content = sapply(1:200, function(n) {
  content(features[[n]])
})

features.content = t(features.content)

features.df = cbind(rating = 1:200, danceability = features.content[,1], 
                    energy = features.content[,2], key = features.content[,3], 
                    loudness = features.content[,4], mode = features.content[,5],
                    speechiness = features.content[,6], acousticness = features.content[,7],
                    instrumentalness = features.content[,8], liveness = features.content[,9],
                    valence = features.content[,9], tempo = features.content[,10], 
                    duration_ms = features.content[,17], time_signature = features.content[,18])

features.df = features.df %>% as.data.frame

for (i in 1:ncol(features.df)) {
  features.df[,i] = unlist(features.df[,i])
}
# //////////////////
# SUMMARY STATS
feature.means = sapply(2:14, function(n) {
  mean(features.df[,n])
})
feature.sds = sapply(2:14, function(n) {
  sd(features.df[,n])
})
feature.maxes = sapply(2:14, function(n) {
  max(features.df[,n])
})
feature.mins = sapply(2:14, function(n) {
  min(features.df[,n])
})
feature.medians = sapply(2:14, function(n) {
  median(features.df[,n])
})

feature.summaries = cbind(feature = names(features.df)[-1],
                          mean = feature.means,
                          median = feature.medians,
                          standard.deviation = feature.sds,
                          min = feature.mins,
                          max = feature.maxes,
                          range = feature.maxes-feature.mins,
                          range.over.sd = (feature.maxes-feature.mins)/feature.sds)


# Audio Analysis
#analyses = lapply(1:200, function(n) {
#  GET(url = paste0("https://api.spotify.com/v1/audio-analysis/", top.song.ids[n]),
#           config = add_headers(authorization = authorization.header))
#})
