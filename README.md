# Exploratory Spotify Analysis

This is an open-ended project seeking to gain insight into Spotify popularity and viral trends, as well as features of popular songs.

## Data Sources

Popularity information is scraped from [Spotify Charts](http://spotifycharts.com/) about the daily top 200 and viral 50 tracks.
The range of data being investigated will expand as the project matures.

The [Spotify Web API](https://developer.spotify.com/web-api/) is used to uncover more detailed information about the tracks.

## Data

Currently, API responses for the [Get Track](https://developer.spotify.com/web-api/get-track/) and [Get Audio Features](https://developer.spotify.com/web-api/get-audio-features/) endpoints are stored in the /Data/ subdirectory.

They are stored in lists of responses, using top charts data between 2016-05-15 and 2017-06-20, with the first element in a list being the most recent date, and each successive element being a day before that.

A more coherent data collection process will be developed soon.

## Shiny App

The /ShinyApp/ subdirectory contains a Shiny App meant to produce quick visualizations for the distribution of audio features in top tracks for any given day.

The current version of the app is published at https://rayheberer.shinyapps.io/spotify_top_tracks_feature_explorer/.
