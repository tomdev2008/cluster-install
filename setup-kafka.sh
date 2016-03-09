#!/bin/bash
script=$(readlink -f "$0")
scriptpath=$(dirname "$script")
source $scriptpath/config.`hostname`

$scriptpath/software-untar.sh $kafka_home $kafka_folder $kafka_jar


$scriptpath/command-with-text.sh " ls -l $kafka_home"
$scriptpath/command-with-text.sh " ls -l $aapath | grep $kafka_folder"


echo setup kafka is finished on `hostname`

