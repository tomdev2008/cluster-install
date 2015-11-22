shinyurl=https://download3.rstudio.org/centos5.9/x86_64
shinyfile=shiny-server-1.4.0.721-rh5-x86_64.rpm
export http_proxy=http://web-proxy.atl.hp.com:8080
export https_proxy=http://web-proxy.atl.hp.com:8080

wget $shinyurl/$shinyfile
sudo yum install -y --nogpgcheck $shinyfile
rm -rf $shinyfile

