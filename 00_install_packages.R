                  ####Install packages and depencies####
                  
#start installing packages from CRAN: 
install.packages("devtools")
install.packages(c("raster", "gdalUtils","rgdal", "mapview", "sp", "spData",
                   "sf", "tools", "RStoolbox", "rgeos", "lattice", "ggplot2", 
                   "RColorBrewer", "signal", "rootSolve"))                  

#install packages from github:
devtools::install_github("r-spatial/link2GI", ref = "master", 
                         dependencies = TRUE, force = TRUE)
devtools::install_github("gisma/uavRst", ref = "master", 
                         dependencies = TRUE, force= TRUE)

#if glcm would not be avaiable on CRAN, please install it from github!
devtools::install_github("azvoleff/glcm")

