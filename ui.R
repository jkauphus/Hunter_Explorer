library(shiny)
library(leaflet)

navbarPage("2021 Javelina Hunt", id="main",
           tabPanel("Map", leafletOutput("map", height=1000))
)
