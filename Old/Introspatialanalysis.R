# Intro to spatial analysis tutorial----
# Satellite data available from https://scihub.copernicus.eu/

# Alan Nare alandnare@gmail.com
#
##############################################################

# Set the working directory (example, replace with your own file path)
setwd("C:/workspace/Nare_dev/CC-spatial-master/CC-spatial-master")

# Load packages----

# If you haven't installed the packages before, use e.g.:
# install.packages("sp")

library(sp)
library(rgdal)
library(raster)
library(ggplot2)
library(viridis)
library(rasterVis)

### Loading data----
# Load data
tay <- raster('taycrop.tif')

tay

b1 <- raster('taycrop.tif', band=1)
b2 <- raster('taycrop.tif', band=2)
b3 <- raster('taycrop.tif', band=3)
b4 <- raster('taycrop.tif', band=4)
b5 <- raster('taycrop.tif', band=5)
b6 <- raster('taycrop.tif', band=6)
b7 <- raster('taycrop.tif', band=7)
b8 <- raster('taycrop.tif', band=8)
b9 <- raster('taycrop.tif', band=9)
b10 <- raster('taycrop.tif', band=10)
b11 <- raster('taycrop.tif', band=11)
b12 <- raster('taycrop.tif', band=12)

##Comparing bands

compareRaster(b2, b3)

####Checking the coordinate systems and extents of rasters


plot(b8)

image(b8)

plot(b8)
zoom(b8)    # run this line, then click twice on your plot to define a box


plot(tay)
e <- drawExtent()    # run this line, then click twice on your plot to define a box
cropped_tay <- crop(b7, e)
plot(cropped_tay)

png('tayplot.png', width = 4, height = 4, units = "in", res = 300)                	# to save plot
image(b8, col= viridis_pal(option="D")(10), main="Sentinel 2 image of Loch Tay")
dev.off()         									# to save plot
# dev.off() is a function that "clears the slate" - it just means you are done using that specific plot
# if you don't dev.off(), that can create problems when you want to save another plot

image(b8, col= viridis_pal(option="D")(10), main="Sentinel 2 image of Loch Tay")


####RGB
# this code specifies how we want to save the plot
png('RGB.png', width = 5, height = 4, units = "in", res = 300)
tayRGB <- stack(list(b4, b3, b2))              # creates raster stack
plotRGB(tayRGB, axes = TRUE, stretch = "lin", main = "Sentinel RGB colour composite")
dev.off()
