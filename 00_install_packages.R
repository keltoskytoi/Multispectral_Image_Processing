                  ####Install packages and depencies####
                  
#start installing packages from CRAN: 
install.packages("devtools")
install.packages(c("raster", "gdalUtils","rgdal", "mapview", "sp", "spData",
                   "sf", "tools", "RStoolbox", "rgeos", "lattice", "ggplot2", 
                   "RColorBrewer", "signal", "rootSolve"))                  

#install packages from github (if not available on CRAN):
devtools::install_github("r-spatial/link2GI", ref = "master", 
                         dependencies = TRUE, force = TRUE)
devtools::install_github("gisma/uavRst", ref = "master", 
                         dependencies = TRUE, force= TRUE)

#if glcm would not be available on CRAN, please install it from github!
devtools::install_github("azvoleff/glcm")

#if you have problems installing uavRst - please install these two packages from the archive!
#if you have further problems please check the github page of uavRst
devtools::install_url('http://cran.r-project.org/src/contrib/Archive/spatial.tools/spatial.tools_1.6.2.tar.gz')
devtools::install_url('http://cran.r-project.org/src/contrib/Archive/velox/velox_0.2.0.tar.gz')
