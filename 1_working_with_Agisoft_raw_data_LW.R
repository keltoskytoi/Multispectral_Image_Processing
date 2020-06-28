                              #+++PREPARATIONS+++#
#+++removing everything from R
rm(list=ls())

#+++ preparing system-independent environment
if(Sys.info()["sysname"] == "Windows"){
  projRootDir <- "C:/Users/lwraase/Documents/AG_UAV/Chapter_UAV_Workflow/Multispectral_Image_Processing/"
} else {
  projRootDir <- "/home/keltoskytoi/Multispectral_Image_Processing/"
}

#+++ load library
#source( "your/path/to/")
source(paste0(projRootDir,"0_library_preprocessing.R"))

#+++installing packages from Github
# do all package loading from the lib script

#+++ Creating a folder structure
paths<-link2GI::initProj(projRootDir = projRootDir,
                         projFolders = c("raw_data/", "orig_data/", "corr_data/",
                                         "output_RGB/", "output_multi/") ,
                         global = TRUE,
                         path_prefix = "path_")


                                 #+++#
#if you use Windows:
setwd(projRootDir)
                                 #+++#

#EXERCISE 3.2.2. BRING ALL ORTHOIMAGES TO THE SAME RESOLUTION AND PROJECTION####
 
#To be on the safe side first we bring all data to the same resolution & projection
#+++++Note that changing the resolution frequently also changes the origin+++++#

#put all files which end to tif in the working directory in a list
tiff_list <- list.files(path_raw_data, pattern = "*tif")

#testimage<-raster(paste0(path_raw_data,"Hohensolms_05062018_GRE.tif"))

 
#????           #set the directory of the result and the suffix of the file
ortho_out=paste0(path_orig_data, substr(tiff_list, 1, nchar(tiff_list)-4), "_re03.tif")

                    
gdalwarp(testimage,t_srs = "EPSG:32632",paste0(path_orig_data,"tahoe_highrez_utm11.tif"), tr= "0.03 0.03")

#set the geographical projection and the resolution (3 cm) of the output file
for (i in 1:length(tiff_list)){
  gdalwarp(tiff_list[i], ortho_out[i], overwrite=TRUE, of = "GTiff", t_srs = "EPSG:32632", 
           tr= "0.03 0.03")
}


#STACK first      
image_stack<-stack(tiff_list)                     




                      #3.2.2e CONTROL YOUR RESULTS####
#this is only a single image, its not stackable
test <- paste0(path_orig_data, "Hohensolms_05062018_RGB_re03.tif")
#achsenwerte sind in den Bildern nicht endlich
# res(test)
# Error in (function (classes, fdef, mtable)  : 
#             unable to find an inherited method for function 'res' for signature '"character"'
#           > plot(test)
#           Error in plot.window(...) : endliche 'ylim' Werte n?tig
#           In addition: Warning messages:
#             1: In xy.coords(x, y, xlabel, ylabel, log) : NAs introduced by coercion
#           2: In min(x) : no non-missing arguments to min; returning Inf
#           3: In max(x) : no non-missing arguments to max; returning -Inf
raster::res(test)
# 
# Error in (function (classes, fdef, mtable)  : 
#             unable to find an inherited method for function 'res' for signature '"character"'
plot(test)

#here is the save data from exercise nessary
#its better not to hard copy all data into a new folder


        #EXERCISE 3.2.3. CROP THE ORTHOIMAGES TO THE SAME EXTENT####

#set the working directory to the folder where you are storing the data created before
#setwd(path_orig_data)

#put all files which end to tif in the working directory in a list
#this needs to be folder ortho_out not orig data
tiff_list <- list.files(path_orig_data,pattern = "*tif")

#set the directory of the result and the suffix of the file
ortho_out=paste0(path_corr_data, substr(tiff_list, 1, nchar(tiff_list)-4), "_cr.tif")

#crop the files in the list to the same extent!
for (i in 1:length(tiff_list)){
  gdal_translate(tiff_list[i], ortho_out[i], overwrite=TRUE, of = "GTiff",
                 projwin = c(465997.002786, 5612299.32769, 466134.223023, 5612216.0154))
}

                         #3.2.3e CONTROL YOUR RESULTS####
test2 <- stack(paste0(path_corr_data, "Hohensolms_05062018_RGB_re03_cr.tif"))
plot(test2)
extent(test2)
