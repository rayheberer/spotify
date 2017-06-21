weekly.top.songs = read_html("https://spotifycharts.com/regional/global/weekly/latest") %>%
  html_nodes("#content > div > div > div > span > table > tbody > tr > td.chart-table-image > a")

id.start = regexpr("/track/", weekly.top.songs) # seems to always be 7
id.end = regexpr('" target="', weekly.top.songs) # seems to always be 63



urls = sapply(1:788, function(n) {
    date = Sys.Date() - n
    paste0("https://spotifycharts.com/regional/global/daily/", as.character(date))
    })
