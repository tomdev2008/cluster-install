#!/bin/bash
script=$(readlink -f "$0")
scriptpath=$(dirname "$script")
source $scriptpath/config.`hostname`


if [ ! -e /usr/local/bin/python ]
then
  cd $targetpath/software
  ll
  sudo rm -rf $targetpath/software/$python_folder
  tar zxvf $python_jar
  cd $python_folder
  ./configure
  make
  sudo make install
fi

