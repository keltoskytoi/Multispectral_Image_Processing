          #+++EXERCISE 2.3 WORKING WITH MULTISPECTRAL ORTHOIMAGERY+++#
                               
                            #EXERCISE 2.3.1#### 
  #BRING THE SPECTRAL ORTHOMOSAICS TO THE DESIRED RESOLUTION AND PROJECTION#

#To be on the safe side we bring all spectral orthomosaics to the desired (and same) 
#resolution & projection
#+Note that changing the resolution frequently also changes the origin of a 
#raster file+

#EXERCISE 2.3.1.1 Put all raster files which end to .tif from the folder Spect_raw
#containing the spectral orthomosaics of your Agisoft/Metashape output in a list
tiff_list = list.files(path_Spect_raw, full.names = TRUE, 
                       pattern = glob2rx("*.tif"))

#EXERCISE 2.3.1.2 Define the CRS/EPSG code of the desired projection (same as the RGB 
#orthomosaic)
Hohensolms_proj <- "+proj=utm +zone=32 +datum=WGS84 +units=m +no_defs"

#EXERCISE 2.3.1.3. Give to a for-loop the tif-list of the spectral orthomosaics, the 
#projection, the projection method and the resolution of 0.03 meters & write 
#the result in the folder Spect_corr
#Keep in mind that it takes some time!
for (i in 1:length(tiff_list)) {
  r <- raster(tiff_list[i])
  prj <- projectRaster(r, crs=Hohensolms_proj, method = 'bilinear', res = 0.03, 
                       filename = paste0(path_Spect_corr, names(r), "_res_prj.tif"),
                       format="GTiff", overwrite=TRUE)
}

#EXERCISE 2.3.1.4 Control your results!
#read one of the raster files you just reprojected and resampled to 3 cms!
test2 <- stack(paste0(path_Spect_corr, "Hohensolms_05062018_REG_res_prj.tif"))
#check and plot the information of the raster file! Make sure 
test2
plot(test2)
#test the resolution
res(test2)

                               #EXERCISE 2.3.2####
        #CROP THE SPECTRAL ORTHOMOSAICS TO THE SAME EXTENT OF THE RGB#

#Crop the spectral orthoimages which projection and resolution you just set to 
#the same extent of the RGB orthomosaic!  

#EXERCISE 2.3.2.1 First put all raster files which end to .tif from the folder Spect_corr
#containing the spectral orthomosaics you just repprojected and resampled in a list!
tiff_prj_list = list.files(path_Spect_corr, full.names = TRUE, 
                           pattern = glob2rx("*.tif"))

#EXERCISE 2.3.2.2 Create a mask of the size of the region of interest (ROI) 
#- the same as for the RGB orthomosaic
mask_Hohensolms<- as(extent(465996.9899999051121995, 466134.1799999050563201, 
                            5612216.0399723947048187, 5612299.3499723942950368), 
                            "SpatialPolygons")

#EXERCISE 2.3.2.3 Assign the projection of the spectral orthomosaics to the ROI 
#mask you created before
proj4string(mask_Hohensolms) <- Hohensolms_proj

#EXERCISE 2.3.2.4 Give to a for-loop the tif-list of the reprojected and resampled spectral 
#orthomosaics, and crop them to the size of the mask you defined before and export
#the result in the folder Spect_crp
for (i in 1:length(tiff_prj_list)){
  r <- raster(tiff_prj_list[i])
  cr <- crop(r, mask_Hohensolms, filename = paste0(path_Spect_crp, names(r),"_cr.tif"),
             format="GTiff", overwrite=TRUE)
}

#EXERCISE 2.3.2.5. Control your results!
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

                                    #***#

                              #EXERCISE 2.3.3#### 
              #RESET THE ORIGIN OF THE SPECTRAL ORTHOMOSAICS####

#EXERCISE 2.3.3.1 Read all the spectral the orthomosaics you just reprojected, 
#resampled and cropped in the previous exercise#

NIR <- stack(paste0(path_Spect_crp, "Hohensolms_05062018_NIR_res_prj_cr.tif"))
REG <- stack(paste0(path_Spect_crp, "Hohensolms_05062018_REG_res_prj_cr.tif"))
GREEN <- stack(paste0(path_Spect_crp, "Hohensolms_05062018_GRE_res_prj_cr.tif"))
RED <- stack(paste0(path_Spect_crp, "Hohensolms_05062018_RED_res_prj_cr.tif"))

#EXERCISE 2.3.3.2 Reset the origin of the different bands#### 
#Because of the different capture conditions of the different sensors the 
#spectral orthomosaics have different positions in space. You already reprojected, 
#resampled and cropped the orthomosaics. The last thing to do is to reset the 
#origin of each spectral band we wish to use, which is the point closest to (0, 0) 
#that you could get if you moved from the corners of a Raster object toward 
#the origin in steps of the x and y resolution. 
#We have to reset the origin of the spectral orthomosaics to the same value in 
#order to be able to calculate indices. 
#In the case of the RGB orthomosaic we did not have to reset the origin of the spectral 
#bands because they are derived from the same sensor with the same specification 
#in space.

#EXERCISE 2.3.3.2a Reset the origin of the GREEN spectral band
origin(GREEN)
#0.014068181 0.005929392
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

#EXERCISE 2.3.3.2b Reset the origin of the REG spectral band
origin(REG)
#-0.001655439  0.011503051
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

#EXERCISE 2.3.3.2c Reset the origin of the NIR spectral band
origin(NIR)
#0.007322282 -0.004446576
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

#EXERCISE 2.3.3.2d Reset the origin of the RED spectral band
origin(RED)
#0.004874268 0.014978494
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

                
            #All seems fine, let's move on to calculate indices!#

                                       #***#

                                #EXERCISE 2.3.4#### 
                  #CALCULATING INDICES FROM SPECTRAL ORTHOMOSAICS#

#EXERCISE 2.3.4.1. Calculate and save NDVI (Normalized Difference Vegetation Index) 
NDVI <- (NIR-RED)/(NIR+RED)
writeRaster(NDVI, paste0(path_indices_spect, "NDVI_spect.tif"), 
            format= "GTiff", overwrite = TRUE)

        #EXERCISE 2.3.4.2 Calculate spectral indices related to NDVI!#

#EXERCISE 2.3.4.2a RDVI (Renormalized Difference Vegetation Index) 
RDVI <- (NIR - RED)/sqrt(NIR + RED)
writeRaster(RDVI, paste0(path_indices_spect, "RDVI_spect.tif"), 
            format= "GTiff", overwrite = TRUE)

#EXERCISE 2.3.4.2b GNDVI (Green Normalized Difference Vegetation Index) 
GNDVI <- (NIR-GREEN)/(NIR+GREEN)
writeRaster(GNDVI, paste0(path_indices_spect, "GNDVI_spect.tif"), 
            format= "GTiff", overwrite = TRUE)

#EXERCISE 2.3.4.2c NDVI-REG (Normalized Difference Red Edge/Red)
NDVI_REG <- (REG-RED)/(REG+RED)
writeRaster(NDVI_REG, paste0(path_indices_spect, "NDVI_REG_spect.tif"), 
            format= "GTiff", overwrite = TRUE)

#EXERCISE 2.3.4.2d NDRE (Normalized Difference NIR/REG Index) 
NDRE <- (NIR-REG)/(NIR+REG)
writeRaster(NDRE, paste0(path_indices_spect, "NDRE_spect.tif"), 
            format= "GTiff", overwrite = TRUE) 

#EXERCISE 2.3.4.2e Calculate and save GCI (Green Chlorophyll Index)
GCI <- (NIR/GREEN)-1
writeRaster(GCI, paste0(path_indices_spect, "GCI_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#EXERCISE 2.3.4.2f Calculate and save the MSR (Modified Simple Ratio)
MSR2 <- ((NIR/RED)-1)/((sqrt(NIR/RED))+1)
writeRaster(MSR2, paste0(path_indices_spect, "MSR2_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

                                   #***#

                 #Well done, you just completed this chapter!#

                                  #***#