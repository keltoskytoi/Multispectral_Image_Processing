#BAI (Burned Area Index) 
BAI <- 1/(((0.1 - RED)**2) + ((0.06 - NIR)**2))
writeRaster(BAI, paste0(path_indices_spect, "BAI_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#DVI (Difference Vegetation Index) 
DVI <- (NIR - RED)
writeRaster(DVI, paste0(path_indices_spect, "DVI_spect.tif"), format= "GTiff", overwrite = TRUE)

#EVI (Enhanced Vegetation Index)
EVI <- 2.5*((NIR - RED)/(NIR + (6 * RED - 7.5 * blue + 1)))
writeRaster(EVI, paste0(path_indices_spect, "EVI_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#GDVI (Green Difference Vegetation Index)
GDVI <- NIR - GREEN
writeRaster(GDVI, paste0(path_indices_spect, "GDVI_spect.tif"), format= "GTiff", overwrite = TRUE)

#GNDVI (Green Normalized Difference Vegetation Index) 
GNDVI <- (NIR-GREEN)/(NIR+GREEN)
writeRaster(GNDVI, paste0(path_indices_spect, "GNDVI_spect.tif"), format= "GTiff", overwrite = TRUE)

#GRVI (Green Ratio Vegetation Index)
GRVI <- NIR/GREEN
writeRaster(GRVI, paste0(path_indices_spect, "GRVI_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#IPVI (Infrared Percentage Vegetation Ratio) 
IPVI <- NIR/(NIR + RED)
writeRaster(IPVI, paste0(path_indices_spect, "IPVI_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#NDVI (Normalized Difference Vegetation Index) 
NDVI <- (NIR-RED)/(NIR+RED)
writeRaster(NDVI, paste0(path_indices_spect, "NDVI_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#NDRE (Normalized Difference Red Edge Index) 
NDRE <- (NIR-REG)/(NIR+REG)
writeRaster(NDRE, paste0(path_indices_spect, "NDRE_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#MSR (Modified Simple Ratio)
MSR <- RED/((NIR/RED + 1)**0.5)
writeRaster(MSR, paste0(path_indices_spect, "MSR_spect.tif"), format= "GTiff", 
            overwrite = TRUE)
#or
MSR2 <- ((NIR/RED)-1)/(sqrt(NIR/RED)+1)
writeRaster(MSR2, paste0(path_indices_spect, "MSR2_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#RDVI (Renormalized Difference Vegetation Index) 
RDVI <- (NIR - RED)/sqrt(NIR + RED)
writeRaster(RDVI, paste0(path_indices_spect, "RDVI_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#RGI (Red Green Ratio Index)
RGI <- (RED - GREEN)
writeRaster(IRG, paste0(path_indices_spect, "IRG_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#RVI (Ratio Vegetation Index)
RVI <- RED/NIR
writeRaster(RVI, paste0(path_indices_spect, "RVI_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#SR (Simple Ratio)
SR <- (NIR/RED)
writeRaster(SR, paste0(path_indices_spect, "SR_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#TDVI (Transformed Difference Vegetation Index)
TNDVI <- sqrt(0.5 + (NIR-RED/NIR+RED))
writeRaster(TDVI, paste0(path_indices_spect, "TNDVI_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#TVI (Transformed Vegetation Index)
TVI <- sqrt(NDVI + 0.5)
writeRaster(TVI, paste0(path_indices_spect, "TVI_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#VIN (Vegetation Index Number)
VIN <- NIR/RED
writeRaster(VIN, paste0(path_indices_spect, "VIN_spect.tif"), format= "GTiff", 
            overwrite = TRUE)
