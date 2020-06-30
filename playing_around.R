#4b Reset the origin of the Orthoimages####

tiff_orig_list = list.files(path_orig_data, full.names = TRUE, 
                           pattern = glob2rx("*.tif"))

r <- stack(tiff_orig_list[1])
#origin(r)
origin(r) <- 0
writeRaster(r, filename = paste0(path_tmp, names(r), "_or.tif"),
            format="GTiff", bylayer=TRUE, overwrite=TRUE)

###

#reset the origin of the Orthoimages!
for (i in 1:length(tiff_orig_list)){
  r <- stack(tiff_orig_list[1])
  origin(r) <- 0
  writeRaster(r, filename = paste0(path_tmp, names(r), "_or.tif"), 
              overwrite=TRUE)
}

test3 <- stack(paste0(path_tmp, "layer_or_1.tif"))
origin(test3)




NIR <- stack(paste0(path_tmp, "Hohensolms_05062018_NIR_prj_or.tif"))
origin(NIR) 
#0.007290063 -0.004555208
origin(NIR) = c(0, 0)

