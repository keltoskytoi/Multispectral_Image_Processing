# Library packages
libraries<-c("gdalUtils", "glcm","raster","rgdal", "mapview", "sp", "spData",
             "sf", "tools", "RStoolbox", "rgeos", "lattice", "ggplot2", 
             "RColorBrewer", "signal", "rootSolve", "link2GI")

# Install CRAN packages if needed
inst <- libraries %in% installed.packages()
if(length(libraries[!inst]) > 0) install.packages(libraries[!inst])

# Load library packages into session if required
lapply(libraries, require, character.only=TRUE)


#+++checking GDAL installation on your computer#
gdalUtils::gdal_setInstallation()
valid_install <- !is.null(getOption("gdalUtils_gdalPath"))
if(require(raster) && require(rgdal) && valid_install)
getGDALVersionInfo()
