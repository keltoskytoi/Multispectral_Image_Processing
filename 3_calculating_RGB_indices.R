                    #EXERCISE 2.3. CALCULATING RGB INDICES####
            #calculating indices from RGB images with the uavRst package#

                    
#2.3.3 Read the RGB image and separate the bands####

Hohensolms_05062018_RGB <- stack(paste0(path_orig_data, "Hohensolms_05062018_RGB_prj.tif"))

#crop the image to a specific extent! 

#create a mask of the size of the region of interest (ROI)!
msk<- as(extent(465996.9899999051121995, 466134.1799999050563201, 
                5612216.0399723947048187, 5612299.3499723942950368), 
                "SpatialPolygons")

#give the mask the projection set before
newproj <- "+proj=utm +zone=32 +datum=WGS84 +units=m +no_defs"
proj4string(msk) <- newproj

#crop the RGB file in the folder to the size of the mask and and write the 
#result in the folder corr_data!

Hohensolms_05062018_RGB_cr <- crop(Hohensolms_05062018_RGB, msk, 
                                   filename = paste0(path_corr_data, 
                                   "Hohensolms_05062018_RGB_prj_cr.tif"),
                                   overwrite=TRUE)


                      #2.2.3e CONTROL YOUR RESULTS####
test2 <- stack(paste0(path_corr_data, "Hohensolms_05062018_RGB_prj_cr.tif"))
plot(test2)
extent(test2)
res(test2)
origin(test2)


#separate the bands of the cropped RGB image####

red <- Hohensolms_05062018_RGB_cr[[1]]
green <- Hohensolms_05062018_RGB_cr[[2]]
blue <- Hohensolms_05062018_RGB_cr[[3]]

#2.3.4 calucltate RGB indeces####

#4a Calculate indices VVI, VARI, NDTI and RI
indices_RGB_1 <- uavRst::rgb_indices(red,
                                     green,
                                     blue,
                                     rgbi = c("VVI", "VARI", "NDTI", "RI"))

#4b View attributes of the raster image
indices_RGB_1
#class      : RasterStack 
#dimensions : 2777, 4574, 12701998, 4  (nrow, ncol, ncell, nlayers)
#resolution : 0.03, 0.03  (x, y)
#extent     : 465997, 466134.2, 5612216, 5612299  (xmin, xmax, ymin, ymax)
#crs        : +proj=utm +zone=32 +datum=WGS84 +units=m +no_defs +ellps=WGS84 +towgs84=0,0,0 
#names      :           VVI,          VARI,          NDTI,            RI 
#min values :  5.843165e-04, -5.862069e-01, -2.500000e-01,  1.754976e-05 
#max values :   0.043288465,   0.709677419,   0.246376812,   0.002630007 

#4c Save the calculated indices as GeoTiffs!
writeRaster(indices_RGB_1, filename = "indices_RGB_1.tif", 
            format="GTiff", bylayer=TRUE, overwrite=TRUE)
#indices_RGB_1_1 = VVI; indices_RGB_1_2 = VARI; 
#indices_RGB_1_3 = NDTI; indices_RGB_1_4 = RI

#4d Calculate indices SCI, BI, SI and HI
indices_RGB_2 <-uavRst::rgb_indices(red,
                                    green,
                                    blue,
                                    rgbi = c("SCI", "BI", "SI", "HI")) 

#4e View attributes of the raster image
indices_RGB_2 

#4f Save the claculated indices a GeoTiffs!
writeRaster(indices_RGB_2, filename = "indices_RGB_2.tif", 
            format="GTiff", bylayer=TRUE, overwrite=TRUE)

#4g Calculate indices TGI, GLI, NGRDI and GRVI
indices_RGB_3 <- uavRst::rgb_indices(red,
                                     green,
                                     blue,
                                     rgbi = c("TGI", "GLI", "NGRDI", "GRVI"))

#4h View attributes of the raster image
indices_RGB_3

#4i Save the claculated indices a GeoTiffs!
writeRaster(indices_RGB_3, filename = "indices_RGB_3.tif", 
            format="GTiff", bylayer=TRUE, overwrite=TRUE)

#4j Calculate indices GLAI, HUE, CI, SAT and SHP
indices_RGB_4 <- uavRst::rgb_indices(red,
                                       green,
                                       blue,
                                       rgbi = c("GLAI", "HUE", "CI", "SAT", "SHP")) 

#4k View attributes of the raster image
indices_RGB_4

#4l Save the claculated indices a GeoTiffs!
writeRaster(indices_RGB_4, filename = "indices_RGB_4.tif", 
            format="GTiff", bylayer=TRUE, overwrite=TRUE)
