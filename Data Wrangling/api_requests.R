library(httr)
library(magrittr)

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

# ==============================================================

features = lapply(1:200, function(n) {
  GET(url = paste0("https://api.spotify.com/v1/audio-features/", top.song.ids[n]),
      config = add_headers(authorization = authorization.header))
})

dti.1_100.top = lapply(1:100, function(n) {
  paste0(daily.top.ids.1_100[[n]][1:100], collapse = ",")
})

dti.1_100.bottom = lapply(1:100, function(n) {
  paste0(daily.top.ids.1_100[[n]][101:200], collapse = ",")
})

dti.101_200.top = lapply(1:100, function(n) {
  paste0(daily.top.ids.1_100[[n]][1:100], collapse = ",")
})

dti.101_200.bottom = lapply(1:100, function(n) {
  paste0(daily.top.ids.1_100[[n]][101:200], collapse = ",")
})

dti.201_300.top = lapply(1:100, function(n) {
  paste0(daily.top.ids.1_100[[n]][1:100], collapse = ",")
})

dti.201_300.bottom = lapply(1:100, function(n) {
  paste0(daily.top.ids.1_100[[n]][101:200], collapse = ",")
})

dti.301_400.top = lapply(1:100, function(n) {
  paste0(daily.top.ids.1_100[[n]][1:100], collapse = ",")
})

dti.301_400.bottom = lapply(1:100, function(n) {
  paste0(daily.top.ids.1_100[[n]][101:200], collapse = ",")
})


features.dti.300.t = lapply(dti.201_300.top, function(ids) {
  GET(url = paste0("https://api.spotify.com/v1/audio-features/?ids=", ids),
      config = add_headers(authorization = authorization.header))
})

GET(url = paste0("https://api.spotify.com/v1/audio-features/?ids=", "5CtI0qwDJkDQGwXD1H1cLb,72Q0FQQo32KJloivv5xge2"),
    config = add_headers(authorization = authorization.header))
