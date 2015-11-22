#!/usr/bin/Rscript 
argv <- commandArgs(TRUE)
path <- argv[1]
backupfile <- file.path(path, "old_packages.Rdata")
old_packages <- installed.packages()[,1]
save(old_packages, file= backupfile)
print(paste("saving packages names into", backupfile ))
