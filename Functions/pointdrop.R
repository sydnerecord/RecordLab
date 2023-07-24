# --------------------------------------
# FUNCTION: pointdrop
# Author: Lizbeth G Amador
# Required packages: terra, sf 
# Description: Drop spatial points outsides of specified study area
# Inputs: point.df (spatial dataframe), sa.shp (vector sh), 
# lat.name (string), long.name (string)
# Outputs: newpoint.df
# --------------------------------------

# Note: Use source() to run from another script


#########
#Function
#########
pointdrop <- function(point.df, sa.shp, lat.name, long.name, plotit = TRUE, export.csv = FALSE) {
  
  ## Download required packages, install if system does not have them
  if(!require(terra)){
    install.packages("terra")
    library(terra)
  }
  if(!require(sf)){
    install.packages("sf")
    library(sf)
  }
  
  # geom.df is a vector of characters containing the lat/long column names
  # from the dataframe
  geom.df = c(long.name, lat.name)
  
  
  ## Coordinate Reference System of base vector/raster
  # Getting Coordinate Reference System (CRS) from study area shape file
  sa_crs = crs(sa.shp,
               proj=TRUE, #crs returned in PROJ-String notation
               describe=FALSE #if TRUE: name, EPSG code, name & extent of area returned
  )
  
  
  ## Intersecting points 
  # First: Convert point data frame to point vector
  point_shp = vect(
    point.df, #dataframe with lat/long coordinates
    geom=geom.df, #specifying GPS coordinates
    crs = sa_crs, #setting coordinate reference system as the extent 
    keepgeom=FALSE #geom variable(s) is (are) not included in attributes
  )
  
  # Second: Drop points outside of extent  
  # Note: If input is a raster, must intersect with another raster!
  sa_point = intersect(
    point_shp, #point shape file (input vector)
    sa.shp #extent reference (intersecting vector)
  )
  
  
  ## Plot point vector on study area map
  if(plotit == TRUE){
    main.title <- readline(prompt="Enter plot title: ")
    #open in new window
    x11()
    #plotting study area shape file
    plot(sa.shp, axes = TRUE, main = main.title)
    #adding point vector to the plot
    plot(sa_point, pch = 1, add = TRUE)
  }
  
  
  #Converting to sf object to keep precision in the lat/long points 
  sa_point_sf = sf::st_as_sf(sa_point)
  
  #Extracting lat/long data from geometry field
  sa_point_sf$longitude = st_coordinates(sa_point_sf)[,1]
  sa_point_sf$latitude = st_coordinates(sa_point_sf)[,2]
  #converting NPN point vector to a dataframe
  newpoint.df = select(as.data.frame(sa_point_sf), -c("FIPS", "LON", 
                                                      "LAT", "geometry"))
  return(newpoint.df)
  
  
  ## Exporting if TRUE - FALSE default
  if(export.csv == TRUE){
    filename = readline(prompt = "Enter filename: ")
    filepath = readline(prompt = "Enter directory to file: ")
    write.csv(newpoint.df, file = file.path(filepath, paste0(filename, ".csv", sep='')), row.names = FALSE)
  }
}


###########
# Example: 
# NeonNpn_conus <- pointdrop(NeonNpn, CONUS.shp, "latitude", "longitude")
###########
