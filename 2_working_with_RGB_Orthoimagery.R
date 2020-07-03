                            #EXERCISE 2.2.1.#### 
     #BRING THE RGB ORTHOMOSAIC TO THE DESIRED RESOLUTION AND PROJECTION#

#To be on the safe side first we will bring the RGB image to the desired 
#resolution & projection 
#+Note that changing the resolution frequently also changes the origin of a 
#raster file!

#First read the RGB Agisoft orthomosaic (raster) output from it's folder
RGB_raw <- stack(paste0(path_RGB_raw, "Hohensolms_05062018_RGB.tif"))

#Set the CRS/EPSG code of the desired projection
Hohensolms_proj <- "+proj=utm +zone=32 +datum=WGS84 +units=m +no_defs"

#Project the raster with the desired projection and save it to a variable
RGB_corr <- projectRaster(RGB_raw, crs=Hohensolms_proj, 
                          method = 'bilinear', res = 0.03) 

#Write the result in a file in the RGB_corr folder!
writeRaster(RGB_corr, paste0(path_RGB_corr, "Hohensolms_05062018_RGB_res_prj.tif"),
            format="GTiff", overwrite=TRUE)  
              
#2.2.1e CONTROL YOUR RESULTS####
#Read the raster file you just reprojected and resampled to 3 cms
test <- stack(paste0(path_RGB_corr, "Hohensolms_05062018_RGB_res_prj.tif"))

#Check and plot the information of the raster file! Make sure it has three bands!
test
plot(test)

#test the resolution!
res(test)

                            #EXERCISE 2.2.2.####
                #CROP THE RGB ORTHOMOSAIC TO A SPECIFIC EXTENT#
    #Crop the orthomosaic which projection and resoltuion you just set to a 
                                #specific extent! 

#First create a mask of the size of the region of interest (ROI)
mask_Hohensolms<- as(extent(465996.9899999051121995, 466134.1799999050563201, 
                            5612216.0399723947048187, 5612299.3499723942950368), 
                            "SpatialPolygons")

#Assign the same projection of the RGB Orthomosaic to the ROI mask you created before
proj4string(mask_Hohensolms) <- Hohensolms_proj

#Crop the projected and resampled RGB raster you created in the previous 
#exercise to the size the mask you defined before
Hohensolms_RGB_cropped <- crop(RGB_corr, mask_Hohensolms)
                 
#Export the result in the folder RGB_crp
writeRaster(Hohensolms_RGB_cropped, paste0(path_RGB_crp, "Hohensolms_05062018_RGB_res_prj_cr.tif"),
            format="GTiff", overwrite=TRUE)    

#2.2.2e CONTROL YOUR RESULTS####

#Read the raster file you just cropped out! 
RGB_Hohensolms <- stack(paste0(path_RGB_crp, "Hohensolms_05062018_RGB_res_prj_cr.tif"))
#Print and plot the information of the data file. Make sure it has three bands. 
RGB_Hohensolms
plot(RGB_Hohensolms)
#Check the extent of the file
extent(RGB_Hohensolms)
#class      : Extent 
#xmin       : 465997 
#xmax       : 466134.2 
#ymin       : 5612216 
#ymax       : 5612299

#Check the resolution of the file
res(RGB_Hohensolms)

            #All seems fine, let's move on to calculation indices!#

                                    #***#

                             #EXERCISE 2.2.3.### 
             #CALCULATING RGB INDICES WITH THE uavRst PACKAGE####

#2.2.3.1 Separate the bands of the reprojected, resammpled and cropped RGB image####
#Note: with [[]] you can access the different bands
red <- RGB_Hohensolms[[1]]
green <- RGB_Hohensolms[[2]]
blue <- RGB_Hohensolms[[3]]

#2.2.3.2 calucltate RGB indices####

#a Calculate indices BI, RI and VVI
indices_RGB <- uavRst::rgb_indices(red,
                                     green,
                                     blue,
                                     rgbi = c("BI", "RI", "VVI"))

#b View attributes of the raster stack
indices_RGB
#class      : RasterStack 
#dimensions : 2777, 4574, 12701998, 4  (nrow, ncol, ncell, nlayers)
#resolution : 0.03, 0.03  (x, y)
#extent     : 465997, 466134.2, 5612216, 5612299  (xmin, xmax, ymin, ymax)
#crs        : +proj=utm +zone=32 +datum=WGS84 +units=m +no_defs +ellps=WGS84 +towgs84=0,0,0 
#names      :           VVI,          VARI,          NDTI,            RI 
#min values :  5.843165e-04, -5.862069e-01, -2.500000e-01,  1.754976e-05 
#max values :   0.043288465,   0.709677419,   0.246376812,   0.002630007 

#You can see, that the indices in c("VVI", "VARI", "NDTI", "RI") are stored in a 
#raster stack. Now you have to save the indices one-by-one in a separate raster 
#file in the correct folder on your computer

#c Save the calculated indices as GeoTiffs!
writeRaster(indices_RGB, paste0(path_indices_RGB, filename = names(indices_RGB), "_RGB.tif"), 
            format="GTiff", bylayer=TRUE, overwrite=TRUE)
