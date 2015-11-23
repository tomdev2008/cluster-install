#!/bin/bash
script=$(readlink -f "$0")
scriptpath=$(dirname "$script")
source $scriptpath/config.sh

orignaluser=$1
orignalpassword=$2

for server in "${servers_cwp[@]}"
do
  echo $server 
  ~/cluster/cluster-install/create-user.sh $server $orignaluser $orignalpassword $user $password
done

