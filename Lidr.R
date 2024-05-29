#Proposed workflow for lidR----
######Packages----
library (lidR)
library (rgl)   ##a versatile and interactive 3D viewer with points coloured by Z coordinates
library(mapview)
library(sf)     ### for reading AOI boundary shapefile
library(RCSF)   ## For Cloth Simulation Filter ground classification

####Import point cloud data for AOIs---- 
#in the case of multispectral data, use readMSLAS
aoi1 <- readLAS("C:/Users/202200875/OneDrive - buan.ac.bw/Documents/Drone research/Data/Metashape Analysis/AOI1 RGB metashape analysis/AOI1_pointcloud_RGB.laz", select = "xyzrn")
aoi2 <- readLAS("C:/Users/202200875/OneDrive - buan.ac.bw/Documents/Drone research/Data/Metashape Analysis/AOI2 RGB metashape analysis/AOI2_pointcloud.laz", select = "xyzrn")
aoi3 <- readLAS("C:/Users/202200875/OneDrive - buan.ac.bw/Documents/Drone research/Data/Metashape Analysis/AOI3 RGB metashape analysis/AOI3_pointcloud.laz", select = "xyzrn")  # load XYZc only

################Extracting ROI#######----
polyaoi1 <- st_read("C:/Users/202200875/Downloads/aoi1boundary/AOI1_Boundary.shp")
las_clipped_aoi1 <- clip_roi(aoi1, polyaoi1)

###Checking the data----
plot(las_clipped_aoi1)
print(las_clipped_aoi1) ### Shows point cloud metadata
summary(las_clipped_aoi1) #### Detailed print out
las_check(las_clipped_aoi1) # note high number of duplicate points in current file.
## High duplicates may lead to problems like trees being detected twice, to invalid metrics, or to errors in DTM generation

##############Cleaning duplicates----
las1 <- filter_duplicates(aoi1)
las_check(las1)     ### Check if removing duplicates worked

##BASIC PLOTTING/3D rendering----
plot(las_clipped_aoi1, color = "RGB")  # Plots the point cloud
plot(las_clipped_aoi1, bg = "white", axis = TRUE, legend = TRUE)

####Step 1- Classification of ground points----
########### b) Cloth simulation filter- suitable for complex terrain

################################################################################
#Cloth simulation filtering (CSF) uses the Zhang et al 2016 algorithm and      #
#consists of simulating a piece of cloth draped over a reversed point cloud.   #
#In this method the point cloud is turned upside down and then a cloth is      #
#dropped on the inverted surface. Ground points are determined by analyzing the# 
#interactions between the nodes of the cloth and the inverted surface. The 
#cloth simulation itself is based on a grid that consists of particles with    #
#mass and interconnections that together determine the three-dimensional       #
#position and shape of the cloth.                                              #
################################################################################
# Classify ground points using the CSF algorithm----
# Perform ground classification using CSF with custom parameters
# Define the parameters for CSF
csf_params <- csf(class_threshold = 0.5, cloth_resolution = 0.1, rigidness = 1, 
                  time_step = 0.65, iterations = 500)

# Perform ground classification using CSF
gnd_class_AOI1 <- classify_ground(las_clipped_aoi1, csf_params)
# Visualize the classified point cloud
plot(gnd_class_AOI1, color = "Classification")

####Step 2- Derivation of a Digital Terrain Model (DTM)----
??rasterize_terrain
dtm_aoi1 <- rasterize_terrain(gnd_class_AOI1, res = 0.01, algorithm = tin())
plot_dtm3d(dtm_aoi1, bg = "white")
plot(dtm_aoi1, col = gray(1:50/50))


####Step 3- Height above ground----
# Generate Canopy Height Model (CHM)
nlas <- las_clipped_aoi1 - dtm_aoi1
plot(nlas, size = 4, bg = "white")

#### Step 4- Derivation of CHM----
#Highest non-ground returns
##Check Glenn's paper


LASfile <- system.file("extdata", "Topography.laz", package="lidR")
las <- readLAS(LASfile, select = "xyzrn", filter = "-inside 273450 5274350 273550 5274450")

ws <- seq(3,12, 3)
th <- seq(0.1, 1.5, length.out = length(ws))

las <- classify_ground(las, pmf(ws, th))
plot(las, color = "Classification")

