# Load necessary libraries
library(tidyverse)

# Read the csv file

Biomass <- read_csv("C:/Users/202200875/OneDrive - buan.ac.bw/Documents/Drone research/Data/Biosum.csv")

summary(Biomass) #gives summary data
head(Biomass)  #Display first few rows
tail(Biomass)  #Display last rows
dim(Biomass)  #Diplay number of columns and rows

# Summarise the data
summarise()