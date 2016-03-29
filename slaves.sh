#!/bin/bash
script=$(readlink -f "$0")
scriptpath=$(dirname "$script")
source $scriptpath/config.`hostname`

slaves=$1
master1=${2:-$master}
servers1=${3:-$servers}

declare -a servers_cwp1=\(\"${servers1//,/\" \"}\"\)

rm -rf $slaves

if [ $master1=$servers1 ] 
then
  echo $master1 >> $slaves
fi
for server in "${servers_cwp1[@]}"
do
  if [ $server != $master1 ]
  then
    echo $server >> $slaves
  fi
done









