#!/usr/bin/Rscript 

#更新已安装的R包(电脑重新安装时，特别有用，或者安装了R的新版本)
argv <- commandArgs(TRUE)
path <- argv[1]
load(paste(path, "old_packages.Rdata", sep="/"))
new_pacakges <- installed.packages()[,1]
for (package in setdiff(old_packages, new_pacakges)){
  install.packages(package)
  cat('\n--------------------------------------------------------------------')
  cat('\nHave installed Package:',  package)
  cat('\n--------------------------------------------------------------------')
}
