# Multispectral_Image_Processing
This is the code for chapter 17 "Identifying burial mounds and enclosures using RGB and multispectral indices derived from UAS imagery".

For the installation of R, RStudio and the packages which are needed to complete this project please see the wiki! 

The .R files are to be treated in the following order: 

#### 00_install_packages.R 
.R file for the installation of pacakges needed for this chapter. Needs to be exectured only once!

#### 0_library_n_prep.R
.R file containing packages needed for the chapter and checking for a valid GDAL installation on the computer. 
Does not need to be executed, will be called by 1_set_up_working_envrnmnt.R

#### 1_set_up_working_envrnmnt.R
.R file which cleans the memory of R, then creates and sets a folder structure on your computer.

#### 2_working_with_RGB_orthoimagery.R
.R file which prepares an RGB orthomosaics for the estimation of RGB indices.

#### 3_working_with_spectral_orthoimagery.R
.R file which prepares spectral orthomosaics for the estimation of spectral indices.
