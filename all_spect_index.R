#BAI (Burned Area Index) 
BAI <- 1/(((0.1-RED)**2) + ((0.06-NIR)**2))
writeRaster(BAI, paste0(path_indices_spect, "BAI_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#BNDVI (Blue Normalized Difference Index)
BNDVI <- (NIR-blue)/(NIR+blue)
writeRaster(BNDVI, paste0(path_indices_spect, "BNDVI_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#CCCI (Canopy Chlorophyll Content Index)
CCCI <- ((NIR-REG)/(NIR+REG))/((NIR-RED)/(NIR+RED))
writeRaster(CCCI, paste0(path_indices_spect, "CCCI_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#CVI (Chlorophyll Vegetation Index)
CVI <- NIR*(RED/(GREEN**2))
writeRaster(CVI, paste0(path_indices_spect, "CVI_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#DVI (Difference Vegetation Index) 
DVI <- (NIR-RED)
writeRaster(DVI, paste0(path_indices_spect, "DVI_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#EVI (Enhanced Vegetation Index)
EVI <- 2.5*((NIR-RED)/(NIR+(6*RED)-(7.5*blue)+1))
writeRaster(EVI, paste0(path_indices_spect, "EVI_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#GCI (Green Chlorophyll Index)
GCI <- (NIR/GREEN)-1
writeRaster(GCI, paste0(path_indices_spect, "GCI_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#GDVI (Green Difference Vegetation Index)
GDVI <- NIR - GREEN
writeRaster(GDVI, paste0(path_indices_spect, "GDVI_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#GNDVI (Green Normalized Difference Vegetation Index) 
GNDVI <- (NIR-GREEN)/(NIR+GREEN)
writeRaster(GNDVI, paste0(path_indices_spect, "GNDVI_spect.tif"), format= "GTiff",
            overwrite = TRUE)

#GOSAVI (Green Optimized Soil Adjusted Vegetation Index)
GOSAVI <- (NIR-GREEN)/(NIR+GREEN+0.16)
writeRaster(GOSAVI, paste0(path_indices_spect, "GOSAVI_spect.tif"), format= "GTiff",
            overwrite = TRUE)

#GRNDVI (Green - Red Normalized Difference Vegetation Index)
GRNDVI <- (NIR-(GREEN+RED))/(NIR+(GREEN+RED))
writeRaster(GRNDVI, paste0(path_indices_spect, "GRNDVI_spect.tif"), format= "GTiff",
            overwrite = TRUE)

#GRVI (Green Ratio Vegetation Index)
GRVI <- NIR/GREEN
writeRaster(GRVI, paste0(path_indices_spect, "GRVI_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#GSAVI (Green Soil Adjusted Vegetation Index)
GSAVI<-1.5*((NIR-GREEN)/(NIR+GREEN+0.5))
writeRaster(GSAVI, paste0(path_indices_spect, "GSAVI_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#IPVI (Infrared Percentage Vegetation Ratio) 
IPVI <- NIR/(NIR + RED)
writeRaster(IPVI, paste0(path_indices_spect, "IPVI_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#MNLI (Modified Non-Linear Index)
MNLI <- (((NIR**2)-RED)*(1+0.5))/((NIR**2)+RED+0.5)
writeRaster(MNLI, paste0(path_indices_spect, "MNLI_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#MSAVI (Modified Soil Adjusted Vegetation Index)
MSAVI <-((((2*NIR)+1)-(sqrt(((2*NIR)+1)**2)-8*(NIR-RED))))/2
writeRaster(MSAVI, paste0(path_indices_spect, "MSAVI_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#MSR (Modified Simple Ratio)
MSR <- RED/((NIR/RED + 1)**0.5)
writeRaster(MSR, paste0(path_indices_spect, "MSR_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

MSR2 <- ((NIR/RED)-1)/((sqrt(NIR/RED))+1)
writeRaster(MSR2, paste0(path_indices_spect, "MSR2_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#MTVI (Modified Triangular Vegetation Index)
MTVI <- 1.2*((1.2*(NIR-GREEN))-(2.5*(RED-GREEN)))
writeRaster(MTVI, paste0(path_indices_spect, "MTVI_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#MTVI2 (Modified Triangular Vegetation Index)
MTVI2 <- 1.5 *(((1.2*(NIR-GREEN))-(2.5*(RED-GREEN)))/(sqrt((((2*NIR)+1)**2)-((6*NIR)-(5*(sqrt(RED))))-0.5)))
writeRaster(MTVI2, paste0(path_indices_spect, "MTVI2_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#NDRE (Normalized Difference NIR/REG Index) 
NDRE <- (NIR-REG)/(NIR+REG)
writeRaster(NDRE, paste0(path_indices_spect, "NDRE_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#NDVI (Normalized Difference Vegetation Index) 
NDVI <- (NIR-RED)/(NIR+RED)
writeRaster(NDVI, paste0(path_indices_spect, "NDVI_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#IPV2
IPVI2 <- ((NIR/(NIR+RED))/2)*(NDVI+1)
writeRaster(IPVI2, paste0(path_indices_spect, "IPVI2_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#NDVI-REG (Normalized Difference Red Edge/Red)
NDVI_REG <- (REG-RED)/(REG+RED)
writeRaster(NDVI_REG, paste0(path_indices_spect, "NDVI_REG_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#NLI (Non-linear Index)
NLI <- ((NIR**2)-RED)/((NIR**2)+RED)
writeRaster(NLI, paste0(path_indices_spect, "NLI_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#NPCI (Normalized Pigment Chlorophyll Index)
NPCI <- (REG-blue)/(REG+blue)
writeRaster(NPCI, paste0(path_indices_spect, "NPCI_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#OSAVI (Optimized Soil Adjusted Vegetation Index)
OSAVI <-(NIR-RED)/(NIR+RED+0.16)
writeRaster(OSAVI, paste0(path_indices_spect, "OSAVI_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#RBNDVI (Red Blue NDVI)
RBNDVI <- (NIR-(RED+blue))/(NIR+(RED+blue))
writeRaster(RBNDVI, paste0(path_indices_spect, "RBNDVI_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#RCI Rededge (Red edge Chlorophyll Index)
RCIREG <- (NIR/REG) - 1
writeRaster(RCIREG, paste0(path_indices_spect, "RCIREG_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#RDVI (Renormalized Difference Vegetation Index) 
RDVI <- (NIR - RED)/sqrt(NIR + RED)
writeRaster(RDVI, paste0(path_indices_spect, "RDVI_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#RVI (Ratio Vegetation Index)
RVI <- (RED/NIR)
writeRaster(RVI, paste0(path_indices_spect, "RVI_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#SAVI (Soil Adjusted Vegetation Index)
SAVI <- 1.5*((NIR-RED)/(NIR+RED+0.5))
writeRaster(SAVI, paste0(path_indices_spect, "SAVI_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#SARVI2 (Soil and Atmospherically Resistant Vegetation Index 2)
SARVI2 <- 2.5*((NIR-RED)/(1+NIR+ (6*RED)-(7.5*blue)))
writeRaster(SARVI2, paste0(path_indices_spect, "SARVI2_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#SR (Simple Ratio)
SRI <- (NIR/RED)
writeRaster(SRI, paste0(path_indices_spect, "SRI_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#SR x NDVI 
SRNDVI <- ((NIR**2)- RED)/(NIR +(RED**2))
writeRaster(SRNDVI, paste0(path_indices_spect, "SRNDVI_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#TDVI (Transformed Difference Vegetation Index)
TDVI <- 1.5*((NIR-RED)/sqrt((NIR**2)+RED+0.5))
writeRaster(TDVI, paste0(path_indices_spect, "TDVI_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#TNDVI (Transformed Normalized Difference Vegetation Index)
TNDVI <- sqrt(0.5+(NIR-RED/NIR+RED))
writeRaster(TNDVI, paste0(path_indices_spect, "TNDVI_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#TVI (Transformed Vegetation Index)
TVI <- sqrt(NDVI + 0.5)
writeRaster(TVI, paste0(path_indices_spect, "TVI_spect.tif"), format= "GTiff", 
            overwrite = TRUE)

#VIN (Vegetation Index Number)
VIN <- NIR/RED
writeRaster(VIN, paste0(path_indices_spect, "VIN_spect.tif"), format= "GTiff", 
            overwrite = TRUE)
