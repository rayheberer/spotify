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

dti.1_100.q1 = lapply(1:100, function(n) {
  paste0(daily.top.ids.1_100[[n]][1:50], collapse = ",")
})

dti.1_100.q2 = lapply(1:100, function(n) {
  paste0(daily.top.ids.1_100[[n]][51:100], collapse = ",")
})

dti.1_100.q3 = lapply(1:100, function(n) {
  paste0(daily.top.ids.1_100[[n]][101:150], collapse = ",")
})

dti.1_100.q4 = lapply(1:100, function(n) {
  paste0(daily.top.ids.1_100[[n]][151:200], collapse = ",")
})

dti.101_200.q1 = lapply(1:100, function(n) {
  paste0(daily.top.ids.101_200[[n]][1:50], collapse = ",")
})

dti.101_200.q2 = lapply(1:100, function(n) {
  paste0(daily.top.ids.101_200[[n]][51:100], collapse = ",")
})

dti.101_200.q3 = lapply(1:100, function(n) {
  paste0(daily.top.ids.101_200[[n]][101:150], collapse = ",")
})

dti.101_200.q4 = lapply(1:100, function(n) {
  paste0(daily.top.ids.101_200[[n]][151:200], collapse = ",")
})

dti.201_300.q1 = lapply(1:100, function(n) {
  paste0(daily.top.ids.201_300[[n]][1:50], collapse = ",")
})

dti.201_300.q2 = lapply(1:100, function(n) {
  paste0(daily.top.ids.201_300[[n]][51:100], collapse = ",")
})

dti.201_300.q3 = lapply(1:100, function(n) {
  paste0(daily.top.ids.201_300[[n]][101:150], collapse = ",")
})

dti.201_300.q4 = lapply(1:100, function(n) {
  paste0(daily.top.ids.201_300[[n]][151:200], collapse = ",")
})

dti.301_400.q1 = lapply(1:100, function(n) {
  paste0(daily.top.ids.301_400[[n]][1:50], collapse = ",")
})

dti.301_400.q2 = lapply(1:100, function(n) {
  paste0(daily.top.ids.301_400[[n]][51:100], collapse = ",")
})

dti.301_400.q3 = lapply(1:100, function(n) {
  paste0(daily.top.ids.301_400[[n]][101:150], collapse = ",")
})

dti.301_400.q4 = lapply(1:100, function(n) {
  paste0(daily.top.ids.1_100[[n]][151:200], collapse = ",")
})


features.dti.100.b = lapply(dti.1_100.bottom, function(ids) {
  GET(url = paste0("https://api.spotify.com/v1/audio-features/?ids=", ids),
      config = add_headers(authorization = authorization.header))
})

tracks.dti.300.q2 = lapply(dti.201_300.q2, function(ids) {
  GET(url = paste0("https://api.spotify.com/v1/tracks/?ids=", ids),
      config = add_headers(authorization = authorization.header))
})
