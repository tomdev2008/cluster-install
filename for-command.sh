#!/bin/bash
script=$(readlink -f "$0")
scriptpath=$(dirname "$script")
source $scriptpath/config.sh


servers1=$1
command=$2

declare -a servers_cwp1=\(\"${servers1//,/\" \"}\"\)

rm -rf $slaves
for server in "${servers_cwp1[@]}"
do
command1=\"$command\"
echo ssh $user@$server $command1
ssh $user@$server $command1
done

