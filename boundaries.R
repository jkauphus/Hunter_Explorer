library(sp)
library(sf)
library(tidyverse)

# Load Up The Shapefiles

AZGF_units<-read_sf("data/AZGFD_GameUnits.shp") 
FS<-read_sf("data/USFS_Boundaries.shp")
state_trust <- read_sf("data/AZ_State_Trust_Land_-_Surface_Parcels.shp")

# Correct the Projections for Leaflet
AZGF_units<-st_transform(AZGF_units, crs = 4326)
FS<-st_transform(FS, crs = 4326)
state_trust <-st_transform(state_trust, crs = 4326)
# Need to Join the Two Layers of the Area we want to hunt in

TwentyFourB<- AZGF_units %>% filter(GMUNAME == "24B")
Tonto<- FS %>%  filter(ADMIN_FO_2 == "Tonto National Forest")

Hunt_2021<- st_intersection(TwentyFourB, Tonto)


