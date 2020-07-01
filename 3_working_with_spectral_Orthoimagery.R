                              #EXERCISE 2.3.1.#### 
     #BRING THE SPECTRAL ORTHOIMAGES TO THE DESIRED RESOLUTION AND PROJECTION#

#To be on the safe side we bring all spectral orthoimages to the same resolution
# & projection
#+Note that changing the resolution frequently also changes the origin of a 
#raster file

#Firstput all files which end to .tif in the folder containing the output of 
#Agisoft (raw_data) in a list!
tiff_list = list.files(path_Spect_raw, full.names = TRUE, 
                       pattern = glob2rx("*.tif"))

#set the CRS/EPSG code of the desired projection
Hohensolms_proj <- "+proj=utm +zone=32 +datum=WGS84 +units=m +no_defs"

#give to a for-loop the tif-list, the projection and the new resolution and write 
#the result in the folder orig_data!
for (ij in 1:length(tiff_list)) {
  r <- raster(tiff_list[ij])
  prj <- projectRaster(r, crs=Hohensolms_proj, method = 'bilinear', res = 0.03, 
                       filename = paste0(path_Spect_corr, names(r), "_res_prj.tif"),
                       format="GTiff", overwrite=TRUE)
}

#2.3.1e CONTROL YOUR RESULTS####
#read one of the raster files you just reprojected and resampled to 3 cms! 
test2 <- stack(paste0(path_Spect_corr, "Hohensolms_05062018_REG_res_prj.tif"))

#check and plot the information of the data file! 
test2
plot(test2)

#test the resolution!
res(test2)

                          #EXERCISE 2.3.2.#### 
               #CROP THE ORTHOIMAGES TO THE SAME EXTENT#

    #crop the spectral orthoimages which projection and resoltuion you just set 
                 #to the extent of the RGB orthoimages!  

#put all files which end to .tif in the folder orig_data in a list!
tiff_prj_list = list.files(path_Spect_corr, full.names = TRUE, 
                           pattern = glob2rx("*.tif"))

#create a mask of the size of the region of interest (ROI)!
mask_Hohensolms<- as(extent(465996.9899999051121995, 466134.1799999050563201, 
                            5612216.0399723947048187, 5612299.3499723942950368), 
                            "SpatialPolygons")

#give the mask the projection set before
proj4string(mask_Hohensolms) <- Hohensolms_proj

#give a for loop the tif-list, crop all raster files in the folder to the size 
#of the mask and and write the result in the folder corr_data!
for (i in 1:length(tiff_prj_list)){
  r <- raster(tiff_prj_list[i])
  cr <- crop(r, mask_Hohensolms, filename = paste0(path_Spect_crp, names(r),"_cr.tif"),
             overwrite=TRUE)
}

#2.2.3e CONTROL YOUR RESULTS####

#read the spectral raster file you just cropped out!
GREEN <- stack(paste0(path_Spect_crp, "Hohensolms_05062018_GRE_res_prj_cr.tif"))
plot(GREEN)
#test the extent of the file!
extent(GREEN)
#class      : Extent 
#xmin       : 465997 
#xmax       : 466134.2 
#ymin       : 5612216 
#ymax       : 5612299

#test the resolution of the file!
res(test2)
#0.03 0.03

                            #EXERCISE 2.4.#### 
               #CALCULATING INDICES FROM MULTISPECTRAL BANDS####
