                              #+++PREPARATIONS+++#
#+++removing everything from R
rm(list=ls())

#+++ preparing system-independent environment
if(Sys.info()["sysname"] == "Windows"){
  projRootDir <- "C:/Users/lwraase/Documents/AG_UAV/Chapter_UAV_Workflow/Multispectral_Image_Processing/"
} else {
  projRootDir <- "/home/keltoskytoi/Multispectral_Image_Processing"
}

filebase<-"C:/Users/lwraase/Documents/AG_UAV/Chapter_UAV_Workflow/Multispectral_Image_Processing/"


#+++ load library
#source( "your/path/to/")
source(paste0(projRootDir,"lib_prepro_LW.R"))
#+++installing packages from Github
# do all package loading from the lib script

#+++ Creating a folder structure
paths<-link2GI::initProj(projRootDir = projRootDir,
                         projFolders = c("raw_data/", "orig_data/", "corr_data/",
                                         "output_RGB/", "output_multi/") ,
                         global = TRUE,
                         path_prefix = "path_")

                                   #+++#
#if you use windows
setwd(projRootDir)
                                  #+++#

#EXERCISE 3.2.2. BRING ALL ORTHOIMAGES TO THE SAME RESOLUTION AND PROJECTION####
 
#To be on the safe side first we bring all data to the same resolution & projection
#+++++Note that changing the resolution frequently also changes the origin+++++#

#put all files which end to tif in the working directory in a list
tiff_list = list.files(path_raw_data, full.names = TRUE, pattern = glob2rx("*.tif"))

newproj <- "+proj=utm +zone=32 +datum=WGS84 +units=m +no_defs"
for (i in 1:length(test_block)){
  r <- raster(test_block[1])
    prj <- projectRaster(r, crs=newproj, method = 'bilinear',res = 0.03, 
                         filename = paste0(path_orig_data,names(r),"_testprj.tif")
                         ,overwrite=TRUE)
    }

                      #3.2.2e CONTROL YOUR RESULTS####
#check your results
test <- stack(paste0(path_orig_data, "Hohensolms_05062018_GRE_prj.tif"))
res(test)
plot(test)

        #EXERCISE 3.2.3. CROP THE ORTHOIMAGES TO THE SAME EXTENT####

#put all files which end to tif in the working directory in a list

tiff_prj_list = list.files(path_orig_data, full.names = TRUE, pattern = glob2rx("*.tif"))

msk<- as(extent(465997.002786, 5612299.32769, 466134.223023, 5612216.0154), "SpatialPolygons")
proj4string(msk) <- newproj

#crop the files in the list to the same extent!
for (i in 1:length(tiff_prj_list)){
  r <- raster(tiff_prj_list[1])
  cr <- crop(r,msk,filename = paste0(path_orig_data,names(r),"_cr.tif")
                       ,overwrite=TRUE)
 }

                         #3.2.3e CONTROL YOUR RESULTS####
test2 <- stack(paste0(path_corr_data, "Hohensolms_05062018_RGB_prj_cr.tif"))
plot(test2)
extent(test2)
