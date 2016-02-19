#!/bin/bash
script=$(readlink -f "$0")
scriptpath=$(dirname "$script")
cp $scriptpath/config.`hostname` $scriptpath/config.sh
source $scriptpath/config.`hostname`


for server in "${servers_cwp[@]}"
do
  echo $server 
  ~/cluster/cluster-install/without-password.sh $server $user $password $master
  scp $user@$server:~/.ssh/id_rsa.pub $scriptpath/id_rsa.pub.$server  
  cat $scriptpath/id_rsa.pub.$server >>~/.ssh/authorized_keys
  rm -rf $scriptpath/id_rsa.pub.$server
done

for server in "${servers_cwp[@]}"
do
  ssh $user@$server echo ssh $user@$server successfully
done

