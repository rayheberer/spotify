library(tidyr)
library(magrittr)
library(ggplot2)

match_number = sapply(daily.top.ids.all, function(day) {
  match("4IIUaKqGMElZ3rGtuvYlNc", day)
})



top.curves = lapply(daily.top.ids.all[[1]], function(id) {
  vector = sapply(1:400, function(n) {
    paste(match(id, daily.top.ids.all[[n]]), 
          id, 
          as.Date("2017-06-20")-n+1,
          201 - match(id, daily.top.ids.all[[n]]))
  })
  
  df = data.frame(data = vector, stringsAsFactors = FALSE) %>% 
    separate(data, c("position", "id", "date", "popularity"), sep = " ")
})



ggplot(top.curves[[2]], aes(x = date, y = position)) + geom_point()
