                                #+++PREPARATIONS+++#

#+++removing everything from R, to get a clear working environment
rm(list=ls())

#+++ preparing a system-independent environment
#you have to change the *projRootDir* to the place on your computer where you have 
#evtractedthe folder containing the data for this chapter!

if(Sys.info()["sysname"] == "Windows"){
  projRootDir <- "D:/Multispectral_Image_Processing/"
} else {
  projRootDir <- "/home/keltoskytoi/Multispectral_Image_Processing/"
}

#+++ load library
#the source file enables you to install activate pacakges in one run
source(paste0(projRootDir,"0_library_n_prep.R"))

#+++ Creating a folder structure
paths<-link2GI::initProj(projRootDir = projRootDir,
                         projFolders = c("RGB_raw/", "Spect_raw/", 
                                         "RGB_corr/", "Spect_corr/",
                                         "RGB_crp/", "Spect_crp/",
                                         "indices_RGB/", "indices_spect/") ,
                         global = TRUE,
                         path_prefix = "path_")

#if you use Windows you have to set the working directory
setwd(projRootDir)