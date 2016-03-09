#!/bin/bash
script=$(readlink -f "$0")
scriptpath=$(dirname "$script")
source $scriptpath/config.`hostname`

$scriptpath/software-untar.sh $kafka_home $kafka_folder $kafka_jar

echo mkdir $kafka_log_dir
mkdir -p $kafka_log_dir

echo set $kafka_home/conf/server.properties
i=1
declare -a kafka_servers_cwp=\(\"${kafka_servers//,/\" \"}\"\)
for server in "${kafka_servers_cwp[@]}"
do
echo broker.id=${i}                        > $kafka_home/conf/server.properties
let i++
done

echo num.network.threads=3                  >> $kafka_home/conf/server.properties
echo num.io.threads=8                       >> $kafka_home/conf/server.properties
echo num.partitions=2                       >> $kafka_home/conf/server.properties
echo log.dirs=$kafka_log_dir                >> $kafka_home/conf/server.properties

i=1
declare -a zookeeper_servers_cwp=\(\"${zookeeper_servers//,/\" \"}\"\)
for server in "${zookeeper_servers_cwp[@]}"
do
if [ $i eq 1 ] 
then
  zookeeper_connect=${server}:${zookeeper_port}  
else
  zookeeper_connect=${zookeeper_connect},${server}:${zookeeper_port}   
fi  
let i++                   
done
echo zookeeper.connect=${zookeeper_connect} >> $kafka_home/conf/server.properties


$scriptpath/command-with-text.sh " ls -l $kafka_home"
$scriptpath/command-with-text.sh " ls -l $aapath | grep $kafka_folder"
$scriptpath/command-with-text.sh " cat $kafka_home/conf/server.properties"

echo setup kafka is finished on `hostname`

