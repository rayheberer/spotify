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
track = GET(url = paste("https://api.spotify.com/v1/tracks/", top.song.ids[1], sep = ""),
                        config = add_headers(authorization = authorization.header))

# Audio Analysis
analysis = GET(url = paste0("https://api.spotify.com/v1/audio-analysis/", top.song.ids[1]),
           config = add_headers(authorization = authorization.header))

# Audio Features
features = GET(url = paste0("https://api.spotify.com/v1/audio-features/", top.song.ids[1]),
               config = add_headers(authorization = authorization.header))
