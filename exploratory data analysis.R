# ///////////////////
# libraries
library(httr)

# //////////////////


spotify.key = "e94b7f19fe754828bc335fd2fc360bd5"
spotify.secret = "41ee9eea78224541b425522312e60b26"

spotify.endpoint = oauth_endpoint(NULL, 
                                  "https://accounts.spotify.com/authorize",
                                  "hyyps://acounts.spotify.com/api/token")

spotify.app = oauth_app("spotify", spotify.key, spotify.secret)
