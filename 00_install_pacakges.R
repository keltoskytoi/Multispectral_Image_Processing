                  ####Install packages and depencies####
                  
#start installing packages with: 
install.packages("devtools")
install.packages("raster")                  

#install packages from github:
devtools::install_github("r-spatial/link2GI", ref = "master", dependencies = TRUE, force = TRUE)
devtools::install_github("azvoleff/glcm")
devtools::install_github("gisma/uavRst", ref = "master", dependencies = TRUE, force= TRUE)