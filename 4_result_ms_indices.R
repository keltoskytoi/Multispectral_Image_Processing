#5e - NDVI (Normalized Difference Vegetation Index) 
NDVI <- (NIR-RED)/(NIR+RED)
writeRaster(NDVI, filename = "indices_multi_NDVI.tif", format= "GTiff", overwrite = TRUE)

#5f - NDRE (Normalized Difference Red Edge Index) 
NDRE <- (NIR-REG)/(NIR+REG)
writeRaster(NDRE, filename = "indices_multi_NDRE.tif", format= "GTiff", overwrite = TRUE)

#5h - DVI (Difference Vegetation Index) 
DVI <- (NIR - RED)
writeRaster(DVI, filename = "indices_multi_DVI.tif", format= "GTiff", overwrite = TRUE)

#5g - GDVI (Green Difference Vegetation Index)
GDVI <- NIR - GREEN
writeRaster(GDVI, filename = "indices_multi_GDVI.tif", format= "GTiff", overwrite = TRUE)

#5h - GNDVI (Green Normalized Difference Vegetation Index) 
GNDVI <- (NIR-GREEN)/(NIR+GREEN)
writeRaster(GNDVI, filename = "indices_multi_GNDVI.tif", format= "GTiff", overwrite = TRUE)

#5i - RVI (Ratio Vegetation Index)
RVI <- RED/NIR
writeRaster(RVI, filename = "indices_multi_RVI.tif", format= "GTiff", overwrite = TRUE)

#5j - GRVI (Green Ratio Vegetation Index)
GRVI <- NIR/GREEN
writeRaster(GRVI, filename = "indices_multi_GRVI.tif", format= "GTiff", overwrite = TRUE)

#5k - VIN (Vegetation Index Number)
VIN <- NIR/RED
writeRaster(VIN, filename = "indices_multi_VIN.tif", format= "GTiff", overwrite = TRUE)

#5l - SR (Simple Ratio)
SR <- (NIR/RED)
writeRaster(SR, filename = "indices_multi_SR.tif", format= "GTiff", overwrite = TRUE)

#5m - IRG (Red Green Ratio Index)
IRG <- (RED - GREEN)
writeRaster(IRG, filename = "indices_multi_IRG.tif", format= "GTiff", overwrite = TRUE)

#5n - IPVI (Infrared Percentage Vegetation Ratio) 
IPVI <- NIR/(NIR + RED)
writeRaster(IPVI, filename = "indices_multi_IPVI.tif", format= "GTiff", overwrite = TRUE)