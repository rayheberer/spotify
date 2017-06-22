library(tidyr)
library(magrittr)

match_number = sapply(daily.top.ids.all, function(day) {
  match("4IIUaKqGMElZ3rGtuvYlNc", day)
})



matches = lapply(daily.top.ids.all[[1]], function(id) {
  vector = sapply(daily.top.ids.all, function(day) {
    paste(match(id, day), id)
  })
  df = data.frame(data = df)
})


top.curves = lapply(1:400, function(n) {
  lapply(daily.top.ids.all[[n]], function(id) {
    sapply(daily.top.ids.all, function(day) {
      paste(match(id, day), id)
    })
  })
})

head(top.curves)
top.curves[[1]]
tail(top.curves[[1]])
top.curves[[1]][[1]][1]


my_vector = c("1 keyzz1", "2 keyzz1", "1 keyzz1", "5 keyzz1", "7 keyzz1")
#
my_df = data.frame(foo = my_vector)
#
separate(my_df, foo, c("position", "key"), sep = " ")
