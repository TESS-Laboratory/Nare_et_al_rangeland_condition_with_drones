library(PROJ)
library(tidyverse)

##### Load data
Biomass_data <- read_csv("C:/workspace/Nare_dev/data/Biomass_summary.csv")

head(Biomass_data)

??PROJ

###Creating data frame with 4 columns x, y, z, and time
cordinates_harvest <- Biomass_data %>% 
  select(latitude, longitude, altitude, datetime_stamp)  
cordinates_harvest  
### Transforming coordinates
??proj_trans
cordinates_harvest %>% 
  proj_trans(cbind(longitude, latitude), z_ = altitude, t_ = datetime_stamp, 
             "+proj=epsg:32734",  source = "EPSG:4326")

cordinates_harvest %>% 
  proj_trans(cbind(longitude, latitude), z_ = altitude, t_ = datetime_stamp, 
             "+proj=utm +zone=34 +south +datum=WGS84 +units=m +no_defs",  source = "EPSG:4326")

str(cordinates_harvest)

proj_trans(cbind(21.22468 , -24.07892 ), z_ = 1172.063, "+proj=utm +zone=34 +south +datum=WGS84 +units=m +no_defs", source = "EPSG:4326")
??cbind