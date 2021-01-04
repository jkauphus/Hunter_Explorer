library(sp)
library(sf)
library(tidyverse)
library(rinat)

bounds <- c(32.4436, -114.763, 36.992, -109.0505)
javelina<- get_inat_obs(query = "Pecari tajacu", bounds = bounds, maxresults = 1000)

# Change to a SF
javelina<- st_as_sf(javelina, coords = c("longitude", "latitude"), crs = 4326)

