library(tidyverse)
library(leaflet)

snow <- read_csv("snowpack-april.csv")

snow_map <- leaflet(data = snow) 

pal <- colorNumeric(
  palette = "RdBu", 
  domain = c(-110,110))

snow_map %>% 
  addCircleMarkers(
    lng = ~longitude,
    lat = ~latitude,
    radius = 5,
    stroke = TRUE,
    color = "black",
    weight = 1,
    fillColor = ~pal(trend),
    fillOpacity = 0.75,
    popup = paste0("<b>Latitude: </b>", format(round(snow$latitude, digits=2), nsmall=2), "<br>",
                   "<b>Longitude: </b>", format(round(snow$longitude, digits=2), nsmall=2), "<br>", 
                   "<b>Trend: </b>", format(round(snow$trend, digits=2), nsmal=2), "%")
  ) %>% 
  addProviderTiles(providers$Stamen.Terrain) %>%
  addLegend(
    "bottomright",
    pal = pal,
    values = ~trend,
    title = "Trend (%)",
    opacity = 1
  )