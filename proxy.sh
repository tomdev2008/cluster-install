#!/bin/bash
script=$(readlink -f "$0")
scriptpath=$(dirname "$script")

useproxy=$1
if [[ $useproxy -eq "" ]]; then
  proxy=".proxy"
else
  proxy=""
fi

echo sudo cp $scriptpath/proxy/profile$proxy /etc/profil
sudo cp $scriptpath/proxy/profile$proxy /etc/profile
source /etc/profile
echo sudo cp $scriptpath/proxy/wgetrc$proxy /etc/wgetrc
sudo cp $scriptpath/proxy/wgetrc$proxy /etc/wgetrc
echo sudo cp $scriptpath/proxy/yum.conf$proxy /etc/yum.conf
sudo cp $scriptpath/proxy/yum.conf$proxy /etc/yum.conf

echo tail -n 5 /etc/profile
tail -n 5 /etc/profile

echo 
echo tail -n 5 /etc/wgetrc
tail -n 5 /etc/wgetrc

echo
echo tail -n 5 /etc/yum.conf
tail -n 5 /etc/yum.conf
