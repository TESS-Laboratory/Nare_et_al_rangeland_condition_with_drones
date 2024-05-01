trees_bicuar <- read.csv("C:/workspace/Nare_dev/CC-5-fun-and-loop-master/CC-5-fun-and-loop-master/trees_bicuar.csv")
trees_mlunguya <- read.csv("C:/workspace/Nare_dev/CC-5-fun-and-loop-master/CC-5-fun-and-loop-master/trees_mlunguya.csv")
head(trees_bicuar)
str(trees_bicuar)
head(trees_mlunguya)
str(trees_mlunguya)
##Function
example.fn <- function(x, y){
  # Perform an action using x and y
  x + y
}

##Running code
example.fn(x = 1, y = 2)

##Function for basal area 
basal.area <- function(x){
  (pi*(x)^2)/40000
}
##Testubf basal function
basal.area(x = trees_bicuar$diam)

####On multiple sites (...) operator
basal.area <- function(...){
  (pi*c(...)^2)/40000
}

basal.area(trees_bicuar$diam, trees_mlunguya$diam)

#### Assigning object to function, and creating new column
trees_bicuar$ba <- basal.area(dbh = trees_bicuar$diam)

#####Loops
trees <- list("trees_bicuar" = trees_bicuar, "trees_mlunguya" = trees_mlunguya)

for( i in 1:length(trees) ){
  trees[[i]]$ba <- basal.area(trees[[i]]$diam)
}
trees_mlunguya_list <- split(trees_mlunguya, trees_mlunguya$year)
# Create an empty list
mean_ba_list <- list()

for( i in 1:length(trees_mlunguya_list) ){
  ba <- basal.area(trees_mlunguya_list[[i]]$diam)
  mean_ba <- mean(ba)
  year <- mean(trees_mlunguya_list[[i]]$year)
  dat <- data.frame(year, mean_ba)
  mean_ba_list[[i]] <- dat
}
lapply(trees_mlunguya_list, function(x){ba.mean.year(dbh = x$diam, year = x$year)})
lapply(bicuar_height_list, mean, na.rm = TRUE)
sapply(bicuar_height_list, mean, na.rm = TRUE)
