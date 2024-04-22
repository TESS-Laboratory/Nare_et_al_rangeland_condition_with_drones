####A function to extract GCP Metadata to obtain x,y, and z coordinates of the GCPs
# Load necessary libraries----
source("Packages.R")

library(exifr)

extract_GCP_metadata <- function(directory_path, height_offset = 1) {
  # Extract directory name to use as the name for the output csv
  directory_name <- basename(directory_path)
  
  # Import image files
  files <- list.files(directory_path, full.names = TRUE)
  
  # Read EXIF metadata for each image
  metadata <- lapply(files, read_exif)
  
  # Extract x, y, z coordinates and GNSS-derived datetime stamp
  xy_coords <- lapply(metadata, function(x) data.frame(
    latitude = x$GPSLatitude,
    longitude = x$GPSLongitude,
    altitude = x$GPSAltitude - height_offset,
    xy_accuracy = 0.01, # Replace with actual XY accuracy
    z_accuracy = 0.01,  # Replace with actual Z accuracy
    datetime_stamp = x$DateTimeOriginal
  ))
  
  # Combine metadata into a single data frame
  combined_metadata <- do.call(rbind, xy_coords)
  
  # Define CRS of coordinates
  crs <- "WGS84 EPSG::32735"
  
  # Insert a new row specifying CRS
  combined_metadata <- rbind(
    data.frame(
      latitude = "CRS",
      longitude = crs,
      altitude = NA,
      xy_accuracy = NA,
      z_accuracy = NA,
      datetime_stamp = NA
    ),
    combined_metadata
  )
  
  # Save metadata as CSV file
  write.csv(combined_metadata, file.path(directory_path, paste0(directory_name, "_data.csv")), row.names = FALSE)
}

# Call the function for each AOI folder
extract_GCP_metadata("C:/Users/202200875/OneDrive - buan.ac.bw/Documents/Drone research/Data/GCPs/AOI1")
extract_GCP_metadata("C:/Users/202200875/OneDrive - buan.ac.bw/Documents/Drone research/Data/GCPs/AOI2")
extract_GCP_metadata("C:/Users/202200875/OneDrive - buan.ac.bw/Documents/Drone research/Data/GCPs/AOI3")
