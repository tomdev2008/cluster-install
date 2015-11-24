#!/bin/bash
script=$(readlink -f "$0")
scriptpath=$(dirname "$script")
source $scriptpath/config.sh

if [ ! -e /usr/local/bin/pdsh ]
then
  cd $targetpath/software
  ll
  tar jxvf sshpass-1.05.tar.gz
  cd sshpass-1.05
  ./configure  
  make
  sudo make install
fi

