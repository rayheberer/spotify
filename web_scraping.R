library(magrittr)
library(rvest)

days = as.numeric(Sys.Date() - as.Date("2015-04-25"))

urls.top = sapply(1:days, function(n) {
    date = Sys.Date() - n
    paste0("https://spotifycharts.com/regional/global/daily/", as.character(date))
})

urls.viral = sapply(1:days, function(n) {
  date = Sys.Date() - n
  paste0("https://spotifycharts.com/viral/global/daily/", as.character(date))
})

daily.top.songs = lapply(urls.top[401:500], function(url) {
  read_html(url) %>%
  html_nodes("#content > div > div > div > span > table > tbody > tr > td.chart-table-image > a")
})

id.starts = lapply(daily.top.songs, function(day) {
  regexpr("/track/", day)
})

id.ends = lapply(daily.top.songs, function(day) {
  regexpr('" target="', day)
})

daily.top.ids.301_400 = lapply(1:100, function(n) {
  substr(daily.top.songs[[n]], id.starts[[n]]+7, id.ends[[n]]-1)
})
