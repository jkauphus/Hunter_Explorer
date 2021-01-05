library(shiny)
library(shinythemes)
library(leaflet)
library(sp)
library(sf)
library(tidyverse)
library(glue)

# The Backbone for the application

shinyServer <- function(input, output) {

## First lets load up the Shapefiles We will be Using

source("boundaries.R")
source("info.R")

# Connect to UI

source("ui.R")

# Create Function to Write up Coordinates

# INITIALIZE MAP ----------------------------------------------------------

output$map <- renderLeaflet({
  
  leaflet() %>% 
    addProviderTiles(providers$Esri.WorldImagery) %>%
    addProviderTiles(providers$Esri.WorldTopoMap, group = "StreetView") %>% 
    setView(lng = -111.5, lat = 34, zoom = 6) %>%
    addMeasure(position = 'topright', primaryLengthUnit = 'meters', activeColor = '#0000ff', completedColor = '#000000') %>%
    addPolygons(data = FS, 
                group = 'US Forest Service',
                layerId = 40,
                color="#2EEA2D", 
                fillColor = "#2EEA2D", 
                fillOpacity = 0.3,
                popup = glue(
                  "<h4><strong> US Forest Service Boundaries </strong></h4>",
                  '<strong>Forest Name<strong> ', "{FS$ADMIN_FO_2}"
                ),
                opacity = 0.3) %>%
    addPolygons(data = AZGF_units, 
                group = 'AGFD Game Units',
                layerId = 40,
                color="#F9D482", 
                fillColor = "#F9D482", 
                fillOpacity = 0.3,
                popup = glue(
                  "<h4><strong> Arizona Game and Fish Game Units </strong></h4>",
                  '<strong>Game Region:<strong> ', "{AZGF_units$GF_REGION}", '</br>',
                  '<strong>Hunt:<strong> ', "{AZGF_units$HUNT}" , '</br>',
                  '<strong>Acres:<strong> ', "{AZGF_units$ACRES}"
                ),
                opacity = 0.5) %>%
    addPolygons(data = Hunt_2021,
                group = 'Hunt 2021',
                layerId = 40,
                color="#F99282", 
                fillColor = "#F99282", 
                fillOpacity = 0.3,
                popup = glue(
                  "<h4><strong> Arizona Hunt 2021 </strong></h4>",
                  '<strong>Game Region:<strong> ', "{Hunt_2021$GF_Region}", '</br>',
                  '<strong>Hunt:<strong> ', "{Hunt_2021$HUNT}" , '</br>',
                  '<strong>Acres:<strong> ', "{Hunt_2021$ACRES}", '</br>'
                ),
                opacity = 0.5) %>% 
        addMarkers(data = javelina, group = "Javelina Obs", icon = animalIcon, 
                   clusterOptions = markerClusterOptions(maxClusterRadius = 25),
                   popup = paste(sep = " ",
                                 "<strong>SCI_NAME:</strong> ",javelina$scientific_name, '<br/>',
                                 "<strong>COM_NAME:</strong> ", javelina$common_name, '<br/>',
                                 "<strong>DATE & TIME:</strong> ", javelina$datetime, '<br/>',
                                 "<img src='", javelina$image_url,"' width = '300px' height= '250px'>")) %>% 
    addLayersControl(overlayGroups = c("StreetView","US Forest Service", "AGFD Game Units", "Hunt 2021", "Javelina Obs"),
                     options = layersControlOptions(collapsed = F))
  })
}