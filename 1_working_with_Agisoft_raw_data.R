                              #+++PREPARATIONS+++#
#+++removing everything from R
rm(list=ls())

#+++installing packages from Github
devtools::install_github("r-spatial/link2GI", ref = "master", dependencies = TRUE, force = TRUE)
#only in case that you need to install  glcm:
devtools::install_github("azvoleff/glcm")
devtools::install_github("gisma/uavRst", ref = "master", dependencies = TRUE, force= TRUE)

#+++ preparing system-independent environment
if(Sys.info()["sysname"] == "Windows"){
  projRootDir <- "C:/Users/lwraase/Documents/bale/"
} else {
  projRootDir <- "/home/keltoskytoi/Multispectral_Image_Processing"
}

#+++ load library
source("/home/keltoskytoi/Multispectral_Image_Processing/library.R")

#+++ Creating a folder structure
#projRootDir <- "F:/Multispectral_Image_Processing"

paths<-link2GI::initProj(projRootDir = projRootDir,
                         projFolders = c("raw_data/", "orig_data/", "corr_data/",
                                         "output_RGB/", "output_multi/") ,
                         global = TRUE,
                         path_prefix = "path_")


#+++set the working directory where your data calculated in Agisoft is
setwd(path_raw_data)
                                   #+++#
#+++checking GDAL installation#
gdal_setInstallation()
valid_install <- !is.null(getOption("gdalUtils_gdalPath"))
if(require(raster) && require(rgdal) && valid_install)
getGDALVersionInfo()
                                   #+++#

#EXERCISE 3.2.2. BRING ALL ORTHOIMAGES TO THE SAME RESOLUTION AND PROJECTION####
 
#To be on the safe side first we bring all data to the same resolution & projection
#+++++Note that changing the resolution frequently also changes the origin+++++#
tiff_list <- dir(pattern = "*tif")

ortho_out=paste0(path_orig_data, substr(tiff_list, 1, nchar(tiff_list)-4), "_re03.tif")

for (i in 1:length(tiff_list)){
  gdalwarp(tiff_list[i], ortho_out[i], overwrite=TRUE, of = "GTiff", t_srs = "EPSG:32632", 
           tr= "0.03 0.03")
}

#3.2.2e CONTROL YOUR RESULTS####
test <- stack(paste0(path_orig_data, "Hohensolms_05062018_RGB_re03.tif"))
res(test)
plot(test)

         #EXERCISE 3.2.3. CROP THE ORTHOIMAGES TO THE SAME EXTENT####

#set the working directory to the folder where you are storing the data created before
setwd(path_orig_data)

tiff_list <- dir(pattern = "*tif")

ortho_out=paste0(path_corr_data, substr(tiff_list, 1, nchar(tiff_list)-4), "_cr.tif")

for (i in 1:length(tiff_list)){
  gdal_translate(tiff_list[i], ortho_out[i], overwrite=TRUE, of = "GTiff",
                 projwin = c(465997.002786, 5612299.32769, 466134.223023, 5612216.0154))
}

#3.2.3e CONTROL YOUR RESULTS####
test2 <- stack(paste0(path_corr_data, "Hohensolms_05062018_RGB_re03_cr.tif"))
plot(test2)
extent(test2)
