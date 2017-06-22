

match_number = sapply(daily.viral.ids.all, function(day) {
  match("4IIUaKqGMElZ3rGtuvYlNc", day)
})


daily.viral.ids.all <-  c(daily.viral.ids.1_100, daily.viral.ids.101_200, daily.viral.ids.201_300, daily.viral.ids.301_400)

viral_curve() -> function(){
  for (i in 1:50){
  matched = c()
  sapply(daily.viral.ids.all[[i]], function(day) {
    match(id, day)
  })
  }
}