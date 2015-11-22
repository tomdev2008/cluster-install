#!/usr/bin/Rscript
args <- commandArgs(trailing = TRUE)
print(args)
print(paste('install package:', args[[1]]))
install.packages(args[[1]], repos="http://cran.us.r-project.org"  )
