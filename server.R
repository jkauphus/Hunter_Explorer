library(shiny)
library(shinythemes)
library(leaflet)
library(sp)
library(sf)
library(tidyverse)

# The Backbone for the application 

## First lets load up the Shapefiles We will be Using

source(boundaries.R)
source(info.R)

## Next lets Add all the Basemaps

basemaps <- c(
  `ESRI World Topo Map` = providers$Esri.WorldTopoMap,
  `ESRI World Imagery` = providers$Esri.WorldImagery,
  `ESRI Imagery with labels` = 'http://server.arcgisonline.com/ArcGIS/rest/services/Reference/World_Boundaries_and_Places/MapServer/tile/{z}/{y}/{x}',
  `NatGeo World Map` = providers$Esri.NatGeoWorldMap,
  `USA Topo Maps` = 'http://server.arcgisonline.com/ArcGIS/rest/services/USA_Topo_Maps/MapServer/tile/{z}/{y}/{x}',
  `Streets` = providers$Esri.WorldStreetMap,
  `Canvas` = providers$Esri.WorldGrayCanvas
)

# Connect to UI

source(ui.R)

# Create Function to Write up Coordinates

# Create Function to Map Boundaries and Javelina Data

### Forest Service Boundary

USFS <- function(x){
  legend$group <- c(legend$group, 'US Forest Service')
  leafletProxy('map') %>%
    clearGroup('US Forest Service') %>%
    addPolygons(data = x, 
                group = 'US Forest Service',
                layerId = 40,
                color="#2EEA2D", 
                fillColor = "#2EEA2D", 
                fillOpacity = 0.3,
                popup = glue(
                  "<h4><strong> US Forest Service Boundaries </strong></h4>",
                  '<strong>Forest Name<strong> ', "{x$ADMIN_FO_2}"
                ),
                opacity = 0.3) %>%
    addLayersControl(overlayGroups = legend$group, options = layersControlOptions(collapsed = FALSE))
}

remove_USFS<- function(){
  legend$group <- legend$group[!legend$group %in% 'US Forest Service']
  leafletProxy('map') %>%
    clearGroup('US Forest Service') %>%
    addLayersControl(overlayGroups = legend$group, options = layersControlOptions(collapsed = FALSE))
}

### AZGF_units Boundaries

azgf_units <- function(x){
  legend$group <- c(legend$group, 'AGFD Game Units')
  leafletProxy('map') %>%
    clearGroup('AGFD Game Units') %>%
    addPolygons(data = x, 
                group = 'AGFD Game Units',
                layerId = 40,
                color="#F9D482", 
                fillColor = "#F9D482", 
                fillOpacity = 0.3,
                popup = glue(
                  "<h4><strong> Arizona Game and Fish Game Units </strong></h4>",
                  '<strong>Game Region:<strong> ', "{x$GF_Region}", '</br>',
                  '<strong>Hunt:<strong> ', "{x$Hunt}" , '</br>',
                  '<strong>Acres:<strong> ', "{x$ACRES}"
                ),
                opacity = 0.5) %>%
    addLayersControl(overlayGroups = legend$group, options = layersControlOptions(collapsed = FALSE))
}

remove_agfd_units <- function(){
  legend$group <- legend$group[!legend$group %in% 'AGFD Game Units']
  leafletProxy('map') %>%
    clearGroup('AGFD Bird Plots') %>%
    addLayersControl(overlayGroups = legend$group, options = layersControlOptions(collapsed = FALSE))
}

### Hunt_2021 Boundary

hunt <- function(x){
  legend$group <- c(legend$group, 'Hunt 2021')
  leafletProxy('map') %>%
    clearGroup('Hunt 2021') %>%
    addPolygons(data = x, 
                group = 'Hunt 2021',
                layerId = 40,
                color="#F9D482", 
                fillColor = "#F9D482", 
                fillOpacity = 0.3,
                popup = glue(
                  "<h4><strong> Arizona Hunt 2021 </strong></h4>",
                  '<strong>Game Region:<strong> ', "{x$GF_Region}", '</br>',
                  '<strong>Hunt:<strong> ', "{x$Hunt}" , '</br>',
                  '<strong>Acres:<strong> ', "{x$ACRES}", '</br>',
                  '<strong>Forest Name<strong> ', "{x$ADMIN_FO_2}"
                ),
                opacity = 0.5) %>%
    addLayersControl(overlayGroups = legend$group, options = layersControlOptions(collapsed = FALSE))
}

remove_agfd_units <- function(){
  legend$group <- legend$group[!legend$group %in% 'Hunt 2021']
  leafletProxy('map') %>%
    clearGroup('Hunt 2021') %>%
    addLayersControl(overlayGroups = legend$group, options = layersControlOptions(collapsed = FALSE))
}
