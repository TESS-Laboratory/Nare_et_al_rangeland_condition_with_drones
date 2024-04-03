##############################INTRODUCTION##################################----
# Evaluating rangeland condition using remote sensing from Unoccupied Aerial 
# Vehicles (UAVs) : R Script
# Author: Alan Dumezweni Nare
# Email: alandnare@gmail.com
# Date: 2024
# Description: This script is part of an MSc research project aimed at evaluating
#              rangeland condition using remote sensing data acquired from unoccupied
#              aerial vehicles (UAVs). The research focuses on assessing the
#              predictive capacity of RGB and multispectral datasets in estimating
#              aboveground biomass in a Kalahari savanna ecosystem in Botswana.
#              Structure from Motion (SfM) photogrammetry is performed on RGB images to
#              generate canopy height data, while multispectral data is utilised
#              to capture spectral reflectance information. Destructive harvesting
#              techniques are incorporated for validating and calibrating remote
#              sensing derived biomass estimates. This script facilitates data
#              preprocessing, analysis, and visualization for the research project.
################################################################################

# Load necessary libraries----
library(exifr)




## Read GCP image metadata captured by MS drone to extract coordinates of the GCPs----
