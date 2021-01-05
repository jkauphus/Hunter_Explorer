library(sp)
library(sf)
library(tidyverse)
library(rinat)

bounds <- c(32.4436, -114.763, 36.992, -109.0505)
javelina<- get_inat_obs(query = "Pecari tajacu", bounds = bounds, maxresults = 1000)

# Change to a SF
javelina<- st_as_sf(javelina, coords = c("longitude", "latitude"), crs = 4326)

# Marker Creation

animalIcon <- makeIcon(
  iconUrl = './data/Javelina-icon.png',
  iconWidth = 20, iconHeight = 25,
  iconAnchorX = 7.5, iconAnchorY = 25,
  popupAnchorX = -1, popupAnchorY = -15
)