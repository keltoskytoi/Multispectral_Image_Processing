                            #EXERCISE 2.2.1.#### 
     #BRING THE RGB ORTHOIMAGE TO THE DESIRED RESOLUTION AND PROJECTION#

#To be on the safe side first we will bring the RGB image to the our desired 
#resolution & projection 
#+Note that changing the resolution frequently also changes the origin of a 
#raster file

#read the raw RGB Agisoft Orthophoto (raster)
RGB_raw <- stack(paste0(path_RGB_raw, "Hohensolms_05062018_RGB.tif"))

#set the CRS/EPSG code of the desired projection
Hohensolms_proj <- "+proj=utm +zone=32 +datum=WGS84 +units=m +no_defs"

#project the raster with the desired projection
RGB_corr <- projectRaster(RGB_raw, crs=Hohensolms_proj, 
                          method = 'bilinear', res = 0.03) 

#write the result in a file in the RGB_corr folder!
writeRaster(RGB_corr, paste0(path_RGB_corr, "Hohensolms_05062018_RGB_res_prj.tif"),
            format="GTiff", overwrite=TRUE)  
              
#2.2.1e CONTROL YOUR RESULTS####

#read the raster file you just reprojected and resampled to 3 cms! 
test <- stack(paste0(path_RGB_corr, "Hohensolms_05062018_RGB_res_prj.tif"))

#check and plot the information of the data file! make sure it has three bands!
test
plot(test)

#test the resolution!
res(test)

                            #EXERCISE 2.2.2. ####
                   #CROP THE ORTHOIMAGES TO THE SAME EXTENT#
    #crop the Orthoimage which projection and resoltuion you just set to the 
                                #desired extent! 

#first create a mask of the size of the region of interest (ROI)!
mask_Hohensolms<- as(extent(465996.9899999051121995, 466134.1799999050563201, 
                            5612216.0399723947048187, 5612299.3499723942950368), 
                            "SpatialPolygons")

#set the projection of the mask you set the Orthoimage/raster before
proj4string(mask_Hohensolms) <- Hohensolms_proj

#crop the projected and resampled RGB raster to the size the mask!
Hohensolms_RGB_cropped <- crop(RGB_corr, mask_Hohensolms)
                 
#write the result 
writeRaster(Hohensolms_RGB_cropped, paste0(path_RGB_crp, "Hohensolms_05062018_RGB_res_prj_cr.tif"),
            format="GTiff", overwrite=TRUE)    

#2.2.2e CONTROL YOUR RESULTS####

#read the raster file you just cropped out! 
RGB_Hohensolms <- stack(paste0(path_RGB_crp, "Hohensolms_05062018_RGB_res_prj_cr.tif"))
#read and plot the information of the data file! make sure it has three bands!
RGB_Hohensolms
plot(RGB_Hohensolms)
#test the extent of the file!
extent(RGB_Hohensolms)
#class      : Extent 
#xmin       : 465997 
#xmax       : 466134.2 
#ymin       : 5612216 
#ymax       : 5612299

#test the resolution of the file!
res(RGB_Hohensolms)

            #All seems fine, let's move on to calculation indices!#

                                    #***#

                             #EXERCISE 2.2.3.### 
               #Calculating RGB indices with the uavRst package####

#2.3.1 Separate the bands of the cropped RGB image####
#with the [[]] you can access the bands of a raster layer

red <- RGB_Hohensolms[[1]]
green <- RGB_Hohensolms[[2]]
blue <- RGB_Hohensolms[[3]]

#2.3.2 calucltate RGB indices####

#a Calculate indices VVI, VARI, NDTI and RI
indices_RGB_1 <- uavRst::rgb_indices(red,
                                     green,
                                     blue,
                                     rgbi = c("VVI", "VARI", "NDTI", "RI"))

#b View attributes of the raster image
indices_RGB_1
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
writeRaster(indices_RGB_1, filename = "indices_RGB_1.tif", 
            format="GTiff", bylayer=TRUE, overwrite=TRUE)
#indices_RGB_1_1 = VVI; indices_RGB_1_2 = VARI; 
#indices_RGB_1_3 = NDTI; indices_RGB_1_4 = RI

#d Calculate indices SCI, BI, SI and HI
indices_RGB_2 <-uavRst::rgb_indices(red,
                                    green,
                                    blue,
                                    rgbi = c("SCI", "BI", "SI", "HI")) 

#e View attributes of the raster image to test if the calculation went well
indices_RGB_2 

#f Save the calculated indices a GeoTiffs!
writeRaster(indices_RGB_2, filename = "indices_RGB_2.tif", 
            format="GTiff", bylayer=TRUE, overwrite=TRUE)

#g Calculate indices TGI, GLI, NGRDI and GRVI
indices_RGB_3 <- uavRst::rgb_indices(red,
                                     green,
                                     blue,
                                     rgbi = c("TGI", "GLI", "NGRDI", "GRVI"))

#h View attributes of the raster image to test if the calculation went well
indices_RGB_3

#i Save the claculated indices a GeoTiffs!
writeRaster(indices_RGB_3, filename = "indices_RGB_3.tif", 
            format="GTiff", bylayer=TRUE, overwrite=TRUE)

#j Calculate indices GLAI, HUE, CI, SAT and SHP
indices_RGB_4 <- uavRst::rgb_indices(red,
                                     green,
                                     blue,
                                     rgbi = c("GLAI", "HUE", "CI", "SAT", "SHP")) 

#k View attributes of the raster image to test if the calculation went well
indices_RGB_4

#l Save the claculated indices a GeoTiffs!
writeRaster(indices_RGB_4, filename = "indices_RGB_4.tif", 
            format="GTiff", bylayer=TRUE, overwrite=TRUE)
