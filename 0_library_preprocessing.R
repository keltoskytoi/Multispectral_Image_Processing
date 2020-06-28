# Library packages
libraries<-c("gdalUtils", "glcm","raster","rgdal", "mapview", "sp", "spData",
             "sf", "tools", "RStoolbox", "rgeos", "lattice", "ggplot2", 
             "RColorBrewer", "signal", "rootSolve", "uavRst", "link2GI")

# Install CRAN packages if needed
inst <- libraries %in% installed.packages()
if(length(libraries[!inst]) > 0) install.packages(libraries[!inst])

# Load library packages into session if required
lapply(libraries, require, character.only=TRUE)

#add install dependencies!
#only in case that you need to install missing packages:
#devtools::install_github("r-spatial/link2GI", ref = "master", dependencies = TRUE, force = TRUE)
#devtools::install_github("azvoleff/glcm")
#devtools::install_github("gisma/uavRst", ref = "master", dependencies = TRUE, force= TRUE)


#+++checking GDAL installation#
gdal_setInstallation()
valid_install <- !is.null(getOption("gdalUtils_gdalPath"))
if(require(raster) && require(rgdal) && valid_install)
  getGDALVersionInfo()