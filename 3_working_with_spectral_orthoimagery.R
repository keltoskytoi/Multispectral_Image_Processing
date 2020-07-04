                              #EXERCISE 2.3.1.#### 
     #BRING THE SPECTRAL ORTHOMOSAICS TO THE DESIRED RESOLUTION AND PROJECTION#

#To be on the safe side we bring all spectral orthoimosaics to the desired (and same) 
#resolution & projection
#+Note that changing the resolution frequently also changes the origin of a 
#raster file!

#First put all raster files which end to .tif from the folder Spect_raw
#containing the spectral orthomosaics of your Agisoft output in a list!
tiff_list = list.files(path_Spect_raw, full.names = TRUE, 
                       pattern = glob2rx("*.tif"))

#Set the CRS/EPSG code of the desired projection
Hohensolms_proj <- "+proj=utm +zone=32 +datum=WGS84 +units=m +no_defs"

#Give to a for-loop the tif-list of the spectral orthomosaics, the projection 
#and the desired resolution and write the result in the folder Spect_corr!
for (i in 1:length(tiff_list)) {
  r <- raster(tiff_list[i])
  prj <- projectRaster(r, crs=Hohensolms_proj, method = 'bilinear', res = 0.03, 
                       filename = paste0(path_Spect_corr, names(r), "_res_prj.tif"),
                       format="GTiff", overwrite=TRUE)
}

#2.3.1e CONTROL YOUR RESULTS####
#read one of the raster files you just reprojected and resampled to 3 cms! 
test2 <- stack(paste0(path_Spect_corr, "Hohensolms_05062018_REG_res_prj.tif"))

#check and plot the information of the raster file! Make sure 
test2
plot(test2)

#test the resolution!
res(test2)

                          #EXERCISE 2.3.2.#### 
          #CROP THE SPECTRAL ORTHOMOSAICS TO THE SAME SPECIFIC EXTENT#
    #crop the spectral orthoimages which projection and resoltuion you just set 
                 #to the same extent of the RGB orthomosaic!  


#First put all raster files which end to .tif from the folder Spect_corr
#containing the spectral orthomosaics you just repprojected and resampled in a list!
tiff_prj_list = list.files(path_Spect_corr, full.names = TRUE, 
                           pattern = glob2rx("*.tif"))

#create a mask of the size of the region of interest (ROI) 
#- the same as for the RGB orthomosaic
mask_Hohensolms<- as(extent(465996.9899999051121995, 466134.1799999050563201, 
                            5612216.0399723947048187, 5612299.3499723942950368), 
                            "SpatialPolygons")

#Assing the same projection of the spectral Orthomosaics to the ROI mask you created before
proj4string(mask_Hohensolms) <- Hohensolms_proj

#Give to a for-loop the tif-list of the reprojected and resampled spectral 
#orthomosaics, and crop them to the size of the mask you defined before and export
#the result in the folder Spect_crp
for (i in 1:length(tiff_prj_list)){
  r <- raster(tiff_prj_list[i])
  cr <- crop(r, mask_Hohensolms, filename = paste0(path_Spect_crp, names(r),"_cr.tif"),
             overwrite=TRUE)
}

#2.2.3e CONTROL YOUR RESULTS####

#Read one of the spectral raster files you just cropped out
GREEN <- stack(paste0(path_Spect_crp, "Hohensolms_05062018_GRE_res_prj_cr.tif"))
#Print and plot the information of the data file 
GREEN
plot(GREEN)
#Check the extent of the file. Does it correspond with the extent of the 
#cropped RGB orthomosaic?
extent(GREEN)
#class      : Extent 
#xmin       : 465997 
#xmax       : 466134.2 
#ymin       : 5612216 
#ymax       : 5612299

#Check the resolution of the file. Does it correspond with the resolution of the
#cropped RGB mosaic?
res(test2)
#0.03 0.03

#All seems fine, let's move on to calculation indices!#


                            #EXERCISE 2.3.3#### 
               #CALCULATING SPECTRAL INDICES MANUALLY####

#2.3.3.1 Read all the spectral the Orthomosaics you just reprojected, resampled 
#and cropped in the previous exercise####
RGB <- stack(paste0(path_RGB_crp, "Hohensolms_05062018_RGB_res_prj_cr.tif"))
NIR <- stack(paste0(path_Spect_crp, "Hohensolms_05062018_NIR_res_prj_cr.tif"))
REG <- stack(paste0(path_Spect_crp, "Hohensolms_05062018_REG_res_prj_cr.tif"))
GREEN <- stack(paste0(path_Spect_crp, "Hohensolms_05062018_GRE_res_prj_cr.tif"))
RED <- stack(paste0(path_Spect_crp, "Hohensolms_05062018_RED_res_prj_cr.tif"))

#2.3.3.2 Reset the origin of the different bands#### 

#Because of the different capture conditions of the different sensors the 
#Orthomosaics have different positions in space. You already preprojected, 
#resampled and cropped the Orthomosaics. The last thing to do is to reset the 
#origin of each spectral band we wish to use, which is the point closest to (0, 0) 
#that you could get if you moved from the corners of a Raster object toward 
#the origin in steps of the x and y resolution. 
#We have to reset the origin of the spectral Orthomosaics to the same value in 
#order to be able to calculate indices. 
#In case of the RGB Orthomosaic did not have to reset the origin of the spectral 
#bands because they are dervied from the same sensor with the same specification 
#in space.

#4a Reset the origin of the blue band from the RGB image
blue <- RGB[[3]]
#the origin
origin(blue)
#-0.008380143 -0.003690935
origin(blue) = c(0, 0)
origin(blue)
#0 0
res(blue)
#0.03 0.03
extent(blue)
#xmin       : 465997 
#xmax       : 466134.2 
#ymin       : 5612216 
#ymax       : 5612299 

#4b Reset the origin of the spectral raster and check also their extent and resolution!

#NIR
origin(NIR) = c(0, 0)
origin(NIR)
#0 0
res(NIR)
#0.03 0.03
extent(NIR)
#xmin       : 465997 
#xmax       : 466134.2 
#ymin       : 5612216 
#ymax       : 5612299 

#REG
origin(REG) = c(0, 0)
origin(REG)
#0 0
res(REG)
#0.03 0.03
extent(REG)
#xmin       : 465997 
#xmax       : 466134.2 
#ymin       : 5612216 
#ymax       : 5612299

#GREEN
origin(GREEN) = c(0, 0)
origin(GREEN)
#0 0
res(GREEN)
#0.03 0.03
extent(GREEN)
#xmin       : 465997 
#xmax       : 466134.2 
#ymin       : 5612216 
#ymax       : 5612299 

#RED
origin(RED) = c(0, 0)
origin(RED)
#0 0
res(RED)
#0.03 0.03
extent(RED)
#xmin       : 465997 
#xmax       : 466134.2 
#ymin       : 5612216 
#ymax       : 5612299

#Save the calculated indices as GeoTiffs!