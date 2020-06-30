                              #+++PREPARATIONS+++#

#+++removing everything from R
rm(list=ls())

#+++ preparing a system-independent environment
#you have to change the *projRootDir* to the place on your computer where you have 
#evtractedthe folder containing the data for this chapter!

if(Sys.info()["sysname"] == "Windows"){
  projRootDir <- "D:/Multispectral_Image_Processing/"
} else {
  projRootDir <- "/home/keltoskytoi/Multispectral_Image_Processing/"
}

#+++ load library
#the source file enables you to install activate pacakges in one run
source(paste0(projRootDir,"0_library_n_prep.R"))

#+++ Creating a folder structure
paths<-link2GI::initProj(projRootDir = projRootDir,
                         projFolders = c("raw_data/", "orig_data/", "corr_data/",
                                         "output_RGB/", "output_multi/") ,
                         global = TRUE,
                         path_prefix = "path_")

#if you use windows you have to set the working directory
setwd(projRootDir)
                                  #+++#

#EXERCISE 3.2.2. BRING ALL ORTHOIMAGES TO THE SAME RESOLUTION AND PROJECTION####
 
#To be on the safe side first we bring all data to the same resolution & projection
#+Note that changing the resolution frequently also changes the origin of a 
#raster file

#put all files which end to .tif in the folder containing the output of 
#Agisoft (raw_data) in a list!
tiff_list = list.files(path_raw_data, full.names = TRUE, 
                       pattern = glob2rx("*.tif"))

#set the CRS/EPSG code of the desired projection
newproj <- "+proj=utm +zone=32 +datum=WGS84 +units=m +no_defs"

#give a for loop the tif-list, the projection and the new resolution and write 
#the result in the folder orig_data!
for (i in 1:length(tiff_list)){
  r <- raster(tiff_list[i])
    prj <- projectRaster(r, crs=newproj, method = 'bilinear', res = 0.03, 
                         filename = paste0(path_orig_data, names(r), "_prj.tif"), 
                         overwrite=TRUE)
    }

                      #3.2.2e CONTROL YOUR RESULTS####
#check your results
test <- stack(paste0(path_orig_data, "Hohensolms_05062018_RGB_prj.tif"))
res(test)
plot(test)

        #EXERCISE 3.2.3. CROP THE ORTHOIMAGES TO THE SAME EXTENT####

#crop all Orthoimages to the same extent! 

#put all files which end to .tif in the folder orig_data in a list!
tiff_prj_list = list.files(path_orig_data, full.names = TRUE, 
                           pattern = glob2rx("*.tif"))

#create a mask of the size of the region of interest (ROI)!
msk<- as(extent(465996.9899999051121995, 466134.1799999050563201, 
                5612216.0399723947048187, 5612299.3499723942950368), 
                "SpatialPolygons")

#give the mask the projection set before
#newproj <- "+proj=utm +zone=32 +datum=WGS84 +units=m +no_defs"
proj4string(msk) <- newproj

#give a for loop the tif-list, crop all raster files in the folder to the size 
#of the mask and and write the result in the folder corr_data!
for (i in 1:length(tiff_prj_list)){
  r <- raster(tiff_prj_list[i])
  cr <- crop(r, msk, filename = paste0(path_corr_data,names(r),"_cr.tif"),
             overwrite=TRUE)
 }

                         #3.2.3e CONTROL YOUR RESULTS####
test2 <- stack(paste0(path_corr_data, "Hohensolms_05062018_RGB_prj_cr.tif"))
plot(test2)
extent(test2)
res(test2)
