#Proposed workflow for lidR----
######Packages----
install.packages("lidR")
library (lidR)
library (rgl)
library(mapview)
####Import point cloud data for AOIs----
aoi1 <- readLAS("C:/Users/202200875/OneDrive - buan.ac.bw/Documents/Drone research/Data/Metashape Analysis/AOI1 RGB metashape analysis/AOI1_pointcloud.laz")
aoi2 <- readLAS("C:/Users/202200875/OneDrive - buan.ac.bw/Documents/Drone research/Data/Metashape Analysis/AOI2 RGB metashape analysis/AOI2_pointcloud.laz")
aoi3 <- readLAS("C:/Users/202200875/OneDrive - buan.ac.bw/Documents/Drone research/Data/Metashape Analysis/AOI3 RGB metashape analysis/AOI3_pointcloud.laz", select = "xyzc")  # load XYZc only

###Checking the data
print(aoi1) ### Shows point cloud metadata
las_check(aoi3) # note high number of duplicate points in current file
plot(aoi3)  # Plots the point cloud

################################################
####         WORKFLOW                          #
################################################


####Step 1- Classification of ground points----
##From literature, there are 2 algorithms, 
########### a) Progressive morphological filter (PMF)- widely used
########### b) Cloth simulation filter- suitable for complex terrain

??LASGROUND
las3 = filter_poi(aoi3, Classification %in% c(LASGROUND))
plot(las3)

####Step 2- Derivation of a Digital Terrain Model (DTM)----
## Interpolated ground surface-- idw
### User defined spatial resolution??????


####Step 3- Height above ground----




#### Step 4- Derivation of CHM----
#Highest non-ground returns
##Check Glenn's paper

