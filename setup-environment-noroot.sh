#!/bin/bash
script=$(readlink -f "$0")
scriptpath=$(dirname "$script")
cp $scriptpath/config.`hostname`.sh $scriptpath/config.sh
source $scriptpath/config.sh

previouspath=`pwd`
cd $sourcepath/..
sourcefolder=$(basename $sourcepath)
tar -cf $softwarepath/cluster-install.tar $sourcefolder -C ./software
tar --delete -f $softwarepath/cluster-install.tar   cluster-install/.git
cd $previouspath


for server in "${servers_cwp[@]}"
do
  echo ============server=$server user=$user============
  ssh $user@$server rm -rf $targetpath 
  scp $softwarepath/$sourcefolder.tar $user@$server:$copypath
  ssh $user@$server tar xf $copypath/$sourcefolder.tar -C $copypath
  ssh $user@$server rm -rf $copypath/$sourcefolder.tar
done




