####Extracting GCP Metadata to obtain x,y, and z coordinates of the GCPs
##Alan Nare

# Load necessary libraries----
library(exifr)
library(sf)
library(terra)
##Importing image files for each AOI

AOI1 <- list.files("C:/Users/202200875/OneDrive - buan.ac.bw/Documents/Drone research/Data/GCPs/AOI1",full.names = TRUE) ## Area of interest 1 GCPs
AOI2 <- list.files("C:/Users/202200875/OneDrive - buan.ac.bw/Documents/Drone research/Data/GCPs/AOI2",full.names = TRUE) ## Area of interest 2 GCPs 
AOI3 <- list.files("C:/Users/202200875/OneDrive - buan.ac.bw/Documents/Drone research/Data/GCPs/AOI3",full.names = TRUE) ## Area of interest 3 GCPs


read_exif(AOI1)
read_exif(AOI2)
read_exif(AOI3)


### extracting metadata
gcps1 <- as.data.frame(read_exif(AOI1))
gcps2 <- as.data.frame(read_exif(AOI2))
gcps3 <- as.data.frame(read_exif(AOI3))

###extract x and y coordinates
x1 <- gcps1$GPSLongitude   ## x coordinates for AOI1 GCPs
y1 <- gcps1$GPSLatitude    ## y coordinates for AOI1 GCPs

x2 <- gcps2$GPSLongitude   ## x coordinates for AOI2 GCPs
y2 <- gcps2$GPSLatitude    ## y coordinates for AOI2 GCPs

x3 <- gcps3$GPSLongitude   ## x coordinates for AOI3 GCPs
y3 <- gcps3$GPSLatitude    ## y coordinates for AOI 1 GCPs

####extract altitude and subtract 1 meter offset to obtain ground elevation
alt1 <- gcps1$GPSAltitude-1 ## altitude for GCPs on AOI 1 minus 1 m offset between drone and ground
alt2 <- gcps2$GPSAltitude-1 ## altitude for GCPs on AOI 2 minus 1 m offset between drone and ground
alt3 <- gcps3$GPSAltitude-1 ## altitude for GCPs on AOI 3 minus 1 m offset between drone and ground

# Combine x, y, and ground altitude into a data frame for each AOI
GCP_AOI1 <- data.frame(x = x1, y = y1, ground_altitude = alt1)
GCP_AOI2 <- data.frame(x = x2, y = y2, ground_altitude = alt2)
GCP_AOI3 <- data.frame(x = x3, y = y3, ground_altitude = alt3)

# Save data frames for each AOI as CSV files
write.csv(GCP_AOI1, "AOI1_data.csv", row.names = FALSE)
write.csv(GCP_AOI2, "AOI2_data.csv", row.names = FALSE)
write.csv(GCP_AOI3, "AOI3_data.csv", row.names = FALSE)
st_crs(GCP_AOI1)
##Define projection
GCP_AOI1.32735 <- st_set_crs(GCP_AOI1, value = 32735)
