                              #+++PREPARATIONS+++#

#+++removing everything from R
rm(list=ls())

#+++ preparing system-independent environment
if(Sys.info()["sysname"] == "Windows"){
  projRootDir <- "C:/Users/lwraase/Documents/bale/"
} else {
  projRootDir <- "/home/keltoskytoi/Multispectral_Image_Processing"
}

#+++ Creating a folder structure
paths<-link2GI::initProj(projRootDir = projRootDir,
                         projFolders = c("raw_data/", "orig_data/", "corr_data/",
                                         "output_RGB/", "output_multi/") ,
                         global = TRUE,
                         path_prefix = "path_")

#+++ load library
source("/home/keltoskytoi/Multispectral_Image_Processing/library.R")

#+++set the working directory where you want to have your results
setwd(path_output_multi)

#+++checking GDAL installation#
gdal_setInstallation()
valid_install <- !is.null(getOption("gdalUtils_gdalPath"))
if(require(raster) && require(rgdal) && valid_install)
getGDALVersionInfo()
                                    #+++#

        #EXERCISE 3.4. CALCULATING INDICES FROM MULTISPECTRAL BANDS####

#3.4.3 Read the Orthoimages####
RGB <- stack(paste0(path_corr_data, "Hohensolms_05062018_RGB_re03_cr.tif"))
NIR <- stack(paste0(path_corr_data, "Hohensolms_05062018_NIR_re03_cr.tif"))
REG <- stack(paste0(path_corr_data, "Hohensolms_05062018_REG_re03_cr.tif"))
GREEN <- stack(paste0(path_corr_data, "Hohensolms_05062018_GRE_re03_cr.tif"))
RED <- stack(paste0(path_corr_data, "Hohensolms_05062018_RED_re03_cr.tif"))

#3.4.4 Reset the origin of the different bands#### 

#4a Reset the origin of the blue band from the RGB image

blue <- RGB[[3]]

origin(blue)
#-0.002786623  0.010713633
origin(blue) = c(0, 0)


#4b Reset the origin of the multispectral images####

#NIR
origin(NIR) 
#0.007290063 -0.004555208
origin(NIR) = c(0, 0)

#REG
origin(REG) = c(0, 0)
#GREEN
origin(GREEN) = c(0, 0)
#RED
origin(RED) = c(0, 0)

#4c Check the origin and the extent of some of the multispectral raster!
extent(RED)
#class      : Extent 
#xmin       : 465997 
#xmax       : 466134.2 
#ymin       : 5612216 
#ymax       : 5612299 
res(RED)
#0.03 0.03
origin(RED)
#0 0

extent(NIR)
#class      : Extent 
#xmin       : 465997 
#xmax       : 466134.2 
#ymin       : 5612216 
#ymax       : 5612299 
res(NIR)
#0.03 0.03
origin(NIR)
#0 0

#3.4.5 Calculate the multispectral indices!

#5a - TDVI (Transformed Difference Vegetation Index)
TDVI <- sqrt(0.5 + (NIR-RED/NIR+RED))
writeRaster(TDVI, filename = "indices_multi_TDVI.tif", format= "GTiff", overwrite = TRUE)

#5b - MSR (Modified Simple Ratio)
MSR <- RED/((NIR/RED + 1)**0.5)
writeRaster(MSR, filename = "indices_multi_MSR.tif", format= "GTiff", overwrite = TRUE)

#or

MSR2 <- ((NIR/RED)-1)/(sqrt(NIR/RED)+1)

#5c - EVI (Enhanced Vegetation Index)
EVI <- 2.5*((NIR - RED)/(NIR + (6 * RED - 7.5 * blue + 1)))
writeRaster(EVI, filename = "indices_multi_EVI.tif", format= "GTiff", overwrite = TRUE)

#5d - TVI (Transformed Vegetation Index)
TVI <- sqrt(NDVI + 0.5)
writeRaster(TVI, filename = "indices_multi_TVI.tif", format= "GTiff", overwrite = TRUE)

#5e - BAI (Burned Area Index) 
BAI <- 1/(((0.1 - RED)**2) + ((0.06 - NIR)**2))
writeRaster(BAI, filename = "indices_multi_BAI.tif", format= "GTiff", overwrite = TRUE)

#5f - RDVI (Renormalized Difference Vegetation Index) 
RDVI <- (NIR - RED)/sqrt(NIR + RED)
writeRaster(RDVI, filename = "indices_multi_RDVI.tif", format= "GTiff", overwrite = TRUE)

#Now it's your turn!

#5g - NDVI (Normalized Difference Vegetation Index) 

#5h - NDRE (Normalized Difference Red Edge Index) 

#5i - DVI (Difference Vegetation Index) 

#5j - GDVI (Green Difference Vegetation Index)

#5k - GNDVI (Green Normalized Difference Vegetation Index) 

#5l - RVI (Ratio Vegetation Index)

#5m - GRVI (Green Ratio Vegetation Index)

#5n - VIN (Vegetation Index Number)

#5o - SR (Simple Ratio)

#5p - IRG (Red Green Ratio Index)

#5q - IPVI (Infrared Percentage Vegetation Ratio) 