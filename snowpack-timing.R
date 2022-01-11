library(tidyverse)
library(leaflet)

snow_all <- read_csv("snowpack-timing.csv")
snow = filter(snow_all, state != "AK")

snow_map <- leaflet(data = snow) 

pal <- colorNumeric(
  palette = "RdBu", 
  domain = c(-42,42))

snow_map %>% 
  addCircleMarkers(
    lng = ~longitude,
    lat = ~latitude,
    radius = 5,
    stroke = TRUE,
    color = "black",
    weight = 1,
    fillColor = ~pal(timing),
    fillOpacity = 0.75,
    popup = paste0("<b>Latitude: </b>", format(round(snow$latitude, digits=2), nsmall=2), "<br>",
                   "<b>Longitude: </b>", format(round(snow$longitude, digits=2), nsmall=2), "<br>", 
                   "<b>Timing: </b>", format(round(snow$timing, digits=2), nsmal=2), " days")
  ) %>% 
  addProviderTiles(providers$Stamen.Terrain) %>%
  addLegend(
    "bottomright",
    pal = pal,
    values = ~timing,
    title = "Timing (Days)",
    opacity = 1
  )
