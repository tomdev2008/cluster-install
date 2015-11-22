#!/bin/bash
script=$(readlink -f "$0")
scriptpath=$(dirname "$script")
source $scriptpath/config.sh

echo =========`hostname`=========


software_home=$1
software_folder=$2
software_jar=$3

if [ ! -d $aapath/$software_folder  ]
then
  if [ ! -f $aapath/$software_jar ]
  then
    echo $user@$master:$softwarepath/$software_jar $aapath
    scp $user@$master:$softwarepath/$software_jar $aapath
  fi
  echo tar zxvf $aapath/$software_jar -C $aapath
  tar zxvf $aapath/$software_jar -C $aapath
  echo rm -rf $aapath/$software_jar
  rm -rf $aapath/$software_jar
fi

echo rm -rf $software_home
rm -rf $software_home
echo ln -s $aapath/$software_folder $software_home
ln -s $aapath/$software_folder $software_home


